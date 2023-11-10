const jwt = require("jsonwebtoken");

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
        req.user = Verified.id;
        req.token = token;
        next();
    } catch (error) {
        res.status(500).json({ error: error.message })
    }
}

module.exports = auth;