const mysql = require("mysql");
const config = require("config");

let sql = mysql.createConnection(config.get("dbConfig"));

sql.connect(function (err) {
	if (err) throw err;
	console.log("SQL connected...");
});

module.exports = sql;