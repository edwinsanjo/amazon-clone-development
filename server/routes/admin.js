const express = require("express");
const admin = require("../middlewares/admin");
const Product = require("../model/product");

const router = express.Router();

router.post("/admin/add-product", admin, async (req, res) => {
    try {
        const { name, description, images, quantity, price, category } = req.body;
        let product = new Product({
            name,
            description,
            images,
            quantity,
            price,
            category,
        });
        product = await product.save();
        return res.json(product);

    } catch (e) {
        res.status(500).json({ error: e.message })
    }
})

router.get("/admin/get-products", admin, async (req, res) => {
    try {
        var products = await Product.find();
        res.json(products);

    } catch (error) {
        return res.status(500).json({ error: error.message })
    }
})

router.post("/admin/delete-product", admin, async (req, res) => {
    try {
        let { id } = req.body;
        let product = await Product.findByIdAndDelete(id);
        res.json(product);
    } catch (error) {
        return res.status(500).json({ error: e.message })
    }
})

module.exports = router;