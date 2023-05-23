const mongoose = require('mongoose')


const schema = mongoose.Schema
const userplanSchema = new schema({
    
  
    location:{type:String},
    persons:{type:String},
    budget:{type:String},
    categoryname:{type:String},
    activity:{type:String},
    requirements:{type:String},
    agency:{type:String}
    
    
    
    
})

const userplan = mongoose.model('userplan-tb',userplanSchema)
module.exports = userplan