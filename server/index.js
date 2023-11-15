const express = require("express")
const mongoose = require("mongoose")
const cors = require("cors")
const logger = require("morgan")

// importing routes
const authRoute = require("./routes/auth.js");
const adminRoute = require("./routes/admin.js");

// initializing app
const PORT = 3000;
let app = express()

// middlewares
app.use(express.json({ extended: false }));
app.use(cors());
app.use(logger("dev"));

// settings up the db
mongoose.connect("mongodb+srv://edwin123456:edwinsanjosoji@cluster.omndo6m.mongodb.net/?retryWrites=true&w=majority")
    .then(() => console.log("DB connected"))
    .catch((err) => console.log(`DB connction error: ${err}`))

// using the routes 
app.use(authRoute);
app.use(adminRoute);


// listining on port
app.listen(PORT, "0.0.0.0", () => console.log(`server running on port :${PORT} eg: http://localhost:${PORT}`))