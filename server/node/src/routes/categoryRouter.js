const express = require('express')
const loginData = require('../models/loginData')
const category = require('../models/category')
const agentaddpackage = require('../models/agentaddpackage')
bcrypt = require('bcryptjs');
const categoryRouter = express.Router()


categoryRouter.post('/agent_category', async (req, res) => {
    try {
        const categoryname = req.body.categoryname

        const categoryDetails = await category.create({ categoryname })
        if (categoryDetails) {
            res.status(201).json({ success: true, error: false, message: "category added", details: categoryDetails });
        }
    } catch (error) {
        res.status(500).json({ success: false, error: true, message: "something went wrong" });
        console.log(error);
    }
})

categoryRouter.get('/view_agent_category', (req, res) => {

    category.find()
        .then(function (data) {
            if (data == 0) {
                return res.status(401).json({
                    success: false,
                    error: true,
                    message: "No data found"
                })
            }

            else {
                return res.status(200).json({
                    success: true,
                    error: false,
                    data: data
                })
            }
        })
})




categoryRouter.get('/view-city-package/:cat/:city', (req, res) => {
    const category = req.params.cat
    const city = req.params.city
    agentaddpackage.aggregate([

        {
            '$lookup': {
                'from': 'category-tbs',
                'localField': 'categoryname',
                'foreignField': '_id',
                'as': 'result'
            }
        },

        {
            "$match": {
                "result.categoryname": category
            }
        },
        {
            "$match": {
                "cityname": city
            }
        },

        {
            "$unwind": "$result"
        },
        // {
        //     "$group": {
        //         '_id': "$_id",
        //         'package_name': { "$first": "$package_name" },
        //         'categoryname': { "$first": "$result.categoryname" },
        //         'categoryid': { "$first": "$result._id" },
        //         'cityname': { "$first": "$cityname" },
        //         'description': { "$first": "$description" },
        //         'distance': { "$first": "$distance" },
        //         'days': { "$first": "$days" },
        //         'weather': { "$first": "$weather" },
        //         'budget': { "$first": "$budget" },
        //         'activity': { "$first": "$activity" },
        //     }
        // }
    ])
        .then((data) => {
            res.status(200).json({
                success: true,
                error: false,
                data: data
            })
        })
        .catch(err => {
            return res.status(401).json({
                message: "something wrong"
            })
        })

})
categoryRouter.get('/view-city/:cat', (req, res) => {
    const category = req.params.cat
    agentaddpackage.aggregate([

        {
            '$lookup': {
                'from': 'category-tbs',
                'localField': 'categoryname',
                'foreignField': '_id',
                'as': 'result'
            }
        },

        {
            "$match": {
                "result.categoryname": category
            }
        },

        {
            "$unwind": "$result"
        },
        // {
        //     "$group": {
        //         '_id': "$_id",
        //         'package_name': { "$first": "$package_name" },
        //         'categoryname': { "$first": "$result.categoryname" },
        //         'categoryid': { "$first": "$result._id" },
        //         'cityname': { "$first": "$cityname" },
        //         'description': { "$first": "$description" },
        //         'distance': { "$first": "$distance" },
        //         'days': { "$first": "$days" },
        //         'weather': { "$first": "$weather" },
        //         'budget': { "$first": "$budget" },
        //         'activity': { "$first": "$activity" },
        //     }
        // }
    ])
        .then((data) => {
            res.status(200).json({
                success: true,
                error: false,
                data: data
            })
        })
        .catch(err => {
            return res.status(401).json({
                message: "something wrong"
            })
        })

})

categoryRouter.get('/view-packages/:city/:categoryid', (req, res) => {
    const cityname = req.params.cityname
    const id = req.params.categoryid
    agentaddpackage.find({categoryid:id,categoryname:cityname})
        .then(function (data) {
            if (data == 0) {
                return res.status(401).json({
                    success: false,
                    error: true,
                    message: "No data found"
                })
            }

            else {
                return res.status(200).json({
                    success: true,
                    error: false,
                    data: data
                })
            }
        })
})

    
        







module.exports = categoryRouter