const express = require('express')

const userplan = require('../models/userplan')
//const userselect = require('../models/userselect')

const userplanRouter = express.Router()


// userplanRouter.post('/userplan_location',async(req,res) => {
//     try{

//         const location = req.body.location
        
        

//         const locationDetails = await userplan.create({location})
//         if(locationDetails) {
//             res.status(201).json({success:true, error:false,message:"location added",details:locationDetails});
//         }
//     }catch(error) {
//         res.status(500).json({success:false,error:true,message:"something went wrong"});
//         console.log(error);
//     }
// })

// userplanRouter.get('/view_userplan_location',(req,res) => {
//     //const id = req.params.id
//     userplan.find()
//     .then(function(data) {
//         if(data==0) {
//             return res.status(401).json({
//                 success: false,
//                 error: true,
//                 message:"No data found"
//             })
//         }

//         else{
//             return res.status(200).json({
//                 success:true,
//                 error:false,
//                 data:data
//             })
//         }
//     })
// })


userplanRouter.post('/user-plan',async(req,res) => {
    try{
        const {location,persons,budget,categoryname,requirements} = req.body

        const packageDetails = await userplan.create({location,persons,budget,categoryname,requirements})
        if(packageDetails) {
            res.status(201).json({success:true, error:false,message:"package added",details:packageDetails});
        }
    }catch(error) {
        res.status(500).json({success:false,error:true,message:"something went wrong"});
        console.log(error);
    }
})

userplanRouter.get('/view_user_plan',(req,res) => {
    
    userplan.find()
    .then(function(data) {
        if(data==0) {
            return res.status(401).json({
                success: false,
                error: true,
                message:"No data found"
            })
        }

        else{
            return res.status(200).json({
                success:true,
                error:false,
                data:data
            })
        }
    })
})




module.exports = userplanRouter