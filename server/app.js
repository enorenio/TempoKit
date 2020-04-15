const express = require('express');
// const config = require('config');
const app = express();

// Routes
const user = require('./api/user');

// Middlewares
app.use(express.json());
app.use('/api/user', user);

app.get('/', (req, res) => {
  res.status(200).send('<h1>Hello world!!!</h1>');
});

const port = process.env.PORT || 5000;
app.listen(port, () => console.log(`Listening on port ${port}...`));
