// Imports
const express = require("express");
const User = require("../model/user");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");

// initializing router
const router = express.Router();

router.post("/api/signup", async (req, res) => {
    try {
        // destructuring all the credentials from request
        let { name, email, password } = req.body;

        // checking if all needed credentials are present
        if (!name || !email || !password)
            res.status(400).json({ msg: "missing credentials in textfilelds" })

        // checking if user with the email already exist
        const existingUser = await User.findOne({ email });
        if (existingUser)
            res.status(400).json({ msg: "User with same email already exist!" })

        // hasing the password given by user for security
        let newPassword = await bcrypt.hash(password, 9);

        // saving the user credentials to the database
        let user = new User({ name, email, password: newPassword });
        user = await user.save();

        // creating the token
        let token = jwt.sign(user, "sdyf093wf094gj")

        // sending back the credentials
        res.json({ token, ...user._doc })

    } catch (error) {
        // if error sending back the error
        res.status(500).json({ error: error.message })
    }
})

router.post("/api/signin", async (req, res) => {
    try {
        // destructuring the email and password
        let { email, password } = req.body;

        // searching db for that email and returing error
        const user = await User.findOne({ email });
        if (!user) {
            return res.status(400).json({ msg: "User with this email doesnt exist" });
        }

        // dectrypting password and checking 
        const isMatch = await bcrypt.compare(password, user.password)
        if (!isMatch) {
            return res.status(400).json({ msg: "Incorrect Password." })
        }

        // generating token and sending it to user
        const token = jwt.sign({ id: user._id }, "93ffi4jd0i2j9iwf9wonsdpoajdoioi99ooi")
        res.json({ token, ...user._doc });

    } catch (error) {
        res.status(500).json({ error: error.message })
    }

})

// exporting router
module.exports = router; 