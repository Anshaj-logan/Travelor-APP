const mongoose = require('mongoose')


const schema = mongoose.Schema
const chatSchema = new schema({
    user_login_id:{type:mongoose.Types.ObjectId,ref:"registration-tb"},
    agent_id:{type:mongoose.Types.ObjectId,ref:"travel_agent-tb"},
    addchat:{type:String},
    reply:{type:String},
    
})

const chat = mongoose.model('chat-tb',chatSchema)
module.exports = chat