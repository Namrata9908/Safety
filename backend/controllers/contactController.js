const Contact = require("../models/contact");

// Add Emergency Contact
const addContact = async (req, res) => {
    try {

        const { name, phone, relationship } = req.body;

        const contact = await Contact.create({
            user: req.user.id,
            name,
            phone,
            relationship
        });

        res.status(201).json({
            message: "Emergency Contact Added Successfully",
            contact
        });

    } catch (error) {

        res.status(500).json({
            message: error.message
        });

    }
};

// Get Emergency Contacts
const getContacts = async (req, res) => {
    try {

        const contacts = await Contact.find({
            user: req.user.id
        });

        res.status(200).json(contacts);

    } catch (error) {

        res.status(500).json({
            message: error.message
        });

    }
};

module.exports = {
    addContact,
    getContacts
};