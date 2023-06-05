const db = require("../models");
const moment = require("moment");
const PatientRecords = db.patientrecords;
const PatientFileNo =db.patientfileno
const BedList = db.bedlist;
const { Op } = require("sequelize");

const customerDeposit = async (
  in_acct,
  in_facId,
  success = (f) => f,
  error = (f) => f
) => {
  try {
    PatientFileNo.findOne({
      attributes: ["balance"],
      where: {
        accountNo: in_acct,
        facilityId: in_facId,
      },
      raw: true,
      limit: 1,
    })
      .then((result) => {
        success(result);
      })
      .catch((err) => {
        error(err); // Handle any errors that occur
      });
  } catch (error) {}
};

exports.saveRecordInfo = (req, res) => {
  const {
    accountType = "",
    clientAccount = "",
    clientBeneficiaryAcc = "",
    patientNo = "",
    patientId = "",
    patientHospitalId = "",
    firstname = "",
    surname = "",
    gender = "",
    dob = "",
    maritalStatus = "",
    occupation = "",
    phone = "",
    email = "",
    address = "",
    nextOfKinName = "",
    nextOfKinRelationship = "",
    nextOfKinPhone = "",
    nextOfKinEmail = "",
    nextOfKinAddress = "",
    contact = "",
    depositAmount = 0,
    modeOfPayment = "",
    website = "",
    contactName = "",
    contactPhone = "",
    contactEmail = "",
    contactAddress = "",
    receiptsn = "",
    receiptno = "",
    description = "",
    facilityId = "",
    userId = "",
    bankName = "",
    guarantor_phoneNo = "",
    guarantor_name = "",
    guarantor_address = "",
    txn_status = "completed",
  } = req.body;
  const patient_passport = req.file && req.file.filename;
  customerDeposit(
    patientId,
    facilityId,
    (result) => {
      if (result ===null){
        
      }
    },
    (err) => {
      console.log(err);
    }
  );
  db.sequelize
    .query(
      `SELECT count(id) + 1 as beneficiaryNo FROM patientrecords  WHERE patientrecords.accountNo = :accountNo AND patientrecords.facilityId = :facId;`,
      {
        replacements: {
          accountNo: clientAccount,
          facId: facilityId,
        },
      }
    )
    .then((results) => {
      let nextPatientNo = results[0][0].beneficiaryNo;
      console.log("LDLLLLDLLDLDLDL", results);
      db.sequelize
        .query(
          `INSERT INTO patientrecords(facilityId,title,surname,firstname,other,Gender,age,maritalstatus,DOB,dateCreated,phoneNo,email,state,lga,occupation,address,kinName,kinRelationship,kinPhone,kinEmail,kinAddress,accountNo,beneficiaryNo,balance,id, accountType,patient_passport,createdAt,updatedAt) VALUES ("${facilityId}","","${surname}","${firstname}","${contactName}","${gender}",0,"${maritalStatus}","${dob}","${moment().format(
            "YYYY-MM-DD"
          )}","${phone}","${email}","","","${occupation}","${
            contact === "self" ? address : contactAddress
          }","${nextOfKinName}","${nextOfKinRelationship}","${nextOfKinPhone}","${nextOfKinEmail}","${nextOfKinAddress}","${clientAccount}","${nextPatientNo}",0,"${
            clientAccount + "-" + nextPatientNo
          }", "${accountType}", "${patient_passport}","${moment().format(
            "YYYY-MM-DD hh:mm:ss"
          )}",'0000-00-00 00-00-00')`
        )
        .then((result) => {
          res.json({ success: true, result });
        })
        .catch((err) => {
          console.log(err);
          res.status(500).json({ success: false, err });
        });
    })
    .catch((err) => {
      console.log(err);
      res.status(500).json({ success: false, err });
    });
};

exports.getPatients = (req, res) => {
  const { query_type = "all", patient_id = null, facilityId = "" } = req.query;
  if (query_type === "all") {
    PatientRecords.findAll({
      attributes: [
        [db.sequelize.literal("surname || ' ' || firstname"), "name"],
        "address",
        "Gender",
        "DOB",
        "patient_id",
        "email",
        "id",
        "accountNo",
        "accountType",
      ],
      where: {
        facilityId: facilityId,
      },
      order: [["accountNo", "DESC"]],
    })
      .then((resp) => {
        res.json({ success: true, results: resp });
      })
      .catch((err) => {
        console.log(err);
        res.status(500).json({ success: false, err });
      });
  } else if (patient_id !== null) {
    PatientRecords.findAll({
      attributes: [
        [sequelize.literal("surname || ' ' || firstname"), "name"],
        "address",
        "Gender",
        "DOB",
        "patient_id",
        "email",
        "id",
        "accountNo",
        "accountType",
      ],
      where: {
        facilityId: _facility_id,
        id: _patient_id,
      },
    })
      .then((resp) => {
        res.json({ success: true, results: resp });
      })
      .catch((err) => {
        console.log(err);
        res.status(500).json({ success: false, err });
      });
  }
};

exports.newBed = (req, res) => {
  const {
    classType = "",
    price = 0,
    bedName = "",
    facilityId = "",
    noOfBeds = 1,
  } = req.body;
  BedList.create({
    price,
    class_type: classType,
    name: bedName,
    no_of_beds: noOfBeds,
    facilityId: facilityId,
  })
    .then((results) => {
      res.json({ success: true, results });
    })
    .catch((err) => {
      res.json({ success: false, err });
    });
};

exports.getBeds = (req, res) => {
  const { query_type = "", facilityId = "" } = req.query;
  // db.sequelize
  //   .query("CALL get_beds(:query_type, :facilityId)", {
  //     replacements: {
  //       query_type,
  //       facilityId,
  //     },
  //   })
  switch (query_type) {
    case "classes":
      BedList.findAll({
        attributes: ["class_type"],
        where: {
          facilityId: facilityId,
        },
        raw: true,
        distinct: true,
      })
        .then((results) => {
          res.json({ success: true, results });
        })
        .catch((err) => {
          res.json({ success: false, err });
        });
      break;
    case "bedlist":
      db.sequelize
        .query(`SELECT * FROM bedlist_view WHERE facilityId=:facilityId;`, {
          replacements: {
            facilityId,
          },
          type: db.sequelize.QueryTypes.SELECT,
        })
        .then((results) => {
          res.json({ success: true, results });
        })
        .catch((err) => {
          res.json({ success: false, err });
        });
      break;
    case "available":
      db.sequelize
        .query(
          `SELECT * FROM bedlist_view WHERE occupied != no_of_beds AND facilityId=:facilityId;`,
          {
            replacements: {
              facilityId,
            },
            type: db.sequelize.QueryTypes.SELECT,
          }
        )
        .then((results) => {
          res.json({ success: true, results });
        })
        .catch((err) => {
          res.json({ success: false, err });
        });
      break;
    default:
      break;
  }
};

exports.bedAllocation = (req, res) => {
  const {
    userId = "",
    facilityId = "",
    bedId = "",
    timeAllocated = "",
    query_type = "",
    patient_id = "",
    allocation_id = "",
    status = "",
  } = req.body;
  console.log(req.body);

  db.sequelize
    .query(
      "CALL bed_allocation(:query_type, :bedId,:userId,:facilityId,:timeAllocated,:patient_id,:allocation_id,:status)",
      {
        replacements: {
          userId,
          facilityId,
          bedId,
          timeAllocated,
          query_type,
          patient_id,
          allocation_id,
          status,
        },
      }
    )
    .then((results) => {
      // console.log(results, 'rrrr')
      db.sequelize
        .query(
          `SELECT id as allocation_id from bed_allocation where bed_id="${bedId}" and allocated_by="${userId}" and
      allocated="${timeAllocated}" and patient_id="${patient_id}" and facilityId="${facilityId}"`
        )
        .then((results) => {
          let allocation_id = results[0][0].allocation_id;
          res.json({ success: true, allocation_id });
        })
        .catch((err) => {
          console.log(err);
          res.json({ success: false, err });
        });
    })
    .catch((err) => {
      res.json({ success: false, err });
    });
};

exports.getInPatients = (req, res) => {
  const { query_type = "", facilityId = "", condition = "" } = req.query;
  switch (query_type) {
    case "in_patients":
      db.sequelize
        .query(
          `SELECT * FROM in_patient_list WHERE facilityId = :facilityId ORDER BY sort_index;`,
          {
            replacements: { facilityId }, // Replace with the actual facilityId value
            type: db.sequelize.QueryTypes.SELECT,
          }
        )
        .then((results) => {
          res.json({ success: true, results });
        })
        .catch((err) => {
          console.log(err);
          res.json({ success: false, err });
        });
      break;
    case "in_patient":
      db.sequelize
        .query(
          `SELECT * FROM in_patient_list  WHERE allocation_id="${condition}" AND facilityId="${facilityId}" ORDER BY`,
          {
            type: db.sequelize.QueryTypes.SELECT,
          }
        )
        .then((results) => {
          res.json({ success: true, results });
        })
        .catch((err) => {
          res.json({ success: false, err });
        });
      break;
    case "in_patient_by_id":
      db.sequelize
        .query(
          `SELECT * FROM in_patient_list  WHERE patient_id="${condition}" AND facilityId=${facilityId} ORDER BY `,
          {
            type: db.sequelize.QueryTypes.SELECT,
          }
        )
        .then((results) => {
          res.json({ success: true, results });
        })
        .catch((err) => {
          res.json({ success: false, err });
        });
      break;
    case "by_status":
      db.sequelize
        .query(
          `SELECT * FROM in_patient_list  WHERE status="${condition}" AND facilityId="${facilityId}" ORDER BY `,
          {
            type: db.sequelize.QueryTypes.SELECT,
          }
        )
        .then((results) => {
          res.json({ success: true, results });
        })
        .catch((err) => {
          res.json({ success: false, err });
        });
      break;
    case "pending-admission":
      PatientRecords.findAll({ where: { patientStatus: "pending-admission" } })
        .then((results) => {
          res.json({ success: true, results });
        })
        .catch((err) => {
          res.json({ success: false, err });
        });
      break;
    default:
      PatientRecords.findAll({
        attributes: [
          "id",
          "patient_id",
          [db.sequelize.literal("surname || ' ' || firstname"), "name"],
          "dob",
          ["Gender", "gender"],
          [db.sequelize.literal("ifnull(phoneNo, '')"), "phoneNo"],
          [db.sequelize.literal("ifnull(email, '')"), "email"],
        ],
        where: {
          surname: { [Op.ne]: condition },
          facilityId: facilityId,
        },
        order: [["dateCreated", "DESC"]],
      })
        .then((results) => {
          res.json({ success: true, results });
        })
        .catch((err) => {
          res.json({ success: false, err });
        });
      break;
  }
};

exports.getPatientAccount = (req, res) => {
  const { accountNo = "" } = req.query;
  db.sequelize
    .query(`SELECT * FROM patientfileno where accountNo=${accountNo}`)
    .then((results) => {
      res.json({ success: true, results: results[0] });
    })
    .catch((error) => {
      res.json({ success: false, error });
    });
};
exports.getPatientPendingDrugs = (req, res) => {
  const today = moment().format("YYYY-MM-DD");
  // const last_week = moment(today, "YYYY-MM-DD")
  //   .add(-7, "days")
  //   .format("YYYY-MM-DD");
  const {
    request_id = "",
    facilityId = null,
    _from = today,
    _to = today,
    status = "",
  } = req.query;
  db.sequelize
    .query(
      `CALL pending_prescription('patient-drugs',:status,:facilityId,:request_id,:_from,:_to)`,
      {
        replacements: {
          facilityId,
          request_id,
          _from,
          _to,
          status,
        },
      }
    )
    .then((results) => {
      res.json({ success: true, results });
    })
    .catch((error) => {
      res.json({ success: false, error });
    });
};

exports.queryVitals = (req, res) => {
  const {
    query_type = "",
    body_temp = "",
    pulse_rate = "",
    blood_pressure = "",
    respiratory_rate = "",
    fasting_blood_sugar = "",
    random_blood_sugar = "",
    userId = "",
    facilityId = "",
    patient_id = "",
    time = "",
    spo2 = "",
  } = req.query;

  db.sequelize
    .query(
      `CALL save_vitals(:query_type,:body_temp,:pulse_rate,:blood_pressure,:respiratory_rate,
    :fasting_blood_sugar,:random_blood_sugar,:userId,:facilityId,:patient_id,:time, :spo2)`,
      {
        replacements: {
          query_type,
          body_temp,
          pulse_rate,
          blood_pressure,
          respiratory_rate,
          fasting_blood_sugar,
          random_blood_sugar,
          userId,
          facilityId,
          patient_id,
          time,
          spo2,
        },
      }
    )
    .then((results) => {
      res.json({ success: true, results });
    })
    .catch((err) => {
      res.json({ success: false, err });
    });
};

exports.newVitalSigns = (req, res) => {
  const {
    query_type,
    body_temp,
    pulse_rate,
    blood_pressure,
    respiratory_rate,
    fasting_blood_sugar,
    random_blood_sugar,
    userId,
    facilityId,
    patient_id,
    time,
    spo2 = "",
  } = req.body;

  db.sequelize
    .query(
      `CALL save_vitals(:query_type,:body_temp,:pulse_rate,:blood_pressure,:respiratory_rate,
    :fasting_blood_sugar,:random_blood_sugar,:userId,:facilityId,:patient_id,:time, :spo2)`,
      {
        replacements: {
          query_type,
          body_temp,
          pulse_rate,
          blood_pressure,
          respiratory_rate,
          fasting_blood_sugar,
          random_blood_sugar,
          userId,
          facilityId,
          patient_id,
          time,
          spo2,
        },
      }
    )
    .then((results) => {
      res.json({ success: true, results });
    })
    .catch((err) => {
      res.json({ success: false, err });
    });
};

exports.newNursingReport = (req, res) => {
  const {
    query_type,
    facilityId,
    userId,
    report,
    created_at,
    id = 0,
  } = req.body;

  db.sequelize
    .query(
      "CALL new_nursing_report(:query_type,:facilityId,:userId,:report,:created_at,:id)",
      {
        replacements: {
          query_type,
          facilityId,
          userId,
          report,
          created_at: moment(created_at).format("YYYY-MM-DD hh:mm:ss"),
          id,
        },
      }
    )
    .then((results) => {
      res.json({ success: true, results });
    })
    .catch((err) => {
      console.log(err);
      res.status(500).json({ success: false, err });
    });
};

exports.getNursingReports = (req, res) => {
  const { query_type = "", facilityId = "" } = req.query;

  db.sequelize
    .query("CALL get_nursing_reports(:query_type,:facilityId)", {
      replacements: {
        query_type,
        facilityId,
      },
    })
    .then((results) => {
      res.json({ success: true, results });
    })
    .catch((err) => {
      res.json({ success: false, err });
    });
};

exports.patient_nursing_notes = (req, res) => {
  const {
    facilityId = "",
    patient_id = "",
    report = "",
    created_at = moment().format("YYYY-MM-DD hh:mm:ss"),
    created_by = "",
  } = req.body;
  const { query_type = "" } = req.query;
  db.sequelize
    .query(
      "CALL patient_nursing_notes(:report, :patient_id, :created_at, :created_by,:facilityId,:query_type)",
      {
        replacements: {
          query_type,
          facilityId,
          patient_id,
          report,
          created_by,
          created_at: moment(created_at).format("YYYY-MM-DD hh:mm:ss"),
        },
      }
    )
    .then((results) => {
      res.json({ success: true, results });
    })
    .catch((err) => {
      console.log(err);
      res.status(500).json({ success: false, err });
    });
};

const queryDicomRepo = (
  {
    query_type = "",
    patient_name = "",
    patient_id = "",
    date_recorded,
    created_at,
    sop_intance_id = "",
    title = "",
    description = "",
  },
  callback = (f) => f,
  error = (f) => f
) => {
  const todayDate = moment().format("YYYY-MM-DD");
  const currTimestamp = moment().format("YYYY-MM-DD hh:mm:ss");
  db.sequelize
    .query(
      `CALL query_dicom_repo (:query_type, :patient_name, :patient_id, :date_recorded, 
    :created_at, :sop_intance_id, :title, :description)`,
      {
        replacements: {
          query_type,
          patient_name,
          patient_id,
          date_recorded: date_recorded ? date_recorded : todayDate,
          created_at: created_at ? created_at : currTimestamp,
          sop_intance_id,
          title,
          description,
        },
      }
    )
    .then(callback)
    .catch(error);
};

exports.saveDicomFilesData = (req, res) => {
  if (req.body.sop_intance_id && req.body.sop_intance_id !== "") {
    queryDicomRepo(
      { ...req.body, query_type: "new" },
      (results) => {
        res.json({ success: true, results });
      },
      (err) => {
        console.log(err);
        res.status(500).json({ success: false, err });
      }
    );
  } else {
    res
      .status(400)
      .json({ success: false, err: "No SOP Instance UID provided" });
  }
};

exports.getAllDicomFiles = (req, res) => {
  queryDicomRepo(
    { ...req.query, query_type: "list" },
    (results) => {
      res.json({ success: true, results });
    },
    (err) => {
      console.log(err);
      res.status(500).json({ success: false, err });
    }
  );
};

exports.getDicomFilesForPatient = (req, res) => {
  queryDicomRepo(
    { ...req.query, query_type: "by_patient" },
    (results) => {
      res.json({ success: true, results });
    },
    (err) => {
      console.log(err);
      res.status(500).json({ success: false, err });
    }
  );
};

exports.uploadFiles = (req, res) => {
  const files = req.files;
  const { patient_id, file_type, file_date } = req.body;
  // console.log(files, "ddsafas;dfk;", patient_id);

  files.forEach((item) => {
    db.sequelize
      .query(
        `INSERT INTO previous_doc(patient_id,file_type,file_url,file_date) 
        VALUES("${patient_id}","${file_type}","${item.filename}","${file_date}")`
      )
      .catch((err) => {
        console.log(err);
        res.status(500).json({ success: false, err });
      });
  });

  // .catch((err) => {
  //   res.json({
  //     success: false,
  //     err,
  //     message: "Error occur before submitting",
  //   });
  // });

  res.json({ success: true, message: "File Upload successfully" });
};

exports.getUploadFiles = (req, res) => {
  const { patient_id, file_type = "Consultation" } = req.query;
  db.sequelize
    .query(
      `SELECT * from previous_doc WHERE patient_id="${patient_id}" AND file_type="${file_type}"`
    )
    .then((results) => {
      res.json({ success: true, results: results[0] });
    })
    .catch((err) => {
      console.log(err);
      res.status(500).json({ success: false, err });
    });
};
