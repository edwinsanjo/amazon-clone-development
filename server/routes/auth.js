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
        let token = await jwt.sign(user, "sdyf093wf094gj")

        // sending back the credentials
        res.json({ user, token })

    } catch (error) {
        // if error sending back the error
        res.status(500).json({ error: error.message })
    }
})

router.post("/api/signin", async (req, res) => {
    try {
        let { email, password } = req.body;
        // destructuring the email and password
        const user = await User.findOne({ email });
        if (!user) {
            return res.status(400).json({ msg: "User with this email doesnt exist" })
        }
    } catch (error) {
        res.status(500).json({ error: e.message })
    }

})

// exporting router
module.exports = router; 