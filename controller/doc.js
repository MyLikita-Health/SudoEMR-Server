const moment = require("moment");
const db = require("../models");

exports.addPatient = (req, res) => {};

exports.getHomePage = (req, res) => {
  const { facilityId, role } = req.query;

  db.sequelize
    .query("CALL get_homepage(:facilityId,:role)", {
      replacements: {
        facilityId,
        role,
      },
    })
    .then((results) => {
      res.json({ success: true, results });
    })
    .catch((err) => {
      res.status(500).json({ success: false, err });
    });
};
const today = moment().format("YYYY-MM-DD");
exports.getConsultation = (req, res) => {
  const {
    date_from = today,
    date_to = today,
    userId,
    query_type = "select_all",
    facilityId,
  } = req.query;
  db.sequelize
    .query(
      "CALL get_all_consultation(:date_from,:date_to,:userId,:query_type,:facilityId)",
      {
        replacements: {
          date_from,
          date_to,
          userId,
          query_type,
          facilityId,
        },
      }
    )
    .then((results) => {
      res.json({ success: true, results });
    })
    .catch((err) => {
      res.status(500).json({ success: false, err });
      console.log(err);
    });
};

exports.appointment = (req, res) => {
  const today = moment().format("YYYY-MM-DD hh:mm:ss");
  const {
    user_id = "",
    patientId = "",
    patient_name = "",
    appointmentType = "",
    location = "",
    notes = "",
    start_at = today,
    end_at = today,
    facilityId = "",
    query_type = "select",
    id = null,
  } = req.body;
  console.log(req.body);
  db.sequelize
    .query(
      "CALL appointment(:user_id,:patientId, :patient_name, :appointmentType, :location, :notes, :start_at, :end_at,:facilityId,:query_type,:id)",
      {
        replacements: {
          user_id,
          patientId,
          patient_name,
          appointmentType,
          location,
          notes,
          start_at,
          end_at,
          query_type,
          facilityId,
          id,
        },
      }
    )
    .then((results) => {
      res.json({ success: true, results });
    })
    .catch((err) => {
      res.status(500).json({ success: false, err });
      console.log(err);
    });
};

exports.medical_report = (req, res) => {
  const {
    user_id,
    admit_date,
    proceduce_date,
    discharge_date,
    special_instrustion,
    other_info,
    facilityId,
  } = req.body;
  db.sequelize
    .query(
      "CALL medical_report(:user_id,:admit_date,:proceduce_date,:discharge_date,:special_instrustion,:other_info,:facilityId)",
      {
        replacements: {
          user_id,
          admit_date,
          proceduce_date,
          discharge_date,
          special_instrustion,
          other_info,
          facilityId,
        },
      }
    )
    .then((results) => {
      res.json({ success: true, results });
    })
    .catch((err) => {
      res.status(500).json({ success: false, err });
      console.log(err);
    });
};
