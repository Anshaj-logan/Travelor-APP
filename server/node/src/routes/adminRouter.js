const express = require('express')
const loginData = require('../models/loginData')
const registration = require('../models/registration')
const adminRouter = express.Router()

adminRouter.get('/',(req,res)=>{
    res.render("dashboard")
})

adminRouter.get('/logout',(req,res)=>{
    res.render('login')
  })

  adminRouter.post("/admin-login", async (req, res) => {
    const { username, password } = req.body;
    console.log(username,password);
    try {
        const oldUser = await loginData.findOne({ username })
        console.log(oldUser);
        if (!oldUser) return res.redirect('/')
        const isPasswordCorrect = await bcrypt.compare(password, oldUser.password)
        if (!isPasswordCorrect) return res.redirect('/')
        if (oldUser.role === '0') {
                const admin = await loginData.findOne({ _id: oldUser._id })
                if (admin) {
                    return res.redirect('/admin')
                }           
        }       
    } catch (error) {
        return res.status(500).redirect('/')
    }
}) 

adminRouter.get('/manage_user',(req,res)=>{
    loginData.aggregate(
        
            [
                {
                  '$lookup': {
                    'from': 'registration-tbs', 
                    'localField': '_id', 
                    'foreignField': 'login_id', 
                    'as': 'user'
                  }
                },
                {
                    "$unwind": "$user" 
                },
                {
                    "$match":{
                        "role":"2"
                    }
                },
                {
                    "$group":{
                        '_id':'$_id',
                        'username': {'$first':'$username'},
                        'name': {'$first':'$user.name'},
                        //'lastname': {'$first':'$user.lastname'},
                        'email':{'$first':'$user.email'},
                        'status':{'$first':'$status'},
                    }
                }
            
        ]
    ).then((data) => {
         console.log(data);
        res.render("manage_user", { data})
})
})

adminRouter.get('/approve-user/:id',async(req,res) => {
    const id = req.params.id
    try{
         loginData.updateOne({_id:id},{$set:{status:"1"}}).then((data) => {
            res.redirect('/admin/manage_user')
        })
        
    }catch(error) {

    }
}
)

adminRouter.get('/delete-user/:id',async(req,res) => {
    const id = req.params.id
    try{
         loginData.deleteOne({_id:id}).then((data) => {
            registration.deleteOne({login_id:id}).then((details) => {
              res.redirect('/admin/manage_user')
              }
            )
        }
        )
    }catch(error) {
        
    }
}
)

adminRouter.get('/manage_travel_agent',(req,res)=>{
    loginData.aggregate(
        
        [
            {
              '$lookup': {
                'from': 'travel_agent-tbs', 
                'localField': '_id', 
                'foreignField': 'login_id', 
                'as': 'user'
              }
            },
            {
                "$unwind": "$user" 
            },
            {
                "$match":{
                    "role":"1"
                }
            },
            {
                "$group":{
                    '_id':'$_id',
                    'username': {'$first':'$username'},
                    'name': {'$first':'$user.name'},
                    
                    'email':{'$first':'$user.email'},
                    'status':{'$first':'$status'},
                }
            }
        
    ]
).then((data) => {
     console.log(data);
    res.render("manage_travel_agent", { data})
})
})

adminRouter.get('/approve-agent/:id',async(req,res) => {
    const id = req.params.id
    try{
         loginData.updateOne({_id:id},{$set:{status:"1"}}).then((data) => {
            res.redirect('/admin/manage_travel_agent')
        })
        
    }catch(error) {

    }
})

adminRouter.get('/delete-agent/:id',async(req,res) => {
    const id = req.params.id
    try{
         loginData.deleteOne({_id:id}).then((data) => {
            registration.deleteOne({login_id:id}).then((details) => {
              res.redirect('/admin/manage_travel_agent')
              }
            )
        }
        )
    }catch(error) {
        
    }
}
)

adminRouter.get('/view_package',(req,res)=>{
    res.render("view_package")
})
adminRouter.get('/view_payment',async(req,res)=>{
    try {
        const data = [
            {
              '$lookup': {
                'from': 'userplan-tbs', 
                'localField': 'package_id', 
                'foreignField': '_id', 
                'as': 'plan'
              }
            }, {
              '$lookup': {
                'from': 'registration-tbs', 
                'localField': 'login_id', 
                'foreignField': 'login_id', 
                'as': 'user'
              }
            }
          ]
    } catch (error) {
        
    }
    res.render("view_payment")
})

module.exports = adminRouter