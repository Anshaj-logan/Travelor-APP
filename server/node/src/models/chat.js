const mongoose = require('mongoose')


const schema = mongoose.Schema
const chatSchema = new schema({
    login_id:{type:mongoose.Types.ObjectId,ref:"login-tb"},
    user_id:{type:mongoose.Types.ObjectId,ref:"registration-tb"},
    addchat:{type:String},
    reply:{type:String},
    
})

const chat = mongoose.model('chat-tb',chatSchema)
module.exports = chat