const express = require('express');
const bodyParser = require('body-parser');
const session = require('express-session');
const cors = require('cors');
const methodOver = require('method-override');
const bcrypt = require('bcrypt');
const mysql = require("mysql");
const connection= mysql.createConnection({
    host: "127.0.0.1",
    user: "root", 
    password :  "",
    database: 'mendezengineering'
});
connection.connect((err)=>{
    if(err) throw err;
    console.log("Database Connected!");
});
const app = express();
app.use(bodyParser.json());
app.use(cors())
app.use(bodyParser.urlencoded({extended: false}));
app.use(methodOver("_method"));

app.get('/',(req,res)=>{
    var xd;
    connection.query("SELECT * FROM users", (err, response) => {
       xd = response;
       console.log(xd);
       res.send(xd);
    })
    
})
app.listen(3000);