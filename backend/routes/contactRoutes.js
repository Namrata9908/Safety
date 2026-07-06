const express = require("express");

const {
    addContact
} = require("../controllers/contactController");

const { protect } = require("../middleware/authMiddleware");

const router = express.Router();

// Add Emergency Contact
router.post("/", protect, addContact);

module.exports = router;