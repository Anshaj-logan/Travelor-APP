const express = require('express')
const category = require('../models/category');
const city = require('../models/city');
const packagename = require('../models/packagename');
const packagenameRouter = express.Router()


packagenameRouter.post('/user-cityPackagename',async(req,res) => {

    try{
        const {category_id,city_id,package_name,budget} = req.body


        const packageName = await packagename.create({category_id,city_id,package_name,budget})
        if(packageName) {
            res.status(201).json({success:true, error:false,message:"Package added",details:packageName});
        }
    }catch(error) {
        res.status(500).json({success:false,error:true,message:"something went wrong"});
        console.log(error);
    }
})

packagenameRouter.get('/view_user_cityPackagename/:id',(req,res) => {
    
    const id = req.params.id
    packagename.find({city_id:id})
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


module.exports = packagenameRouter