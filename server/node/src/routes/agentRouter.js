const express = require('express')
const loginData = require('../models/loginData')
const agent = require('../models/agent')
var bcrypt = require('bcryptjs');
const multer = require('multer')


const agentaddpackage = require('../models/agentaddpackage');
const mongoose = require('mongoose');
const objectId = mongoose.Types.ObjectId

const agentRouter = express.Router()

const storage = multer.diskStorage({
    destination: function (req, file, cb) {
        cb(null, './public/images/')
    },
    filename: function (req, file, cb) {
        cb(null, file.originalname)
    }
})

const upload = multer({ storage: storage })


agentRouter.post('/', async (req, res) => {
    console.log("data" + JSON.stringify(req.body))
    try {
        console.log(req.body.username);
        const oldUser = await loginData.findOne({ username: req.body.username })
        console.log(oldUser);
        if (oldUser) {
            return res.status(401).json({
                success: false,
                error: true,
                message: "username already exist!"
            });
        }
        const hashedPass = await bcrypt.hash(req.body.password, 12);
        const oldPhone = await agent.findOne({ phonenumber: req.body.phonenumber });
        if (oldPhone) {
            return res.status(401).json({ success: false, error: true, message: "Phone number already exist" });
        }

        const oldemail = await agent.findOne({ email: req.body.email });
        if (oldemail) {
            return res.status(401).json({ success: false, error: true, message: "Email already exist" });
        }

        var loginDetails = {
            username: req.body.username,
            password: hashedPass,
            role: 1,
            status: 0
        }

        var result = await loginData(loginDetails).save()
        if (result) {
            var agt = {
                login_id: result._id,
                name: req.body.name,
                address: req.body.address,
                email: req.body.email,

                username: req.body.username,
                phonenumber: req.body.phonenumber,
                password: req.body.password,
                confirmpassword: req.body.confirmpassword,


            }
            var agentDetails = await agent(agt).save()
            if (agentDetails) {
                return res.status(200).json({
                    success: true,
                    error: false,
                    data: agentDetails,
                    message: "Registration completed"
                })
            }
        }
    } catch (err) {
        res.status(500).json({
            success: false, error: true,
            data: agentDetails,
            message: "Something went wrong"
        });
        console.log(err);
    }
})
agentRouter.get('/view_agents', (req, res) => {

    agent.find()
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

agentRouter.get('/approve/:id', (req, res) => {
    const id = req.params.id
    console.log(id);
    loginData.find({ _id: id }).then((data) => {
        console.log("ddd==>", data[0]);
        if (data[0].status === '0') {
            loginData.updateOne({ _id: id }, { $set: { status: 1 } }).then((user) => {
                console.log(user);
                res.status(200).json({
                    success: true,
                    error: false,
                    message: "approved"
                })
            }).catch(err => {
                return res.status(401).json({
                    message: "something went wrong"
                })
            })
        } else if (data[0].status === '1') {
            loginData.updateOne({
                _id: id
            }, {
                $set: { status: 0 }
            }).then((user) => {

                console.log(user);
                res.status(200).json({
                    success: true,
                    error: false,
                    message: "disapproved"
                })
            }).catch(err => {
                return res.status(401).json({
                    message: "something went wrong"
                })
            })

        }
    }).catch(err => {
        return res.status(401).json({
            message: "something went wrong"
        })
    })
})


agentRouter.get('/view_agent_profile/:id', (req, res) => {
    const id = req.params.id
    agent.find({ login_id: id })
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

agentRouter.post('/update_agent_profile/:id', (req, res) => {
    const { name, username, email, address, phonenumber } = req.body
    const id = req.params.id
    console.log(id);
    agent.updateOne({ _id: id }, { $set: { name, username, email, address, phonenumber } }).then((data) => {
        console.log(data);
        res.status(200).json({
            success: true,
            error: false,
            message: "Details updated"
        })
    }).catch(err => {
        return res.status(401).json({
            message: "something went wrong"
        })
    })
})


// agentRouter.post('/agent_category',async(req,res) => {
//     try{
//         const categoryname = req.body.categoryname

//         const categoryDetails = await agentaddpackage.create({categoryname})
//         if(categoryDetails) {
//             res.status(201).json({success:true, error:false,message:"category added",details:categoryDetails});
//         }
//     }catch(error) {
//         res.status(500).json({success:false,error:true,message:"something went wrong"});
//         console.log(error);
//     }
// })

// agentRouter.get('/view_agent_category',(req,res) => {

//     agentaddpackage.find()
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

agentRouter.post('/agent-AddPackage', async (req, res) => {

    try {
        const { _id, package_name, categoryname, cityname, description, distance, days, weather, budget, activity } = req.body


        const AddPackage = await agentaddpackage.create({ _id, package_name, categoryname, cityname, description, distance, days, weather, budget, activity })
        if (AddPackage) {
            res.status(201).json({ success: true, error: false, message: "Package added", details: AddPackage });
        }
    } catch (error) {
        res.status(500).json({ success: false, error: true, message: "something went wrong" });
        console.log(error);
    }
})

agentRouter.get('/view_agent_AddPackage', (req, res) => {

    const id = req.params.id
    agentaddpackage.find()
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


agentRouter.get('/view_agent_SingleAddPackage/:id', (req, res) => {
    const id = req.params.id
    agentaddpackage.aggregate([

        {
            '$lookup': {
                'from': 'category-tbs',
                'localField': 'categoryname',
                'foreignField': '_id',
                'as': 'result'
            }
        },



        {
            "$unwind": "$result"
        },
        {
            "$match":{
                "_id":new objectId(id)
            }
        },
        {
            "$group": {
                '_id': "$_id",
                'package_name': { "$first": "$package_name" },
                'categoryname': { "$first": "$result.categoryname" },
                'cityname': { "$first": "$cityname" },
                'description': { "$first": "$description" },
                'distance': { "$first": "$distance" },
                'days': { "$first": "$days" },
                'weather': { "$first": "$weather" },
                'budget': { "$first": "$budget" },
                'activity': { "$first": "$activity" },
            }
        }
    ])
        .then((data) => {
            res.status(200).json({
                success: true,
                error: false,
                data: data
            })
        })
        .catch(err => {
            return res.status(401).json({
                message: "something wrong"
            })
        })
})


// agentRouter.post('/agent-Packagename',async(req,res) => {

//     try{
//         const package_name = req.body.package_name


//         const packageName = await agentpackagename.create({package_name})
//         if(packageName) {
//             res.status(201).json({success:true, error:false,message:"Package name added",details:packageName});
//         }
//     }catch(error) {
//         res.status(500).json({success:false,error:true,message:"something went wrong"});
//         console.log(error);
//     }
// })

// agentRouter.get('/view_agent_Packagename/',(req,res) => {

//     agentpackagename.find()
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




// agentRouter.post('/agent-Packagedetails',async(req,res) => {

//     try{
//         const {packagename_id,package_name,traveltype,cityname,description,distance,days,weather,budget,activity} = req.body


//         const packageName = await agentpackageDetails.create({packagename_id,package_name,traveltype,cityname,description,distance,days,weather,budget,activity})
//         if(packageName) {
//             res.status(201).json({success:true, error:false,message:"Package name added",details:packageName});
//         }
//     }catch(error) {
//         res.status(500).json({success:false,error:true,message:"something went wrong"});
//         console.log(error);
//     }
// })


// agentRouter.get('/view_agent_Packagedetails/:id',(req,res) => {
//     const id=req.params.id
//     agentpackageDetails.find({_id:id})
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



agentRouter.post('/update_agent_package/:id', (req, res) => {
    const { package_name, traveltype, cityname, description, distance, days, weather, budget, activity } = req.body
    const id = req.params.id
    console.log(id);
    agentaddpackage.updateOne({ _id: id }, { $set: { package_name, traveltype, cityname, description, distance, days, weather, budget, activity } }).then((data) => {
        console.log(data);
        res.status(200).json({
            success: true,
            error: false,
            message: "Details updated"
        })
    }).catch(err => {
        return res.status(401).json({
            message: "something went wrong"
        })
    })
})

module.exports = agentRouter