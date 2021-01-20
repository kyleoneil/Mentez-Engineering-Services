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

app.post('/login',urlencodedParser,(req,res)=>{
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

app.post('/register',urlencodedParser,(req,res)=>{
    var user = req.body.username;
    var pass = req.body.password;
    let uuid = generateUUID();
    let salt = bcrypt.genSaltSync(saltR);
    let hash = bcrypt.hashSync(pass,salt);
    connection.query('INSERT INTO users(Username, Password) SELECT "'+user+'","'+hash+'" WHERE NOT EXISTS (SELECT Username FROM users WHERE Username="'+user+'")',(err,result)=>{
        if(result.affectedRows == 0){
           res.status(400).json({status:0,message:"Account Exists"});
        }else{
           res.json({status:1,message:"Account Created"});
        }
    })
   
})
app.get('/dashboard/quotation',(req,res)=>{
    if(req.session.loggedIn){
        console.log("xd")
        connection.query('SELECT Q.QuoID,Q.summation,Q.created,PT.ProjDesc,U.Username FROM quotation Q JOIN users U ON Q.UserID = U.UserID JOIN project P ON Q.ProjectID = P.ProjectID JOIN project_type PT ON P.ProjTypeID = PT.ProjTypeID',(err,result)=>{
        console.log(result);
        res.json(result);
    })
    }else{
        res.status(400).send({message:"Session Timeout"})
    }
 
   
})
app.get('/dashboard/quotation/:id',(req,res)=>{
    let id = req.params.id;
    // if(req.session.loggedIn){
        connection.query('SELECT Q.QuoID,Q.summation,Q.created,PT.ProjDesc,group_concat(S.subName) AS subcontractors FROM quotation Q JOIN project P ON Q.ProjectID = P.ProjectID AND Q.QuoID=? JOIN project_type PT ON P.ProjTypeID = PT.ProjTypeID JOIN sub_contractors S ON S.SubListID=Q.QuoID GROUP BY Q.QuoID',id,(err,result)=>{
        console.log(result);
        res.json(result);
    })
    // }else{
    //     res.status(400).send({message:"Session Timeout"})
    // }
 
   
})

app.get('/quotation',(req,res)=>{
    // if(req.session.loggedIn){
        connection.query('SELECT Q.QuoID,Q.summation,Q.created,PT.ProjDesc,PT.ProjType,U.Username,C.CustName FROM quotation Q JOIN customers C ON Q.CustID=C.CustID JOIN users U ON Q.UserID = U.UserID JOIN project P ON Q.ProjectID = P.ProjectID JOIN project_type PT ON P.ProjTypeID = PT.ProjTypeID ',(err,result)=>{
        console.log(result);
        res.json(result);
    })
    // }else{
    //     res.status(400).send({message:"Session Timeout"})
    // }
 
   
})
app.post('/quotation',(req,res)=>{
    // if(req.session.loggedIn){
    connection.query('INSERT INTO project_site SET City=?,Barangay=?,StreetNumber=?,PostalCode=?',[],(err,result)=>{
        connection.query('INSERT INTO project_type SET ProjDesc=?,ProjType=?',[],(err,type)=>{
            connection.query('INSERT INTO mat_list SET TotalListPrice=?',[],(err,mat)=>{
                connection.query('INSERT INTO project SET ProjSiteID=?,ProjTypeID=?,MatListID=?,ProjStart=?,ProjEnd=?',[result.ProjSiteID,type.ProjTypeID,mat.MatListID],(err,project)=>{
                    connection.query('INSERT INTO customers SET CustName=?',[],(err,cust)=>{
                        connection.query('INSERT INTO quotation SET summation=?,DeliveryCharges=?,LaborCharges=?,BendingCharges=?,created=?,updated=?,CustID=?,ProjectID=?,UserID=?',[cust.CustID,ProjID],(err,quot)=>{
                            console.log(quot);
                        })
                    })
                })
            })
        })
    })
    // }else{
    //     res.status(400).send({message:"Session Timeout"})
    // }
 
   
})
app.delete('/quotation/:id',(req,res)=>{
    let id = req.params.id;
    connection.query('UPDATE quotation SET deleted=1 WHERE id=?',id,(err,result)=>{
        if(result.affectedRows != 0){
            res.json({status:1,message:"Quotation Deleted"});
        }
    })
})
app.get('/dashboard/monthly',(req,res)=>{
    let date = new Date();
    let month = date.getMonth()+1;
    let year = date.getFullYear();
    let start = year+'-'+month+'-'+1;
    let end = year+'-'+month+'-'+31;
     connection.query("SELECT SUM(Amount) FROM billings WHERE Date BETWEEN ? AND ?",[start,end],(err,result)=>{
         console.log(err);
       res.json(result);
     })
    
 })
 app.get("/material/categories",(req,res)=>{
    if(req.session.loggedIn){
        connection.query("SELECT ServiceName FROM services",(err,result)=>{
            console.log(err);
            res.json(result);
        })
    }else{
        res.status(400).send({message:"Session Timeout"})
    }
 })

 app.get("/material/categories/:id",(req,res)=>{

    if(req.session.loggedIn){
        console.log(req.params.id);
        connection.query("SELECT MatDetailsID, MatDescription, MatName, MatPrice FROM mat_details WHERE ServiceID="+req.params.id,(err,result)=>{
            console.log(err);
            res.json(result);
        })
    }else{
        res.status(400).send({message:"Session Timeout"})
    }
 })

app.get('/materials',(req,res)=>{
    if(req.session.loggedIn){
        connection.query("SELECT * FROM materials"),(err,result)=>{
            res.json({data:result});
        }
    }else{
        res.status(400).send({message:"Session Timeout"})
    }
})
app.post('/materials',urlencodedParser,(req,res)=>{
    if(req.session.loggedIn){
        connection.query("INSERT INTO materials VALUES (?,?)"),(err,result)=>{

        }
    }else{
        res.status(400).send({message:"Session Timeout"})
    }
})
app.get('/materials/:id',(req,res)=>{
    let id = req.params.id;
    if(req.session.loggedIn){
        connection.query("SELECT * FROM materials WHERE MatID=?"),id,(err,result)=>{
            res.json({data:result});
        }
    }else{
        res.status(400).send({message:"Session Timeout"})
    }
})
app.put('/materials/:id/edit',urlencodedParser,(req,res)=>{
    if(req.session.loggedIn){

    }else{
        res.status(400).send({message:"Session Timeout"})
    }
})
app.delete('/materials/:id/delete',urlencodedParser,(req,res)=>{
    if(req.session.loggedIn){

    }else{
        res.status(400).send({message:"Session Timeout"})
    }
})
app.get('/subcontractors',(req,res)=>{
    if(req.session.loggedIn){
        connection.query("SELECT * FROM subcontractors"),(err,result)=>{
            res.json({data:result});
        }
    }else{
        res.status(400).send({message:"Session Timeout"})
    }
})
app.get('/projects',(req,res)=>{
    if(req.session.loggedIn){
        connection.query("SELECT * FROM project"),(err,result)=>{
            res.json({data:result});
        }
    }else{
        res.status(400).send({message:"Session Timeout"})
    }
})
app.get('/projects/:id',(req,res)=>{
    let id = req.params.id;
    if(req.session.loggedIn){
        connection.query("SELECT * FROM project WHERE ProjectID=?"),id,(err,result)=>{
            res.json({data:result});
        }
    }else{
        res.status(400).send({message:"Session Timeout"})
    }
})
app.put('/projects/:id/edit',(req,res)=>{
    if(req.session.loggedIn){

    }else{
        res.status(400).send({message:"Session Timeout"})
    }
})
app.delete('/projects/:id/delete',(req,res)=>{
    if(req.session.loggedIn){

    }else{
        res.status(400).send({message:"Session Timeout"})
    }
})

app.listen(3000, () => {
    console.log('Example app listening on port 3000!')
});
