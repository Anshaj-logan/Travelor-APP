const express = require('express')

const userplan = require('../models/userplan')
const userlocation = require('../models/location')

var ObjectId = require('mongodb').ObjectId;

//const userselect = require('../models/userselect')

const userplanRouter = express.Router()


userplanRouter.post('/location', async (req, res) => {
    try {

        const location = req.body.location



        const locationDetails = await userlocation.create({ location })
        if (locationDetails) {
            res.status(201).json({ success: true, error: false, message: "location added", details: locationDetails });
        }
    } catch (error) {
        res.status(500).json({ success: false, error: true, message: "something went wrong" });
        console.log(error);
    }
})

userplanRouter.get('/viewlocation', (req, res) => {
    //const id = req.params.id
    userlocation.find()
        .then(function (data) {
            if (data == 0) {
                return res.status(401).json({
                    success: false,
                    error: true,
                    message: "No data found"
                })
            }

            else {
                return res.status(200).json({
                    success: true,
                    error: false,
                    data: data
                })
            }
        })
})


userplanRouter.post('/addplan', async (req, res) => {
    try {
        const { login_id, fromlocation, wherelocation, startdate, enddate, persons, budget, traveltype, activity, requirement, agent } = req.body

        const packageDetails = await userplan.create({ login_id, fromlocation, wherelocation, startdate, enddate, persons, budget, traveltype, activity, requirement, agent })
        if (packageDetails) {
            res.status(201).json({ success: true, error: false, message: "package added", details: packageDetails });
        }
    } catch (error) {
        res.status(500).json({ success: false, error: true, message: "something went wrong" });
        console.log(error);
    }
})

userplanRouter.get('/view_user_plan', (req, res) => {

    userplan.find()
        .then(function (data) {
            if (data == 0) {
                return res.status(401).json({
                    success: false,
                    error: true,
                    message: "No data found"
                })
            }

            else {
                return res.status(200).json({
                    success: true,
                    error: false,
                    data: data
                })
            }
        })
})

userplanRouter.get('/view_single-package/:id',(req,res) => {
    const id = req.params.id
    userplan.findOne({_id:id})
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


userplanRouter.get('/view-userplan-single-agent/:id', (req, res) => {
    const id = req.params.id

    userplan.aggregate([
        {
            '$lookup': {
                'from': 'travel_agent-tbs',
                'localField': 'agent',
                'foreignField': '_id',
                'as': 'result'
            }
        }, 
        {
            '$lookup': {
                'from': 'registration-tbs',
                'localField': 'login_id',
                'foreignField': 'login_id',
                'as': 'user'
            }
        },
        {
            "$unwind": "$user"
        },
        {
            "$unwind": "$result"
        },
        {
            "$match":{
                "agent": new ObjectId(id)
            }
        },
        {
            "$group": {
                "_id": "$_id",
                "name": { "$first": "$user.name" },
               
                "traveltype": { "$first": "$traveltype" },
              

            }
        }
    ])
        .then(function (data) {

            if (data == 0) {
                return res.status(401).json({
                    success: false,
                    error: true,
                    message: "No Data Found!"
                })
            }
            else {
                return res.status(200).json({
                    success: true,
                    error: false,
                    data: data
                })
            }
        })

})


module.exports = userplanRouter