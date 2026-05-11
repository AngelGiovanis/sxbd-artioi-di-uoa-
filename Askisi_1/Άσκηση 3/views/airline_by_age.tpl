<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Εύρεση ανά Ηλικία</title>
    <style>
        body { font-family: sans-serif; background-color: #f4f6f9; text-align: center; padding: 40px; }
        .form-box { background: white; padding: 30px; border-radius: 10px; display: inline-block; box-shadow: 0 4px 8px rgba(0,0,0,0.1); text-align: left; width: 400px; margin-bottom: 30px;}
        input { padding: 8px; margin: 10px 0 20px 0; border-radius: 4px; border: 1px solid #ccc; width: 100%; box-sizing: border-box;}
        button { background-color: #007bff; color: white; border: none; padding: 10px 15px; border-radius: 5px; cursor: pointer; width: 100%; font-weight: bold;}
        .result-box { background: #e9f7ef; padding: 20px; border-radius: 8px; border: 1px solid #28a745; display: inline-block; text-align: left; margin-top: 20px; }
        .back-link { display: block; margin-top: 20px; color: #007bff; text-decoration: none; }
    </style>
</head>
<body>
    <div class="form-box">
        <h2>Εύρεση Εταιρείας ανά Ηλικία</h2>
        <form action="/findAirlinebyAge" method="post">
            <label>Ελάχιστη Ηλικία (Χ):</label>
            <input type="number" name="age_min" required>
            <label>Μέγιστη Ηλικία (Υ):</label>
            <input type="number" name="age_max" required>
            <button type="submit">Αναζήτηση</button>
        </form>
        <a href="/" class="back-link">← Επιστροφή στο Μενού</a>
    </div>

    % if searched:
        <div style="margin-top: 20px;">
            % if result:
                <div class="result-box">
                    <h3>Αποτελέσματα:</h3>
                    <p><b>Αεροπορική Εταιρεία:</b> {{result['name']}}</p>
                    <p><b>Πλήθος Ταξιδιωτών:</b> {{result['passengers']}}</p>
                    <p><b>Πλήθος Αεροσκαφών:</b> {{result['airplanes']}}</p>
                </div>
            % else:
                <p style="color: red;">Δεν βρέθηκαν δεδομένα για αυτό το εύρος ηλικιών.</p>
            % end
        </div>
    % end
</body>
</html>