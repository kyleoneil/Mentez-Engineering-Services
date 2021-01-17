const express = require('express');
const bodyParser = require('body-parser');
const session = require('express-session');
const mysql = require('mysql');
const cors = require('cors');
const methodOver = require('method-override');
const bcrypt = require('bcrypt');
const saltR = 10;
const empty = require("is-empty");
const urlencodedParser = bodyParser.urlencoded({extended: false});

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

app.use(session({
    secret: "Ch43y0Vn6Num84W4N",
    saveUninitialized: true,
    resave: true
}));

app.post('/login/user',urlencodedParser,(req,res)=>{
    var xd;
    let user = req.body.username;
    let pass = req.body.password;
   
   
    let salt = bcrypt.genSaltSync(saltR);
    let hash = bcrypt.hashSync(pass,salt);

    connection.query('SELECT username FROM users WHERE username ="'+user+'"', (err, result)=> {
    
	if(empty(result)){
            res.json({message:"Account does not exist"});
        }else{
            connection.query('SELECT Username, Password,UserID FROM users WHERE Username ="'+user+'"',(err,result)=>{       
            
                let check = bcrypt.compareSync(pass,result[0]['Password']);      
                if(check){
                    req.session.loggedIn = true;
                    res.json({id:result[0]['UserID']});
                }else if(pass==result[0]['Password']){
                    req.session.loggedIn = true;
                    res.json({id:result[0]['UserID']});
                }else{ 
                    res.status(400).json({message:"Incorrect Password"});
                }
            })
        }
    })
    
})

app.post('/register/add',urlencodedParser,(req,res)=>{
    var user = req.body.username;
    var pass = req.body.password;
    let uuid = generateUUID();
    let salt = bcrypt.genSaltSync(saltR);
    let hash = bcrypt.hashSync(pass,salt);
    connection.query('INSERT INTO users(Username, Password) SELECT "'+user+'","'+hash+'" WHERE NOT EXISTS (SELECT Username FROM users WHERE Username="'+user+'")',(err,result)=>{
        if(result.affectedRows == 0){
           res.status(400).json({status:0,message:"Accound Exists"});
        }else{
           res.json({status:1,message:"Account Created"});
        }
    })
   
})
app.get('/dashboard/quotation',(req,res)=>{
    
   console.log("xd")
    connection.query('SELECT Q.QuoID,Q.summation,Q.created,PT.ProjDesc,U.Username FROM quotation Q JOIN users U ON Q.UserID = U.UserID JOIN project P ON Q.ProjectID = P.ProjectID JOIN project_type PT ON P.ProjTypeID = PT.ProjTypeID',(err,result)=>{
      console.log(result);
      res.json(result);
    })
   
})

app.listen(3000, () => {
    console.log('Example app listening on port 3000!')
});
