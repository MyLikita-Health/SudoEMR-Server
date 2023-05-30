const { v4 } = require("uuid");
const db = require("../models");
const Hospital = db.hospitals;
// const { v4 as uuid } = require("uuidv4");
const { nearUpdateAPI } = require("../queries/near");

// create hospital
exports.create = (req, res) => {
  let { name, code, address, type, logo, admin, hasStore } = req.body;
  let id = v4();
  Hospital.create({
    id,
    name,
    code,
    address,
    type,
    admin,
    hasStore: hasStore === "Yes" ? 1 : 0,
    logo: logo ? logo : "",
  })
    .then((hospital) => {
      res.json({ hospital, success: true });
    })
    .catch((err) => {
      console.log(err)
      res.status(500).json({ err,success:false });
    });
};

exports.createBedSpace = (req, res) => {
  const { facilityId, classType, bedName } = req.body;

  db.sequelize
    .query("call create_new_bed(:facilityId, :classType, :bedName)", {
      replacements: {
        facilityId,
        classType,
        bedName,
      },
    })
    .then((results) => res.json({ results }))
    .catch((err) => res.status(500).json({ err }));
};

exports.getFacilityInfo = (req, res) => {
  const { facilityId } = req.params;

    Hospital.findAll({
      where:{
        id:facilityId
      }
    })
    .then((results) => res.json({ results: results[0] }))
    .catch((err) => res.status(500).json({ err }));
};

exports.getAllBedsForFacility = (req, res) => {
  const { facilityId } = req.params;

  db.sequelize
    .query("call get_all_beds(:facilityId)", {
      replacements: { facilityId },
    })
    .then((results) => res.json({ results }))
    .catch((err) => res.status(500).json({ err }));
};

// fetch all hospitals
exports.findAll = (req, res) => {
  Hospital.findAll({
    attributes: ["id", "name", "address", "logo", "type", "createdAt"],
    order: [["createdAt", "DESC"]],
  })
    .then((hospital) => {
      res.json({ hospital });
    })
    .catch((err) => res.status(500).json({ err }));
};

exports.findAllPharmacy = (req, res) => {
  Hospital.findAll({
    attributes: ["id", "name", "address", "logo", "type", "createdAt"],
    order: [["createdAt", "DESC"]],
    where: { type: "pharmacy" },
  })
    .then((hospital) => {
      res.json({ hospital });
    })
    .catch((err) => res.status(500).json({ err }));
};

exports.findAllLab = (req, res) => {
  Hospital.findAll({
    attributes: ["id", "name", "address", "logo", "type", "createdAt"],
    order: [["createdAt", "DESC"]],
    where: { type: "laboratory" },
  })
    .then((hospital) => {
      res.json({ hospital });
    })
    .catch((err) => res.status(500).json({ err }));
};

exports.countFacilities = (req, res) => {
  db.sequelize
    .query("SELECT type, count(*) AS count FROM hospitals GROUP BY type;")
    .then((hospital) => {
      let newObj = {};
      hospital[0].forEach((item) => (newObj[item.type] = item.count));
      res.json({ counts: newObj });
    })
    .catch((err) => res.status(500).json({ err }));
};

// fetch hospital by hospitalId
exports.findById = (req, res) => {
  const id = req.params.hospitalId;

  Hospital.findAll({ where: { id } })
    .then((hospital) => res.json({ hospital }))
    .catch((err) => res.status(500).json({ err }));
};

// update a hospital's info
exports.update = (req, res) => {
  // var hospital = req.body.hospital;
  let { name } = req.body;
  const id = req.params.hospitalId;

  Hospital.update(
    {
      name,
    },
    { where: { id } }
  )
    .then((hospital) => res.status(200).json({ hospital }))
    .catch((err) => res.status(500).json({ err }));
};

// update a hospital's info
exports.nearUpdate = (req, res) => {
  let { consultation, patient } = req.body;
  const { id } = req.params;
  console.log(req.body);
  nearUpdateAPI(
    { consultation, patient, facilityId: id },
    (hospital) => res.status(200).json({ hospital }),
    (err) => res.status(500).json({ err })
  );
};

// delete a hospital
exports.delete = (req, res) => {
  const id = req.params.hospitalId;
  Hospital.destroy({ where: { id } })
    .then(() =>
      res.status.json({ msg: "Hospital has been deleted successfully!" })
    )
    .catch((err) => res.status(500).json({ msg: "Failed to delete!" }));
};

exports.getDepartments = (req, res) => {
  const { facilityId = "", query_type = "" } = req.query;
  db.sequelize
    .query(`CALL department(:query_type, :facilityId,'','')`, {
      replacements: {
        facilityId,
        query_type,
      },
    })
    .then((results) => {
      res.json({ success: true, results });
    })
    .catch((err) => {
      console.log(err);
    });
};

exports.newDeparment = (req, res) => {
  const {
    department = "",
    userId = "",
    facilityId = "",
    query_type = "",
  } = req.body;

  db.sequelize
    .query("CALL department(:query_type, :facilityId,:department,userId)", {
      replacements: {
        department,
        query_type,
        facilityId,
        userId,
      },
    })
    .then((results) => {
      res.json({ success: true, results });
    })
    .catch((err) => {
      console.log(err);
    });
};
