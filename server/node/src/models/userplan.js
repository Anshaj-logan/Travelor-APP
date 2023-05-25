const mongoose = require('mongoose')


const schema = mongoose.Schema
const userplanSchema = new schema({
    login_id:{type:mongoose.Types.ObjectId,ref:"login-tb"},
    fromlocation:{type:String},
    wherelocation:{type:String},
    startdate:{type:String},
    enddate:{type:String},
    persons:{type:String},
    budget:{type:String},
    traveltype:{type:String},
    activity:{type:String},
    requirement:{type:String},
    agent:{ type: mongoose.Types.ObjectId, ref: "travel_agent-tb"}
    
    
    
    
})

const userplan = mongoose.model('userplan-tb',userplanSchema)
module.exports = userplan