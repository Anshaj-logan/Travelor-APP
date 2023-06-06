const express = require('express')
const company = require('../models/company')
const companybooking = require('../models/companyBook')
const companyRouter = express.Router()



companyRouter.post('/add_comapany', async (req, res) => {
    try {

        const { agent_id, companyname, established_year, cityname, description, address, phone } = req.body
        const oldname = await company.findOne({companyname})
        if(oldname){
            res.status(400).json({ success: false, error: true, message: "Company already added" });
        }
        const comapnyDetails = await company.create({ agent_id, status:0, companyname, established_year, cityname, description, address, phone })
        if (comapnyDetails) {
            res.status(201).json({ success: true, error: false, message: "company added", details: comapnyDetails });
        }
    } catch (error) {
        res.status(500).json({ success: false, error: true, message: "something went wrong" });
        console.log(error);
    }
})


companyRouter.get('/view_company/:city',async (req,res) => {
    
   try {
    const cityname = req.params.city
    const oldname = await company.find({cityname,status:0})
    if(oldname[0]!=undefined){
        return res.status(200).json({
            success:true,
            error:false,
            data:oldname
        })
    }else{
        return res.status(401).json({
            success: false,
            error: true,
            message:"No data found"
        })
    }
   
   } catch (error) {
    return res.status(401).json({
        success: false,
        error: true,
        message:"Something went wrong"
    })
   }
})


companyRouter.post('/book_comapany', async (req, res) => {
    try {

        const { user_id, company_id, date } = req.body
        const oldname = await company.findOne({user_id,company_id,status:1})
        if(oldname){
            res.status(400).json({ success: false, error: true, message: "Company already booked" });
        }
        const comapnybook = await company.create({ user_id, company_id, date, status:1})
        if (comapnybook) {
            res.status(201).json({ success: true, error: false, message: "company booked", details: comapnybook });
        }
    } catch (error) {
        res.status(500).json({ success: false, error: true, message: "something went wrong" });
        console.log(error);
    }
})






module.exports = companyRouter