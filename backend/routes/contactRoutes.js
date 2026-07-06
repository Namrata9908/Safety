const express = require("express");

const {
    addContact,
    getContacts
} = require("../controllers/contactController");

const { protect } = require("../middleware/authMiddleware");

const router = express.Router();

// Add Emergency Contact
router.post("/", protect, addContact);

// Get Emergency Contacts
router.get("/", protect, getContacts);

module.exports = router;