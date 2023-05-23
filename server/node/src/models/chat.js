const mongoose = require('mongoose')


const schema = mongoose.Schema
const chatSchema = new schema({
    
    user_id:{type:mongoose.Types.ObjectId,ref:"registration-tb"},
    message:{type:String},
    reply:{type:String},
    
})

const chat = mongoose.model('chat-tb',chatSchema)
module.exports = chat