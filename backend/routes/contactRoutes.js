const express = require("express");

const {
    addContact,
    getContacts,
    deleteContact,
    updateContact
} = require("../controllers/contactController");

const { protect } = require("../middleware/authMiddleware");

const router = express.Router();

// Add Emergency Contact
router.post("/", protect, addContact);

// Get Emergency Contacts
router.get("/", protect, getContacts);

// Delete Emergency Contact
router.delete("/:id", protect, deleteContact);

// Update Emergency Contact
router.put("/:id", protect, updateContact);

module.exports = router;