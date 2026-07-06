const express = require("express");

const { triggerSOS } = require("../controllers/sosController");
const { protect } = require("../middleware/authMiddleware");

const router = express.Router();

// Trigger SOS
router.post("/", protect, triggerSOS);

module.exports = router;