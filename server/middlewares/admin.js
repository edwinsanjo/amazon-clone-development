const jwt = require("jsonwebtoken");
const User = require("../model/user")

const auth = async (req, res, next) => {
    try {
        const token = req.header("x-auth-token")
        if (!token)
            return res
                .status(401)
                .json({ msg: "no auth token, access denied" });

        const Verified = jwt.verify(token, "93ffi4jd0i2j9iwf9wonsdpoajdoioi99ooi")
        if (!Verified)
            return res
                .status(401)
                .json({ msg: "Token verification failed, authorization denied." });
        var user = await User.findOne({ _id: Verified.id });
        if (user.type == "user" || user.type == "seller")
            return res
                .status(401)
                .json({ msg: "You are not an admin" });
        req.user = Verified.id;
        req.token = token;
        next();
    } catch (error) {
        res.status(500).json({ error: error.message })
    }
}

module.exports = auth;