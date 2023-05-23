//var http = require('http')
//http.createServer((req,res)=>{
   // res.write("hello")
    //res.end()
//}).listen(3000,function(){
  //  console.log("server started at port http://localhost:3000");
//})

const mongoose = require('mongoose')
var express = require("express")
var bodyParser = require('body-parser')
const adminRouter = require("./src/routes/adminRouter")
const registerRouter = require("./src/routes/registerRouter")
const loginRouter = require("./src/routes/loginRouter")
const categoryRouter = require("./src/routes/categoryRouter")
const cityRouter = require("./src/routes/cityRouter")
const packagenameRouter = require("./src/routes/packagenameRouter")
const packagedetailsRouter = require("./src/routes/packagedetailsRouter")
const bookingRouter = require("./src/routes/bookingRouter")
const paymentRouter = require("./src/routes/paymentRouter")
const chatRouter = require("./src/routes/chatRouter")
const agentRouter = require("./src/routes/agentRouter")
const userplanRouter = require("./src/routes/userplanRouter")




const app = express()
app.use(bodyParser.urlencoded({ extended: true}))
app.use(express.static('./public'))
app.set('views','./src/views')
app.set('view engine','ejs')

app.get('/',(req,res)=>{
    res.render("login")
})

app.use('/admin',adminRouter)
app.use('/api/register',registerRouter)
app.use('/api/login',loginRouter)
app.use('/api/category',categoryRouter)
app.use('/api/city',cityRouter)
app.use('/api/packagename',packagenameRouter)
app.use('/api/packagedetails',packagedetailsRouter)
app.use('/api/booking',bookingRouter)
app.use('/api/payment',paymentRouter)
app.use('/api/agent',agentRouter)
app.use('/api/chat',chatRouter)
app.use('/api/userplan',userplanRouter)










const MONGODB_URL=
"mongodb+srv://anshajmaitexa:1234@cluster0.peyzxla.mongodb.net/travel_db?retryWrites=true&w=majority"


const port=2000;

mongoose.connect(MONGODB_URL).then(()=>{
    app.listen(port,()=>{
        console.log(`server running on port http://localhost:2000/admin`);
    })
}).catch((error)=>{
    console.log(` ${error} did not connect`); 
})
