<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Επισκέπτες Αεροδρομίου</title>
    <style>
        body { font-family: sans-serif; background-color: #f4f6f9; text-align: center; padding: 40px; }
        .form-box { background: white; padding: 30px; border-radius: 10px; display: inline-block; box-shadow: 0 4px 8px rgba(0,0,0,0.1); text-align: left; width: 400px; margin-bottom: 30px;}
        input, select { padding: 8px; margin: 10px 0 20px 0; border-radius: 4px; border: 1px solid #ccc; width: 100%; box-sizing: border-box;}
        button { background-color: #7307a4; color: white; border: none; padding: 10px 15px; border-radius: 5px; cursor: pointer; width: 100%; font-weight: bold;}
        button:hover { background-color: #650690; }
        .back-link { display: block; margin-top: 20px; color: #7307a4; text-decoration: none; text-align: center;}
        
        table { width: 80%; margin: 0 auto; border-collapse: collapse; background-color: white; box-shadow: 0 4px 8px rgba(0,0,0,0.1); }
        th, td { padding: 12px; border-bottom: 1px solid #ddd; text-align: center; }
        th { background-color: #28a745; color: white; }
        tr:hover { background-color: #f1f1f1; }
    </style>
</head>
<body>
    
    <div class="form-box">
        <h2 style="text-align: center;">Επισκέπτες Αεροδρομίου</h2>
        <form action="/findAirportVisitors" method="post">
            
            <label>Επιλέξτε Εταιρεία:</label>
            <!-- Δυναμικό Dropdown Μενού αντί για απλό κείμενο -->
            <select name="airline_name" required>
                <option value="" disabled selected>Επιλέξτε από τη λίστα...</option>
                % for airline in airlines:
                    <option value="{{airline['name']}}">{{airline['name']}}</option>
                % end
            </select>
            
            <label>Από Ημερομηνία:</label>
            <input type="date" name="date_start" required>
            
            <label>Έως Ημερομηνία:</label>
            <input type="date" name="date_end" required>

            <button type="submit">Αναζήτηση</button>
        </form>
        <a href="/" class="back-link">← Επιστροφή στο Μενού</a>
    </div>

    % if searched:
        <hr style="border: 0; border-top: 1px solid #ccc; margin: 20px 0;">
        <h3 style="color: #333;">Αποτελέσματα Αναζήτησης:</h3>
        
        % if results:
            <table>
                <thead>
                    <tr>
                        <th>Όνομα Αεροδρομίου</th>
                        <th>Συνολικοί Επισκέπτες</th>
                    </tr>
                </thead>
                <tbody>
                    % for row in results:
                    <tr>
                        <td>{{row['airport_name']}}</td>
                        <td>{{row['total_visitors']}}</td>
                    </tr>
                    % end
                </tbody>
            </table>
        % else:
            <p style="color: red; font-weight: bold;">Δεν βρέθηκαν αποτελέσματα για αυτά τα κριτήρια.</p>
        % end
    % end

</body>
</html>