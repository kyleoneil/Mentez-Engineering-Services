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
    resave: false
}));


//=================================================================LOGIN/REGISTER/USERS==================================================================================//



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
                    res.json({userid:result[0]['UserID'],status:200});
                }else if(pass==result[0]['Password']){
                    req.session.loggedIn = true;
                    res.json({userid:result[0]['UserID'],status:200});
                }else{ 
                    res.status(400).json({message:"Incorrect Password"});
                }
            })
        }
    })
    
})

app.get('/materials/getinstock/status',(req,res)=>{
    console.log("xd");
    if(true){
        console.log("YEOWW")
        connection.query('SELECT * FROM mat_details WHERE MatStatus="IN STOCK"',(err,result)=>{
            res.json({data:result});
        })
    }else{
        res.status(500).send({message:"Session Timeout"})
    }
})

app.post('/register',urlencodedParser,(req,res)=>{
    var user = req.body.data.username;
    var pass = req.body.data.password;
    let name = req.body.data.name;
    let email= req.body.data.email
   
 
    let salt = bcrypt.genSaltSync(saltR);
    let hash = bcrypt.hashSync(pass,salt);
    connection.query('INSERT INTO users(Username, Password, Name, Email,created) SELECT "'+user+'","'+hash+'","'+name+'","'+email+'",CURRENT_TIMESTAMP WHERE NOT EXISTS (SELECT Username FROM users WHERE Username="'+user+'")',(err,result)=>{
        if(result.affectedRows == 0){
           res.status(400).json({status:0,message:"Account Exists"});
        }else{
           res.json({status:1,message:"Account Created"});
        }
    })
   
})
app.get('/users',(req,res)=>{
    // if(req.session.loggedIn){
       
        connection.query('SELECT * FROM users WHERE deleted IS NULL' ,(err,result)=>{
        
        res.json(result);
    })
    // }else{
    //     res.status(400).send({message:"Session Timeout"})
    // }
})
app.get('/users/get',(req,res)=>{
    // if(req.session.loggedIn){
        connection.query('SELECT * FROM users WHERE UserID='+req.query.id+'',(err,result)=>{
      
        res.json(result);
    })
    // }else{
    //     res.status(400).send({message:"Session Timeout"})
    // }
})


app.post('/users/update',urlencodedParser,(req,res)=>{
    // if(req.session.loggedIn){
        let name = req.body.data.Name;
        let email= req.body.data.Email;
        let username= req.body.data.Username;
        let id = req.query.id
        console.log(username)
        connection.query('UPDATE users SET Username="'+username+'", Name="'+name+'",Email="'+email+'" WHERE UserID='+id+'',(err,result)=>{
        console.log(result);
        res.json({message:"Account Updated Successfull"});
    })
    // }else{
    //     res.status(400).send({message:"Session Timeout"})
    // }
})

app.post('/users/delete',urlencodedParser,(req,res)=>{
    // if(req.session.loggedIn){

        let id = req.query.id
        connection.query('UPDATE users SET deleted = CURRENT_TIMESTAMP WHERE UserID='+id+'',(err,result)=>{
        console.log(result);
        console.log(err);
        res.json({message:"Account Removed Successfull"});
    })
    // }else{
    //     res.status(400).send({message:"Session Timeout"})
    // }
})

//=================================================================QUOTATION==================================================================================//

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

app.get('/quotation',(req,res)=>{
    // if(req.session.loggedIn){
        console.log(req.session.loggedIn)
        connection.query('SELECT Q.*,P.ProjectID,PT.ProjDesc,PT.ProjType,PS.*,C.CustName,group_concat(S.subName,"-",SE.ServiceName) AS subcontractors FROM quotation Q JOIN customers C ON Q.CustID=C.CustID JOIN users U ON Q.UserID = U.UserID JOIN project P ON Q.ProjectID = P.ProjectID JOIN project_type PT ON P.ProjTypeID = PT.ProjTypeID JOIN project_site PS ON P.ProjectID=PS.ProjSiteID JOIN sub_contractors_labor SL ON SL.QuoID= Q.QuoID JOIN sub_contractors S ON SL.SubListID=S.SubListID JOIN services SE ON S.ServiceID=SE.ServiceID GROUP BY SL.QuoID',(err,result)=>{
        console.log(result);
        connection.query('SELECT MD.MatName,MD.MatDescription,M.MatQty,MD.MatPrice,P.ProjectID FROM project P JOIN mat_list ML ON P.MatListID= ML.MatListID JOIN materials M ON M.MatListID = ML.MatListID JOIN mat_details MD ON MD.MatDetailsID=M.MatDetailsID',(err,mat)=>{
            res.status(200).json({data:result,materials:mat});
        })
    })
    // }else{
    //     res.status(400).send({message:"Session Timeout"})
    // }
 
   
})
app.get('/quotation/:id',(req,res)=>{
    let id = req.params.id;
    // if(req.session.loggedIn){
        connection.query('SELECT Q.*,P.ProjectID,PT.ProjDesc,PT.ProjType,PS.*,C.CustName,group_concat(S.subName,"-",SE.ServiceName) AS subcontractors FROM quotation Q JOIN customers C ON Q.CustID=C.CustID AND Q.QuoID=? JOIN users U ON Q.UserID = U.UserID JOIN project P ON Q.ProjectID = P.ProjectID JOIN project_type PT ON P.ProjTypeID = PT.ProjTypeID JOIN project_site PS ON P.ProjectID=PS.ProjSiteID JOIN sub_contractors_labor SL ON SL.QuoID= Q.QuoID JOIN sub_contractors S ON SL.SubListID=S.SubListID JOIN services SE ON S.ServiceID=SE.ServiceID GROUP BY SL.QuoID',id,(err,result)=>{
            console.log(result)
            connection.query('SELECT MD.MatName,MD.MatDescription,M.MatQty,MD.MatPrice FROM project P JOIN mat_list ML ON P.MatListID= ML.MatListID AND P.ProjectID=? JOIN materials M ON M.MatListID = ML.MatListID JOIN mat_details MD ON MD.MatDetailsID=M.MatDetailsID',result[0].ProjectID,(err2,mat)=>{

            res.status(200).json({data:result,materials:mat});
        })
        
    })
    // }else{
    //     res.status(400).send({message:"Session Timeout"})
    // }
})
app.post('/quotation/add',urlencodedParser,(req,res)=>{
    // if(req.session.loggedIn){
        var catcher = JSON.stringify(req.body);
        var data = JSON.parse(catcher);
        var wew= new Date().toISOString().replace(/T/, ' ').replace(/\..+/, '')
        console.log(data) 
    connection.query('INSERT INTO project_site SET City=?,Barangay=?,StreetNumber=?,PostalCode=?',[data.project_city,data.project_barangay,data.project_street,data.project_postal_code],(err,projsite)=>{
        connection.query('INSERT INTO project_type SET ProjDesc=?,ProjType=?',[data.proj_description,data.project_type],(err,type)=>{
            connection.query('INSERT INTO mat_list SET TotalListPrice=?',[data.totalListPrice],(err,mat)=>{
                for(let index=0;index<data.materials.length;index++){
                    connection.query('SELECT * FROM mat_details WHERE MatDescription=?',[data.materials[index].material_description],(err2,dets)=>{
                        connection.query('INSERT INTO materials SET MatListID=?,MatDetailsID=?,MatQty=?,TotalPrice=?',[mat.insertId,dets[0].MatDetailsID,data.materials[index].material_quantity,data.materials[index].material_price],(err3,res)=>{})
                        var ham = parseInt(dets[0].MatQuantity)-parseInt(data.materials[index].material_quantity)
                        connection.query('UPDATE mat_details SET MatQuantity=? WHERE MatDetailsID=?',[ham,dets[0].MatDetailsID],(errr,esp)=>{
                        })
                    })
                }
                connection.query('INSERT INTO project SET ProjSiteID=?,ProjTypeID=?,MatListID=?,ProjStart=?,ProjEnd=?',[projsite.insertId,type.insertId,mat.insertId,data.date_from,data.date_until],(err6,project)=>{
                    connection.query('INSERT INTO customers SET CustName=?',[data.customer_name],(err,cust)=>{
                        connection.query('INSERT INTO billings SET amount=?, date=?',[data.amount,wew],(err8,bill)=>{
                            console.log(err8)
                            connection.query('INSERT INTO quotation SET BillID=?,summation=?,DeliveryCharges=?,LaborCharges=?,BendingCharges=?,CustID=?,ProjectID=?,UserID=?,created=CURRENT_TIMESTAMP',[bill.insertId,data.quotation_summation,data.quotation_delivery,data.quotation_labor,data.quotation_bendingcharges,cust.insertId,project.insertId,data.userid],(err7,quot)=>{
                                connection.query('SELECT SC.*,S.ServiceName FROM sub_contractors SC JOIN services S ON  SC.ServiceID = S.ServiceID WHERE SC.SubName=? AND deleted IS NULL',[data.subcontractor_name],(err2,subs)=>{
                                    connection.query('INSERT INTO sub_contractors_labor SET QuoID=?,LaborFee=?',[quot.insertId,data.quotation_labor],(err3,res)=>{
                                        connection.query('INSERT INTO sub_contractors SET ServiceID=?,SubListID=?, Subname=?,created=CURRENT_TIMESTAMP',[data.ServiceID, res.insertId,data.subcontractor_name],(err,result)=>{
                                            console.log(err);
                                            // res.json({data:result});
                                        })
                                    })
                                })
                                
                                res.status(200).json({message: "Quotation Created"})
                            })
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
app.put('/quotation/:id/edit',urlencodedParser,(req,res)=>{
    // if(req.session.loggedIn){
        let id = req.params.id;
        var catcher = JSON.stringify(req.body);
        var data = JSON.parse(catcher);
        var sub=7
        console.log(data)
        var wew= new Date().toISOString().replace(/T/, ' ').replace(/\..+/, '') 
        connection.query('SELECT * FROM quotation WHERE QuoID=?',id,(err,quots)=>{
            connection.query('SELECT * FROM project WHERE ProjectID=?',quots[0].ProjectID,(err2,proj)=>{
                connection.query('UPDATE quotation SET summation=?,DeliveryCharges=?,LaborCharges=?,Bendingcharges=?,updated=CURRENT_TIMESTAMP WHERE QuoID=?',[data.quotation_summation,data.quotation_delivery,data.quotation_labor,data.quotation_bendingcharges,id])
            connection.query('UPDATE project_site SET City=?,Barangay=?,StreetNumber=?,PostalCode=? WHERE ProjSiteID=?',[data.project_city,data.project_barangay,data.project_street,data.project_postal_code,proj[0].ProjSiteID],(err,result)=>{
        connection.query('UPDATE project_type SET ProjDesc=?,ProjType=? WHERE ProjTypeID=?',[data.proj_description,data.project_type,proj.ProjTypeID],(err,type)=>{
            connection.query('UPDATE mat_list SET TotalListPrice=? WHERE MatListID=?',[data.totalListPrice],(err,mat)=>{
                for(var index=0;index<data.materials.length;index++){
                    connection.query('SELECT * FROM materials M JOIN mat_details MD ON M.MatDetailsID=MD.MatDetailsID AND MD.MatDescription=? ',[data.materials[index].material_description],(err,dets)=>{
                        if(dets==null){
                            connection.query('INSERT INTO materials SET MatListID=?,MatDetailsID=?,MatQty=?,TotalPrice=?',[mat.MatListID,dets[0].MatDetailsID,data.materials[index].material_quantity,data.materials[index].material_price])
                            var ham = parseInt(dets[0].MatQuantity)-parseInt(data.materials[index].material_quantity)
                            connection.query('UPDATE mat_details SET MatQuantity=? WHERE MatDetailsID=?',[ham,dets[0].MatDetailsID])
                        }
                    })
                }
                connection.query('UPDATE project SET ProjStart=?,ProjEnd=? WHERE ProjectID=?',[data.date_from,data.date_until,data.ProjectID],(err,project)=>{
                    connection.query('UPDATE customers SET CustName=? WHERE CustID=?',[data.customer_name,quots[0].CustID],(err,cust)=>{
                        
                    })
                })
                connection.query('UPDATE sub_contractors_labor SET LaborFee=? WHERE QuoID=?',[data.quotation_labor,id],(err3,res)=>{
                    console.log(res)
                })
                connection.query('SELECT * FROM sub_contractors_labor WHERE QuoID=?',id,(errrr,subdis)=>{
                    connection.query('SELECT * FROM sub_contractors WHERE SubListID = ?',subdis[0].SubListID,(erry,dsub)=>{
                        connection.query('DELETE FROM sub_contractors WHERE SubID = ?',dsub[0].SubID,(erru,dsubs)=>{
                            console.log(dsubs)
                        })
                    })
                    
                    connection.query('INSERT INTO sub_contractors SET ServiceID=?,SubListID=?,SubName=?, updated=CURRENT_TIMESTAMP',[data.ServiceID,subdis[0].SubListID,data.subcontractor_name],(errt,result)=>{
                        console.log(errt);
                    })
                })
                
            })
        })
    })
            })
            res.status(200).json({message: "Quotation Updated"})
        })
        
    // }else{
    //     res.status(400).send({message:"Session Timeout"})
    // }
})
app.put('/quotation/:id/delete',urlencodedParser,(req,res)=>{
    let id = req.params.id;
    connection.query('UPDATE quotation SET deleted=1 WHERE QuoID=?',id,(err,result)=>{
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

 //=================================================================MATERIAL==================================================================================//

 app.get("/material/categories",(req,res)=>{                                                //GET SERVICES
    // if(req.session.loggedIn){
        connection.query("SELECT ServiceName, ServiceID FROM services",(err,result)=>{
            console.log(err);
            res.json(result);
        })
    // }else{
    //     res.status(400).send({message:"Session Timeout"})
    // }
 })

 app.get("/material/categories/:id",(req,res)=>{                                            //GET MATERIAL PER SERVICE

    // if(req.session.loggedIn){
        console.log(req.params.id);
        connection.query('SELECT MatDetailsID, MatDescription, MatName, MatStatus, MatQuantity, MatPrice FROM mat_details WHERE ServiceID='+req.params.id+' AND deleted IS NULL',(err,result)=>{
            console.log(err);
            res.json(result);
        })
    // }else{
    //     res.status(400).send({message:"Session Timeout"})
    // }
 })

 app.post("/material/categories/add",urlencodedParser,(req,res)=>{                                           //ADD SERVICE
    if(req.session.loggedIn){
        var catcher = JSON.stringify(req.body);
        var data = JSON.parse(catcher);
        console.log(data);
        connection.query('INSERT INTO services (ServiceName) VALUES("'+data.ServiceName+'")',(err,result)=>{
            console.log(err);                            
            res.json({result,message:"Service Successfully Added"});
        })
    }else{
        res.status(400).send({message:"Session Timeout"})
    }
 })
 app.post("/material/categories/update",(req,res)=>{                                        //UPDATE SERVICE
    if(req.session.loggedIn){
        var catcher = JSON.stringify(req.body);
        var data = JSON.parse(catcher);
        connection.query('UPDATE services SET ServiceName="'+data.ServiceName+'" WHERE ServiceID='+req.query.id,(err,result)=>{
            console.log(err);
            res.json({result,message:"Service Successfully Updated"});
        })
    }else{
        res.status(400).send({message:"Session Timeout"})
    }
})
app.delete("/material/categories/delete",urlencodedParser,(req,res)=>{
    if(req.session.loggedIn){
        console.log(req.query.id);
        connection.query('DELETE FROM services WHERE ServiceID='+req.query.id+'',(err,result)=>{
            console.log(err);
            res.json({result,message:"Service Successfully Deleted"});
        })
    }else{
        res.status(400).send({message:"Session Timeout"})
    }
})




app.get('/materials',(req,res)=>{                                               //GET MATERIAL
    // if(req.session.loggedIn){
        connection.query("SELECT * FROM materials WHERE deleted IS NULL",(err,result)=>{
            res.json({data:result});
        })
    // }else{
    //     res.status(400).send({message:"Session Timeout"})
    // }
})

app.post('/materials/add',urlencodedParser,(req,res)=>{                         //ADD MATERIAL
    // if(req.session.loggedIn){
        var catcher = JSON.stringify(req.body);
        var data = JSON.parse(catcher);
        connection.query('INSERT INTO mat_details(ServiceID,MatName,MatPrice,MatStatus,MatQuantity,MatDescription, created) VALUES ('+data.ServiceID+',"'+data.Matname+'",'+data.MatPrice+',"'+data.MatStatus+'",'+data.MatQuantity+',"'+data.MatDescription+'", CURRENT_TIMESTAMP)',(err,result)=>{
        console.log(err)
        })

    // }else{
    //     res.status(400).send({message:"Session Timeout"})
    // }
})

app.post('/materials/delete',urlencodedParser,(req,res)=>{                      //DELETE MATERIAL
    // if(req.session.loggedIn){
      
        var id = req.query.id;
        connection.query("UPDATE mat_details SET deleted = CURRENT_TIMESTAMP WHERE MatDetailsID="+id,(err,result)=>{
            console.log(err)
            res.json({message:"Material Successfully Removed"});
        })
    // }else{
    //     res.status(400).send({message:"Session Timeout"})
    // }
})

app.post('/materials/update',urlencodedParser,(req,res)=>{                      //UPDATE MATERIAL
   
    // if(req.session.loggedIn){
        var catcher = JSON.stringify(req.body);
        var data = JSON.parse(catcher);
        connection.query('UPDATE mat_details SET updated = CURRENT_TIMESTAMP, MatName="'+data.MatName+'",MatPrice="'+data.MatPrice+'",MatStatus="'+data.MatStatus+'",MatQuantity="'+data.MatQuantity+'",MatDescription="'+data.MatDescription+'" WHERE MatDetailsID='+data.MatDetailsID,(err,result)=>{
            console.log(err);
            res.json({message:"Material Successfully Updated"});
        })
    // }else{
    //     res.status(400).send({message:"Session Timeout"})
    // }
})

//=================================================================SUBCONTRACTORS==================================================================================//
app.get('/subcontractors',(req,res)=>{                                          //GET ALL SUBCONTRACTORS
    // if(req.session.loggedIn){
        connection.query("SELECT SC.SubName,S.ServiceName,SC.SubID,SC.ServiceID,SC.SublistID FROM sub_contractors SC JOIN services S ON  SC.ServiceID = S.ServiceID WHERE deleted IS NULL ",(err,result)=>{
            console.log(err);
            res.json({data:result});
        })
    // }else{
    //     res.status(400).send({message:"Session Timeout"})
    // }
})

app.post('/subcontractors/add',urlencodedParser,(req,res)=>{                                          //ADD SUBCONTRACTORS
    // if(req.session.loggedIn){
        var catcher = JSON.stringify(req.body);
        var data = JSON.parse(catcher);
        console.log(data)
        connection.query('INSERT INTO sub_contractors(ServiceID,SubListID,SubName,created) VALUES('+data.ServiceID+','+data.SubListID+',"'+data.SubName+'",CURRENT_TIMESTAMP)',(err,result)=>{
            console.log(err);
            res.json({data:result});
        })
    // }else{
    //     res.status(400).send({message:"Session Timeout"})
    // }
})

app.post('/subcontractors/update',urlencodedParser,(req,res)=>{                                          //UPDATE SUBCONTRACTORS
    if(req.session.loggedIn){
        var catcher = JSON.stringify(req.body);
        var data = JSON.parse(catcher)
        connection.query('UPDATE sub_contractors SET ServiceID='+data.ServiceID+',SubName="'+data.SubName+'",updated=CURRENT_TIMESTAMP WHERE SubID ='+req.query.id+'',(err,result)=>{
            console.log(err);
            res.json({data:result});
        })
    }else{
        res.status(400).send({message:"Session Timeout"})
    }
})

app.post('/subcontractors/delete',urlencodedParser,(req,res)=>{                                           //DELETE SUBCONTRACTOR
    // if(req.session.loggedIn){
        connection.query('UPDATE sub_contractors SET deleted = CURRENT_TIMESTAMP WHERE SubID='+req.query.id+'',(err,result)=>{
            console.log(result);
            console.log(err)
            res.json({data:result,message:"Subcontractor Successfully Deleted"});
        })
    // }else{
    //     res.status(400).send({message:"Session Timeout"})
    // }
})

// app.delete('/subcontractors/delete',urlencodedParser,(req,res)=>{                      //DELETE SUBCONTRACTOR
//     if(req.session.loggedIn){
//         var id = req.query.id;
//         connection.query("DELETE FROM sub_contractors WHERE SubID="+id,(err,result)=>{
         
//             res.json({message:"Material Successfully Removed"});
//         })
//     }else{
//         res.status(400).send({message:"Session Timeout"})
//     }
// })
app.post('/subcontractors/addsub',urlencodedParser,(req,res)=>{                                          //ADD SUBCONTRACTORS
    // if(req.session.loggedIn){
        var catcher = JSON.stringify(req.body);
        var data = JSON.parse(catcher);
        connection.query('INSERT INTO sub_contractors(ServiceID,SubName,created) VALUES('+data.ServiceID+',"'+data.SubName+'",CURRENT_TIMESTAMP)',(err,result)=>{
            console.log(err);
            res.json({data:result});
        })
    // }else{
    //     res.status(400).send({message:"Session Timeout"})
    // }
})

app.get('/materials/:id',(req,res)=>{
    let id = req.params.id;
    console.log(id);
    if(req.session.loggedIn){
        connection.query('SELECT * FROM materials WHERE MatID='+id+'',(err,result)=>{   
            res.json({data:result});
        })
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
//new


app.listen(3000, () => {
    console.log('Example app listening on port 3000!')
});



