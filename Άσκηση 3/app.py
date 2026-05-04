from bottle import route, run, template, request
from get_connection import get_connection

@route('/')
def home():
    return template('index')

@route('/query1', method='POST')
def handle_query1():
    min_age = request.forms.get('age_min')
    max_age = request.forms.get('age_max')
    
    try:
        conn = get_connection()
        # To be added
        conn.close()
        return f"Connected Successfully"
    except Exception as e:
        return f"Connection Error: {e}"

if __name__ == "__main__":
    run(host='localhost', port=8080, debug=True, reloader=True)