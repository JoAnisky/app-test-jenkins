const express = require('express');
const app = express();
const port = 8080;

app.get('/', (req, res) => {
    res.send('Test du Webhook Git!');
});

app.listen(port, () => {
    console.log(`App listening at https://app.jonathanlore.fr:${port}`);
});
