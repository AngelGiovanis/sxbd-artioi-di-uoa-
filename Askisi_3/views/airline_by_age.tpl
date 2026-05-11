<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Εύρεση ανά Ηλικία</title>
    <style>
        body { font-family: sans-serif; background-color: #f4f6f9; text-align: center; padding: 40px; }
        .form-box { background: white; padding: 30px; border-radius: 10px; display: inline-block; box-shadow: 0 4px 8px rgba(0,0,0,0.1); text-align: left; width: 400px; margin-bottom: 30px;}
        input { padding: 8px; margin: 10px 0 20px 0; border-radius: 4px; border: 1px solid #ccc; width: 100%; box-sizing: border-box;}
        button { background-color: #7307a4; color: white; border: none; padding: 10px 15px; border-radius: 5px; cursor: pointer; width: 100%; font-weight: bold;}
        button:hover { background-color: #650690; }
        .back-link { display: block; margin-top: 20px; color: #7307a4; text-decoration: none; text-align: center;}
        
        table { width: 80%; margin: 0 auto; border-collapse: collapse; background-color: white; box-shadow: 0 4px 8px rgba(0,0,0,0.1); }
        th, td { padding: 12px; border-bottom: 1px solid #ddd; text-align: center; }
        th { background-color: #28a745; color: white; }
        tr:hover { background-color: #f1f1f1; }
        .error-msg { color: #dc3545; font-weight: bold; background: #f8d7da; padding: 15px; border-radius: 5px; border: 1px solid #f5c6cb; display: inline-block; }
    </style>
</head>
<body>
    <div class="form-box">
        <h2 style="text-align: center;">Εύρεση Εταιρείας ανά Ηλικία</h2>
        <form action="/findAirlinebyAge" method="post">
            <label>Ελάχιστη Ηλικία:</label>
            <input type="number" name="age_min" required>
            
            <label>Μέγιστη Ηλικία:</label>
            <input type="number" name="age_max" required>
            
            <button type="submit">Αναζήτηση</button>
        </form>
        <a href="/" class="back-link">← Επιστροφή στο Μενού</a>
    </div>

    % if searched:
        <hr style="border: 0; border-top: 1px solid #ccc; margin: 20px 0;">
        
        % if error:
            <div class="error-msg">{{error}}</div>
        % elif result:
            <h3 style="color: #333;">Αποτελέσματα Αναζήτησης:</h3>
            <table>
                <thead>
                    <tr>
                        <th>Αεροπορική Εταιρεία</th>
                        <th>Πλήθος Ταξιδιωτών</th>
                        <th>Πλήθος Αεροσκαφών</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>{{result['name']}}</td>
                        <td>{{result['passengers']}}</td>
                        <td>{{result['airplanes']}}</td>
                    </tr>
                </tbody>
            </table>
        % else:
            <h3 style="color: #333;">Αποτελέσματα Αναζήτησης:</h3>
            <p style="color: #666; font-weight: bold;">Δεν βρέθηκαν δεδομένα για αυτό το εύρος ηλικιών.</p>
        % end
    % end
</body>
</html>