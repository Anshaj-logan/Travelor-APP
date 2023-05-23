const express = require('express')
const loginData = require('../models/loginData')
const chat = require('../models/chat')

const chatRouter = express.Router()


chatRouter.post('/',async(req,res) => {
    try{
   
        var loginDetails = {
            username: req.body.username,
            password: req.body.password,
            role: 1
        }

        var reg = {
            login_id: result._id,
            firstname: req.body.firstname,
            lastname: req.body.lastname,
           phonenumber: req.body.phonenumber,
           email: req.body.email,
        }
        var result = await loginData(loginDetails).save()
        if(result) {
            var chats = {
                login_id: result._id,
                message: req.body.message,
                reply: req.body.reply,
               
            }
            var chatDetails = await chat(chats).save()
            if(chatDetails) {
                return res.status(200).json({
                    success: true,
                    error: false,
                    data: chatDetails,
                    
                })
            }
        }
    }catch(err) {

    }
})


module.exports = chatRouter