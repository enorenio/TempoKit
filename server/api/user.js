const express = require('express');
const sql = require('../database/db');

const router = express.Router();

router.get('/', async (req, res) => {
  const query = 'Select * from student';
  sql.query(query, (err, result) => {
    if (err) throw err;
    console.log(result[0]);
    res.send(result);
  });
});

module.exports = router;
