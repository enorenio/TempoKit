const express = require("express");
const router = express.Router();
const sql = require("../database/db");

router.get("/", async (req, res) => {
	let query = "Select * from student";
	sql.query(query, function (err, result) {
		if (err) throw err;
		console.log(result[0]);
	    res.send(result);
	});
});

module.exports = router;