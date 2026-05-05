from bottle import route, run, template, request
from get_connection import get_connection

@route('/')
def home():
    return template('index')

@route('/findAirlinebyAge', method='POST')
def handle_query1():
    # Take input data from HTML
    min_age = request.forms.get('age_min')
    max_age = request.forms.get('age_max')
    
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
                return "Δεν βρέθηκαν επιβάτες σε αυτό το ηλικιακό εύρος."
            
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

            # Display result
            return f"""
                <h3>Αποτελέσματα:</h3>
                <b>Εταιρεία:</b> {top_airline['airline_name']} <br>
                <b>Πλήθος Ταξιδιωτών:</b> {top_airline['total_passengers']} <br>
                <b>Πλήθος Αεροσκαφών:</b> {airplanes_result['total_airplanes']}
            """

    except Exception as e:
        return f"Connection/SQL Error: {e}"
    finally:
        # Close connection
        if conn:
            conn.close()

if __name__ == "__main__":
    run(host='localhost', port=8080, debug=True, reloader=True)