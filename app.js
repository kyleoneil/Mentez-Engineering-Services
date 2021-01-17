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
app.get('/dashboard/montly',(req,res)=>{
    let date = new Date();
    let month = date.getMonth()+1;
    let year = date.getFullYear();
    let start = year+'-'+month+'-'+'1';
    let end = year+'-'+month+'-'+'31';
    console.log(start);
    console.log(end);
     connection.query("SELECT SUM(Amount) FROM billings WHERE Date BETWEEN '?' AND '?'",[start,end],(err,result)=>{
       console.log(result);
       res.json(result);
     })
    
 })
app.get('/materials',(req,res)=>{
    if(req.session.loggedIn){
        connection.query("SELECT * FROM materials"),(err,result)=>{
            res.json({data:result});
        }
    }else{
        res.redirect('/login')
    }
})
app.post('/materials',urlencodedParser,(req,res)=>{
    if(req.session.loggedIn){
        connection.query("INSERT INTO materials VALUES (?,?)"),(err,result)=>{

        }
    }else{
        res.redirect('/login')
    }
})
app.get('/materials/:id',(req,res)=>{
    let id = req.params.id;
    if(req.session.loggedIn){
        connection.query("SELECT * FROM materials WHERE MatID=?"),id,(err,result)=>{
            res.json({data:result});
        }
    }else{
        res.redirect('/login')
    }
})
app.put('/materials/:id/edit',urlencodedParser,(req,res)=>{
    if(req.session.loggedIn){

    }else{
        res.redirect('/login')
    }
})
app.delete('/materials/:id/delete',urlencodedParser,(req,res)=>{
    if(req.session.loggedIn){

    }else{
        res.redirect('/login')
    }
})
app.get('/subcontractors',(req,res)=>{
    if(req.session.loggedIn){
        connection.query("SELECT * FROM subcontractors"),(err,result)=>{
            res.json({data:result});
        }
    }else{
        res.redirect('/login')
    }
})
app.get('/projects',(req,res)=>{
    if(req.session.loggedIn){
        connection.query("SELECT * FROM project"),(err,result)=>{
            res.json({data:result});
        }
    }else{
        res.redirect('/login')
    }
})
app.get('/projects/:id',(req,res)=>{
    let id = req.params.id;
    if(req.session.loggedIn){
        connection.query("SELECT * FROM project WHERE ProjectID=?"),id,(err,result)=>{
            res.json({data:result});
        }
    }else{
        res.redirect('/login')
    }
})
app.put('/projects/:id/edit',(req,res)=>{
    if(req.session.loggedIn){

    }else{
        res.redirect('/login')
    }
})
app.delete('/projects/:id/delete',(req,res)=>{
    if(req.session.loggedIn){

    }else{
        res.redirect('/login')
    }
})

app.listen(3000, () => {
    console.log('Example app listening on port 3000!')
});
