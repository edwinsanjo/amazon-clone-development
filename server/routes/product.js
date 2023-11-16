const express = require("express");
const auth = require("../middlewares/auth");
const Product = require("../model/product");

const router = express.Router();

router.get("/api/products", auth, async (req, res) => {
    try {
        let products = await Product.find({ category: req.query.category });
        res.json(products)
    } catch (error) {
        res.status(500).json({ error: error.message })
    }
})

module.exports = router;