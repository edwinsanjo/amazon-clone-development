// Imports
const express = require("express");
const User = require("../model/user");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
const auth = require("../middlewares/auth");

// initializing router
const router = express.Router();

router.post("/api/signup", async (req, res) => {
    try {
        // destructuring all the credentials from request
        let { name, email, password } = req.body;

        // checking if all needed credentials are present
        if (!name || !email || !password)
            return res.status(400).json({ msg: "missing credentials in textfilelds" })

        // checking if user with the email already exist
        const existingUser = await User.findOne({ email });
        if (existingUser)
            return res.status(400).json({ msg: "User with same email already exist!" })

        // hasing the password given by user for security
        let newPassword = await bcrypt.hash(password, 9);

        // saving the user credentials to the database
        let user = new User({ name, email, password: newPassword });
        user = await user.save();

        // creating the token
        let token = jwt.sign(user, "sdyf093wf094gj")

        // sending back the credentials
        return res.json({ token, ...user._doc })

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
        return res.json({ token, ...user._doc });

    } catch (error) {
        res.status(500).json({ error: error.message })
    }
})

router.post("/IsTokenValid", async (req, res) => {
    try {
        const token = req.header("x-auth-token");
        if (!token) return res.json(false);
        const Verified = jwt.verify(token, "93ffi4jd0i2j9iwf9wonsdpoajdoioi99ooi")
        if (!Verified) return res.json(false);

        const user = await User.findOne({ _id: Verified.id });
        if (!user) return res.json(false);
        return res.json(true);
    } catch (error) {
        res.status(500).json({ error: error.message })
    }
})

router.get("/", auth, async (req, res) => {
    const user = await User.findById(req.user);
    return res.json({ ...user._doc, token: req.token });
})

// exporting router
module.exports = router; 