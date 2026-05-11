<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Σύστημα Ανάλυσης Αεροπορικών Δεδομένων</title>
    <style>
        body { 
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; 
            background-color: #f4f6f9; 
            color: #333; text-align: center; padding: 40px; 
        }
        h1 { color: #2c3e50; margin-bottom: 40px; }
        
        .dashboard { display: flex; justify-content: center; gap: 30px; flex-wrap: wrap; }

        .card {
            background: white; 
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            padding: 15px 30px;
            width: 300px;
            transition: transform 0.2s, box-shadow 0.2s;
            
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            min-height: 180px;
        }

        .card h3 { 
            color: #000000; 
            margin: 0;
        }

        .card p { 
            font-size: 14px; 
            color: #666; 
            line-height: 1.5; 
            margin: 20px 0;
        }

        button {
            background-color: #7307a4; color: white; border: none;
            padding: 12px 20px; border-radius: 6px; cursor: pointer;
            font-size: 15px; width: 100%; font-weight: bold;
        }
        button:hover { background-color: #650690; }
    </style>
</head>
<body>

    <h1>Σύστημα Ανάλυσης Αεροπορικών Δεδομένων</h1>
    
    <div class="dashboard">
        <!-- findAirlinebyAge -->
        <div class="card">
            <h3>1. Εύρεση ανά Ηλικία</h3>
            <p>Βρείτε την εταιρεία με τους περισσότερους επιβάτες σε συγκεκριμένο ηλικιακό εύρος.</p>
            <a href="/findAirlinebyAge"><button>Επιλογή</button></a>
        </div>

        <!-- findAirportVisitors -->
        <div class="card">
            <h3>2. Επισκέπτες Αεροδρομίου</h3>
            <p>Βρείτε τους συνολικούς επισκέπτες ανά αεροδρόμιο για μία αεροπορική εταιρεία μεταξύ συγκεκριμένων ημερομηνιών.</p>
            <a href="/findAirportVisitors"><button>Επιλογή</button></a>
        </div>
    </div>

</body>
</html>