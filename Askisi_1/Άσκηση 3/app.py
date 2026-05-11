from bottle import route, run, template, request
from get_connection import get_connection

@route('/')
def home():
    return template('index')

# ----- findAirlinebyAge -----
@route('/findAirlinebyAge', method=['GET', 'POST'])
def airline_by_age():
    if request.method == 'GET':
        # Show template
        return template('airline_by_age', searched=False, result=None)
    
    # Take input data from HTML
    try:
        min_age = int(request.forms.get('age_min'))
        max_age = int(request.forms.get('age_max'))
    except (ValueError, TypeError):
        return template('airline_by_age', searched=True, result=None, error="Σφάλμα: Μη έγκυροι αριθμοί ηλικίας.")

    if min_age >= max_age:
        return template('airline_by_age', searched=True, result=None, error="Η ελάχιστη ηλικία πρέπει να είναι μικρότερη από τη μέγιστη.")

    conn = None
    try:
        conn = get_connection()
        # Create a cursor
        with conn.cursor() as cursor:

            # Find passengers by airline
            sql_passengers = """
                SELECT a.name as airline_name, COUNT(p.id) AS total_passengers, a.id as airline_id
                FROM airlines a, routes r, flights f, flights_has_passengers fhp, passengers p
                WHERE a.id = r.airlines_id 
                  AND r.id = f.routes_id 
                  AND f.id = fhp.flights_id 
                  AND fhp.passengers_id = p.id
                  AND (2026 - p.year_of_birth) > %s 
                  AND (2026 - p.year_of_birth) < %s
                GROUP BY a.id, a.name
            """

            # Send the query to the database
            cursor.execute(sql_passengers, (min_age, max_age))

            # Receive back the results
            results = cursor.fetchall()

            # If no flight that fits the criteria got found
            if not results:
                return template('airline_by_age', searched=True, result=None)
            
            # Look for the maximum result
            top_airline = max(results, key=lambda x: x['total_passengers'])

            # Count the airline's aircrafts
            sql_airplanes = """
                SELECT COUNT(airplanes_id) as total_airplanes
                FROM airlines_has_airplanes
                WHERE airlines_id = %s
            """
            cursor.execute(sql_airplanes, (top_airline['airline_id'],))

            # Receive back the result
            airplanes_result = cursor.fetchone()

            final_data = {
                'name': top_airline['airline_name'],
                'passengers': top_airline['total_passengers'],
                'airplanes': airplanes_result['total_airplanes']
            }
            return template('airline_by_age', searched=True, result=final_data, error=None)

    except Exception as e:
        return f"Connection/SQL Error: {e}"
    finally:
        # Close connection
        if conn:
            conn.close()

# ----- findAirportVisitors -----
@route('/findAirportVisitors', method=['GET', 'POST'])
def airport_visitors():
    conn = None
    try:
        conn = get_connection()
        # Create a cursor
        with conn.cursor() as cursor:
            # Send the query to the database for airlines list
            cursor.execute("SELECT name FROM airlines ORDER BY name")
            # Receive back the results
            airlines_list = cursor.fetchall()
        
            if request.method == 'GET':
                # Show form
                return template('airport_visitors', searched=False, results=None, airlines=airlines_list)

            # Take input data from HTML                
            airline_name = request.forms.get('airline_name')
            date_start = request.forms.get('date_start')
            date_end = request.forms.get('date_end')

            # Find total visitors by airport
            sql = """
            SELECT ap.name AS airport_name, COUNT(fhp.passengers_id) AS total_visitors
            FROM airlines a, routes r, flights f, flights_has_passengers fhp, airports ap
            WHERE a.name = %s
                AND a.id = r.airlines_id
                AND r.id = f.routes_id
                AND f.id = fhp.flights_id
                AND r.destination_id = ap.id
                AND f.date >= %s
                AND f.date <= %s
            GROUP BY ap.id, ap.name
            """
                        
            # Send the query to the database            
            cursor.execute(sql, (airline_name, date_start, date_end))

            # Receive back the results
            results = cursor.fetchall()

            # Order results
            results.sort(key=lambda x: x['total_visitors'], reverse=True)

            return template('airport_visitors', searched=True, results=results, airlines=airlines_list)
        
    except Exception as e:
        return f"Connection/SQL Error: {e}"
    finally:
        # Close connection
        if conn:
            conn.close()

if __name__ == "__main__":
    run(host='localhost', port=8080, debug=True, reloader=True)