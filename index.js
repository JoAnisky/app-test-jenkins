const express = require('express');
const app = express();
const port = 8080;

app.get('/', (req, res) => {
    res.send('Hello from the containerized app!');
});

app.listen(port, () => {
    console.log(`App listening at https://app.jonathanlore.fr:${port}`);
});
