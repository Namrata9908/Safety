const express = require("express");

const {
    triggerSOS,
    getSOSHistory,
    resolveSOS
} = require("../controllers/sosController");

const { protect } = require("../middleware/authMiddleware");

const router = express.Router();


// Trigger SOS
router.post("/", protect, triggerSOS);


// Get SOS History
router.get("/history", protect, getSOSHistory);


// Resolve SOS
router.put("/:id/resolve", protect, resolveSOS);

module.exports = router;