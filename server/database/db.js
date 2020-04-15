const mysql = require('mysql');
const config = require('config');

const sql = mysql.createConnection(config.get('dbConfig'));

sql.connect((err) => {
  if (err) throw err;
  console.log('SQL connected...');
});

module.exports = sql;
