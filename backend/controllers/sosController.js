const SOS = require("../models/sos");


// Trigger SOS
const triggerSOS = async (req, res) => {
    try {

        const { latitude, longitude } = req.body;

        const sos = await SOS.create({
            user: req.user.id,
            latitude,
            longitude
        });

        res.status(201).json({
            message: "SOS Triggered Successfully",
            sos
        });

    } catch (error) {

        res.status(500).json({
            message: error.message
        });

    }
};




// Get SOS History
const getSOSHistory = async (req, res) => {

    try {

        const history = await SOS.find({
            user: req.user.id
        })
            .sort({
                createdAt: -1
            });


        res.status(200).json(history);


    } catch (error) {


        res.status(500).json({
            message: error.message
        });

    }

};

// Resolve SOS
const resolveSOS = async (req, res) => {

    try {

        const { id } = req.params;


        const sos = await SOS.findOneAndUpdate(
            {
                _id: id,
                user: req.user.id
            },
            {
                status: "RESOLVED"
            },
            {
                new: true
            }
        );


        if (!sos) {
            return res.status(404).json({
                message: "SOS not found"
            });
        }


        res.status(200).json({
            message: "SOS Resolved Successfully",
            sos
        });


    } catch (error) {

        res.status(500).json({
            message: error.message
        });

    }

};


module.exports = {
    triggerSOS,
    getSOSHistory,
    resolveSOS
};