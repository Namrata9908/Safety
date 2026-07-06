const express = require("express");

const {
    addContact,
    getContacts,
    deleteContact
} = require("../controllers/contactController");

const { protect } = require("../middleware/authMiddleware");

const router = express.Router();

// Add Emergency Contact
router.post("/", protect, addContact);

// Get Emergency Contacts
router.get("/", protect, getContacts);

// Delete Emergency Contact
router.delete("/:id", protect, deleteContact);

module.exports = router;