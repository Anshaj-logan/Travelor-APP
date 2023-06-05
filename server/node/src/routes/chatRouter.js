const express = require('express')
const loginData = require('../models/loginData')
const chat = require('../models/chat')
const mongoose = require('mongoose');
const objectId = mongoose.Types.ObjectId

const chatRouter = express.Router()


chatRouter.post('/addchat', async (req, res) => {
    try {
        const { login_id,user_login_id,addchat,agent_id} = req.body

        const packageDetails = await chat.create({ login_id,user_login_id,agent_id,addchat, reply:null})
        if (packageDetails) {
            res.status(201).json({ success: true, error: false, message: "sent", details: packageDetails });
        }
    } catch (error) {
        res.status(500).json({ success: false, error: true, message: "something went wrong" });
        console.log(error);
    }
})
chatRouter.get('/view-agent-chat/:id', async (req, res) => {
    try {
        const id = req.params.id
        const packageDetails = await chat.aggregate([
            {
              '$lookup': {
                'from': 'registration-tbs', 
                'localField': 'user_login_id', 
                'foreignField': 'login_id', 
                'as': 'user'
              }
            }, {
              '$lookup': {
                'from': 'travel_agent-tbs', 
                'localField': 'agent_id', 
                'foreignField': '_id', 
                'as': 'agent'
              }
            },
            {
                "$unwind": "$user"
            },
            {
                "$unwind": "$agent"
            },
            {
                "$match":{
                    "agent_id":new objectId(id)
                }
            },
            {
                "$group": {
                    '_id': "$_id",
                    'addchat': { "$first": "$addchat" },
                    'reply': { "$first": "$reply" },
                    'name': { "$first": "$user.name" },
                    'agentname': { "$first": "$agent.name" },
                    // 'description': { "$first": "$description" },
                    // 'distance': { "$first": "$distance" },
                    // 'days': { "$first": "$days" },
                    // 'weather': { "$first": "$weather" },
                    // 'budget': { "$first": "$budget" },
                    // 'activity': { "$first": "$activity" },
                }
            }
          ])
        if (packageDetails) {
            res.status(201).json({ success: true, error: false, message: "sent", details: packageDetails });
        }
    } catch (error) {
        res.status(500).json({ success: false, error: true, message: "something went wrong" });
        console.log(error);
    }
})



module.exports = chatRouter