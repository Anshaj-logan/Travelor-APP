const express = require('express')
const loginData = require('../models/loginData')
const chat = require('../models/chat')

const chatRouter = express.Router()


chatRouter.post('/addchat', async (req, res) => {
    try {
        const { login_id,user_id,addchat} = req.body

        const packageDetails = await chat.create({ login_id,user_id,addchat, reply:null})
        if (packageDetails) {
            res.status(201).json({ success: true, error: false, message: "sent", details: packageDetails });
        }
    } catch (error) {
        res.status(500).json({ success: false, error: true, message: "something went wrong" });
        console.log(error);
    }
})



module.exports = chatRouter