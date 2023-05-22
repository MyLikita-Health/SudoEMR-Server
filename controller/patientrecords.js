const db = require("../models");
const PatientRecords = db.Patientrecords;
const moment = require("moment");
// const queryOperationNotes = require('./operationnotes').queryOperationNotes

exports.getPatientList = (req, res) => {
  const { facilityId } = req.params;
  db.sequelize
    .query("call get_patient_records(:facilityId)", {
      replacements: { facilityId },
    })
    .then((results) => res.json({ success: true, results }))
    .catch((err) => res.status(500).json({ err }));
};

// exports.getPatientList = (req, res) => {
//     db.sequelize
//     .query('select max(id) + 1 from patients', {
//       type: db.sequelize.QueryTypes.SELECT,
//     })
//     .then(results => res.json({ results }))sfdrfwerfsd
//     .catch(err => res.status(500).json({ err }));
// }

exports.getNextClientBeneficiaryNo = (req, res) => {
  const { facId, accountNo } = req.params;
  db.sequelize
    .query(
      "CALL get_beneficiary_no(:accountNo, :facId)",
      {
        replacements: {
          facId,
          accountNo,
        },
      }
      // `select ifnull(max(beneficiaryNo), 0) + 1 AS beneficiaryNo from patientrecords WHERE accountNo=${accountNo} AND facilityId="${facId}"`,
    )
    .then((results) => {
      console.log(results);
      res.json({ success: true, results: results[0] });
    })
    .catch((err) => {
      res.json({ success: false, err });
    });
};

exports.getApprovedAccounts = (req, res) => {
  const { facilityId } = req.params;

  db.sequelize
    .query(
      `SELECT accountNo as account_no, concat(surname, ' ', firstname) as account_name, accName as alt_name, contactPhone, 
        contactAddress, guarantor_name,guarantor_phone,guarantor_address
        FROM patientfileno WHERE facilityId="${facilityId}"`
    )
    .then((results) => {
      res.json({ success: true, results: results[0] });
    })
    .catch((err) => {
      res.json({ success: false, err });
    });
};

exports.getNextPatientNo = (req, res) => {
  const { facId } = req.params;
  db.sequelize
    .query(
      `select ifnull(max(patient_id), 0) + 1 AS id from patientrecords WHERE facilityId="${facId}"`
    )
    .then((results) => {
      res.json({ success: true, results: results[0][0] });
    })
    .catch((err) => {
      res.json({ success: false, err });
    });
};

exports.getPatientInfo = (req, res) => {
  const { patientId, facilityId } = req.params;

  db.sequelize
    .query(
      // 'CALL '
      `SELECT a.id AS id, concat(a.firstname, ' ', a.surname) as name, a.dob, a.Gender as gender, 
        ifnull(a.phoneNo,'') as phone, a.email, b.accountNo,b.accountType
        FROM patientrecords a JOIN patientfileno b ON a.accountNo = b.accountNo
        WHERE a.id = "${patientId}" AND a.facilityId="${facilityId}"`
    )
    .then((results) => res.json({ success: true, results: results[0] }))
    .catch((err) => {
      res.status(500).json({ err });
      console.log(err);
    });
};

exports.getPatientFullInfo = (req, res) => {
  const { patientId, facilityId } = req.params;

  db.sequelize
    .query(
      `SELECT a.id AS id, a.id as patientHospitalId, concat(a.surname, ' ', a.firstname) as name, a.surname, a.firstname,
        a.DOB as dob, a.Gender as gender, 
        ifnull(a.phoneNo,'') as phone, a.email, b.accountNo, b.accountNo as clientAccount,
        b.accountType, a.maritalstatus, 
        a.maritalstatus as maritalStatus, a.email,
        a.state,a.lga,a.occupation,a.address,a.kinName as nextOfKinName,a.kinRelationship as nextOfKinRelationship,
        a.kinPhone as nextOfKinPhone,a.kinAddress as nextOfKinAddress,
        a.beneficiaryNo as clientBeneficiaryAcc,a.balance
        FROM patientrecords a JOIN patientfileno b ON a.accountNo = b.accountNo
        WHERE a.id = "${patientId}" AND a.facilityId="${facilityId}"`
    )
    .then((results) => res.json({ success: true, results: results[0] }))
    .catch((err) => {
      res.status(500).json({ err });
      console.log(err);
    });
};
exports.getUnassignedPatients = (req, res) => {
  const { facilityId } = req.params;
  db.sequelize
    .query("call get_unassigned(:facilityId)", {
      replacements: { facilityId },
    })
    .then((results) => res.json({ results }))
    .catch((err) => res.status(500).json({ err }));
};

exports.patientClarking = (req, res) => {
  const { facilityId } = req.params;
  db.sequelize
    .query(
      'select * from patientrecords where id=1 and facilityId="' +
        facilityId +
        '"',
      {
        type: db.sequelize.QueryTypes.SELECT,
      }
    )
    .then((results) => res.json({ results }))
    .catch((err) => res.status(500).json({ err }));
};

exports.getUsersById = (req, res) => {
  const { id, facilityId } = req.params;
  db.sequelize
    .query("call get_user_by_id(:id, :facilityId)", {
      replacements: { id, facilityId },
    })
    .then((results) => res.json({ results }))
    .catch((err) => res.status(500).json({ err }));
};

exports.getPatientById = (req, res) => {
  const { id, facilityId } = req.params;
  db.sequelize
    .query(
      `SELECT facilityId, title,surname,firstname,other,Gender as gender,maritalstatus as maritalStatus, accountType,
        DOB as dob,dateCreated,phoneNo as phone,email,state,lga,occupation,address,kinName AS nextOfKinName,
        kinRelationship AS nextOfKinRelationship,kinPhone AS nextOfKinPhone,kinEmail AS nextOfKinEmail,
        kinAddress AS nextOfKinAddress,accountNo,beneficiaryNo,balance,id,patient_id,createdAt,patient_passport
        FROM patientrecords 
        WHERE id="${id}" AND facilityId="${facilityId}"`
    )
    .then((results) => res.json({ success: true, results: results[0] }))
    .catch((err) => {
      console.log(err);
      res.status(500).json({ err });
    });
};

exports.updatePatientInformation = (req, res) => {
  const {
    facilityId = "",
    id = "",
    surname = "",
    firstname = "",
    gender = "",
    maritalStatus = "",
    dob = "",
    phone = "",
    email = "",
    occupation = "",
    address = "",
    nextOfKinAddress = "",
    nextOfKinName = "",
    nextOfKinPhone = "",
    nextOfKinRelationship = "",
    nextOfKinEmail = "",
    accountType = "",
  } = req.body;
  console.log(req.body, "FILE:", req.file, req.files);
  // console.log(req.body);
  const patient_passport = req.file && req.file.filename;

  db.sequelize
    .query(
      `UPDATE patientrecords SET accountType="${accountType}", surname="${surname}", firstname="${firstname}", Gender="${gender}",
        maritalstatus="${maritalStatus}", DOB="${dob}",phoneNo="${phone}",email="${email}",occupation="${occupation}",
        address="${address}",kinName="${nextOfKinName}",
        kinRelationship="${nextOfKinRelationship}",kinPhone="${nextOfKinPhone}",kinEmail="${nextOfKinEmail}",
        kinAddress="${nextOfKinAddress}", patient_passport="${patient_passport}"
        WHERE id="${id}" AND facilityId="${facilityId}"`
    )
    .then((results) => res.json({ success: true, results: results[0] }))
    .catch((err) => {
      console.log(err);
      res.status(500).json({ err });
    });
};

exports.doctor = (req, res) => {
  const { doctor, facilityId } = req.params;

  db.sequelize
    .query("call get_patients_by_doctor(:doctor, :facilityId)", {
      replacements: { doctor, facilityId },
    })
    .then((results) => res.json({ results }))
    .catch((err) => res.status(500).json({ err }));
};

exports.getId = (req, res) => {
  const { facilityId } = req.params;
  db.sequelize
    .query("call get_id(:facilityId)", {
      replacements: { facilityId },
    })
    .then((results) => res.json({ id: results[0].nextId }))
    .catch((err) => {
      console.log(err);
      res.status(500).json({ err });
    });
};

exports.getAccount = (req, res) => {
  const { facilityId } = req.params;
  db.sequelize
    .query("call get_account(:facilityId)", {
      replacements: { facilityId },
    })
    .then((results) =>
      res.json({ accountNo: results[0]["max(accountNo) + 1"] })
    )
    .catch((err) => res.status(500).json({ err }));
};

// exports.saveNewPatientInfo = (req, res) => {
//   const {
//     accountType,
//     clientAccount,
//     clientBeneficiaryAcc,
//     patientNo,
//     patientId,
//     patientHospitalId,
//     firstname,
//     surname,
//     gender,
//     dob,
//     maritalStatus,
//     occupation,
//     phone,
//     email,
//     address,
//     nextOfKinName,
//     nextOfKinRelationship,
//     nextOfKinPhone,
//     nextOfKinEmail,
//     nextOfKinAddress,
//   } = req.body;

//   db.sequelize.query(`CALL create_new_client_acc(:accountType,:surname,:firstname,:gender,:dob,:maritalStatus
//     :occupation,:address,:)`)
// };

exports.newRecord = (req, res) => {
  const {
    id,
    accountNo,
    beneficiaryNo,
    title = "",
    firstname = "",
    surname = "",
    other = "",
    Gender = "",
    age = "",
    maritalstatus = "",
    DOB = "",
    phoneNo = "",
    email = "",
    state = "",
    lga = "",
    occupation = "",
    address = "",
    kinName = "",
    kinRelationship = "",
    kinPhone = "",
    kinEmail = "",
    kinAddress = "",
    enteredBy = "",
    facilityId = "",
  } = req.body;
  const today = moment().format("YYYY-MM-DD");
  db.sequelize
    .query(
      `insert into patientrecords(id,accountNo,beneficiaryNo,title,firstname,surname,other,Gender,age,maritalstatus,DOB,phoneNo,email,state,lga,occupation,address,kinName,kinRelationship,kinPhone,kinEmail,kinAddress,dateCreated,enteredBy,facilityId) values(
    "${id}" ,
	"${accountNo ? accountNo : ""}", 
	"${beneficiaryNo ? beneficiaryNo : ""}", 
    "${title}", 
    "${firstname}", 
    "${surname}", 
    "${other}", 
    "${Gender}", 
    "${age}",
    "${maritalstatus}",
    "${DOB}", 
    "${phoneNo}", 
    "${email}",
    "${state}", 
    "${lga}", 
    "${occupation}",
    "${address}", 
    "${kinName}", 
    "${kinRelationship}", 
    "${kinPhone}", 
    "${kinEmail}", 
    "${kinAddress}", 
    ${today} ,
    "${enteredBy}",  
    "${facilityId}")`,
      {
        type: db.sequelize.QueryTypes.INSERT,
      }
    )
    .then((results) => {
      // res.json({ results })
      db.sequelize
        .query(
          `UPDATE patientfileno set beneficiaries = beneficiaries + 1 where accountNo = ${req.body.accountNo}`,
          {
            type: db.sequelize.QueryTypes.UPDATE,
          }
        )
        .then((results2) => res.json({ success: true, results2 }))
        .catch((err2) => res.status(500).json({ success: false, err2 }));
    })
    .catch((err) => {
      res.status(500).json({ err });
      console.log(err);
    });
};

exports.upload = (req, res) => {
  db.sequelize
    .query(
      'insert into patientrecords(passport) values("' + req.body.fd + '")',
      {
        type: db.sequelize.QueryTypes.INSERT,
      }
    )
    .then((results) => res.json({ results }))
    .catch((err) => res.status(500).json({ err }));
};

exports.edit = (req, res) => {
  db.sequelize
    .query(
      'update patientrecords set  title = "' +
        req.body.title +
        '",firstname = "' +
        req.body.firstname +
        '",surname = "' +
        req.body.surname +
        '",other = "' +
        req.body.other +
        '",Gender = "' +
        req.body.Gender +
        '",age = "' +
        req.body.age +
        '", maritalstatus = "' +
        req.body.maritalstatus +
        '",DOB = "' +
        req.body.DOB +
        '",phoneNo = "' +
        req.body.phoneNo +
        '",email = "' +
        req.body.email +
        '",state = "' +
        req.body.state +
        '",lga = "' +
        req.body.lga +
        '",occupation = "' +
        req.body.occupation +
        '",address = "' +
        req.body.address +
        '",kinName = "' +
        req.body.kinName +
        '",kinRelationship = "' +
        req.body.kinRelationship +
        '",kinPhone = "' +
        req.body.kinPhone +
        '",kinEmail = "' +
        req.body.kinEmail +
        '",kinAddress = "' +
        req.body.kinAddress +
        '" where id = "' +
        req.body.id +
        '"',
      {
        type: db.sequelize.QueryTypes.UPDATE,
      }
    )
    .then((results) => res.json({ results }))
    .catch((err) => res.status(500).json({ err }));
};

exports.delete = (req, res) => {
  db.sequelize
    .query('delete from patientrecords where id= "' + req.body.id + '"', {
      type: db.sequelize.QueryTypes.DELETE,
    })
    .then((results) => res.json({ results }))
    .catch((err) => res.status(500).json({ err }));
};

exports.assign = (req, res) => {
  const {
    id = "",
    assigned_to = "",
    facilityId = "",
    query_type = "",
  } = req.body;

  db.sequelize
    .query(`call assign(:assigned_to,:id, :facilityId,:query_type)`, {
      replacements: { assigned_to, id, facilityId, query_type },
    })
    .then((results) => res.json({ results }))
    .catch((err) => res.status(500).json({ err }));
};

exports.assignQuery = (req, res) => {
  const {
    id = "",
    assigned_to = "",
    facilityId = "",
    query_type = "",
  } = req.query;

  db.sequelize
    .query(`call assign(:assigned_to,:id, :facilityId,:query_type)`, {
      replacements: { assigned_to, id, facilityId, query_type },
    })
    .then((results) => res.json({ results }))
    .catch((err) => res.status(500).json({ err }));
};

exports.patientAssignedToday = (req, res) => {
  const { facilityId } = req.params;
  const today = moment().format("YYYY-MM-DD");
  db.sequelize
    .query("call patients_assigned_today(:today, :facilityId)", {
      replacements: { today, facilityId },
    })
    .then((results) => res.json({ results }))
    .catch((err) => res.status(500).json({ err }));
};


exports.getAllLabServices = (req, res) => {
  const { facilityId } = req.params;
  const { query_type = "" } = req.query;

  // const stmt = 'call get_all_lab_services(:facilityId)';
  const stmt = `CALL get_all_lab_services(:facilityId,:query_type,:lab)`;
  db.sequelize
    .query(stmt, { replacements: { facilityId, query_type, lab: "" } })
    .then((results) => res.json({ success: true, results }))
    .catch((err) => {
      console.log(err);
      res.status(500).json({ err });
    });
};


exports.fetchByDoctor = (req, res) => {
  const { assigned_to } = req.body;
  const { facilityId } = req.params;
  db.sequelize
    .query(`call fetch_by_doctor(:assigned_to, :facilityId)`, {
      replacements: { assigned_to, facilityId },
    })
    .then((results) => res.json({ results }))
    .catch((err) => res.status(500).json({ err }));
};

exports.getAll = (req, res) => {
  const { facilityId } = req.params;
  db.sequelize
    .query("call get_all(:facilityId)", {
      replacements: { facilityId },
    })
    .then((results) => res.json({ results }))
    .catch((err) => res.status(500).json({ err }));
};

exports.getIds = (req, res) => {
  const { facilityId } = req.params;
  db.sequelize
    .query("call get_ids(:facilityId)", {
      replacements: { facilityId },
    })
    .then((results) => {
      const arr = [];
      results.forEach((i) => arr.push(i.accountNo));
      res.json({ arr });
    })
    .catch((err) => res.status(500).json({ err }));
};

exports.getBeneficiaryNo = (req, res) => {
  const { accountNo, facilityId } = req.params;
  db.sequelize
    .query("call get_beneficiary_no(:accountNo,:facilityId)", {
      replacements: { accountNo, facilityId },
    })
    .then((results) => res.json({ beneficiaryNo: results[0].beneficiaryNo }))
    .catch((err) => res.status(500).json({ err }));
};

// exports.operationNote = (req, res) => {
//   queryOperationNotes(
//     req.body,
//     (results) => {
//       res.json({ success: true, results })
//     },
//     (err) => {
//       console.log(err)
//       res.status(500).json({ success: false, err })
//     },
//   )
// }

exports.getClientAccNos = (req, res) => {
  const { facilityId } = req.query;
  db.sequelize
    .query("call get_client_accounts(:facilityId)", {
      replacements: { facilityId },
    })
    .then((results) => res.json({ results }))
    .catch((err) => {
      console.log(err);
      res.status(500).json({ err });
    });
};

exports.surgicalNote = (req, res) => {
  const {
    template = "",
    patient_name = "",
    relative = "",
    agreed = "",
    witness_by = "",
    patient_id = "",
    created_at = moment().format("YYYY-MM-DD hh:mm:ss"),
    created_by = "",
  } = req.body;
  const { query_type = "", facilityId = "" } = req.query;
  db.sequelize
    .query(
      "call surgical_note(:template,:patient_name, :relative, :agreed, :witness_by, :patient_id, :created_at, :created_by,:facilityId,:query_type)",
      {
        replacements: {
          template,
          patient_name,
          relative,
          agreed,
          witness_by,
          patient_id,
          created_at,
          created_by,
          facilityId,
          query_type,
        },
      }
    )
    .then((results) => res.json({ results }))
    .catch((err) => {
      console.log(err);
      res.status(500).json({ err });
    });
};

//android-studio/bin$ sudo ./studio.sh
