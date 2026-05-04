<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Αρχική Σελίδα</title>
</head>
<body>
    <h1>Σύστημα Αεροπορικών Εταιρειών</h1>
    
    <hr>
    <h3>Ερώτημα 1: Εύρεση Εταιρείας ανά Ηλικία</h3>
    <form action="/query1" method="post">
        Ηλικία από: <input type="number" name="age_min" required>
        έως: <input type="number" name="age_max" required>
        <button type="submit">Αναζήτηση</button>
    </form>
</body>
</html>