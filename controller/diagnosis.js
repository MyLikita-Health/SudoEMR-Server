const moment = require("moment");
const { error } = require("winston");
const db = require("../models");
// const { _saveRequestHistory } = require("./lab");
// const moment = require('moment');

exports.newDiagnosis = (req, res) => {
  const {
    BMR,
    LLL,
    RLL,
    RUL,
    abdomen,
    allergy,
    drugAllergy,
    asthmatic,
    athropometry_height,
    athropometry_weight,
    bloodpressure,
    cns,
    cvs,
    date,
    dehydration,
    development,
    diabetic,
    dresswith,
    drugHistory,
    eye_opening,
    generalexamination,
    headcircumference,
    pastSurgicalHistory,
    hypertensive,
    patient_id,
    immunization,
    management_plan,
    mss,
    muac,
    nutrition,
    observation_request,
    obtsGyneaHistory,
    otherAllergies,
    otherSocialHistory,
    otherSysExamination,
    others,
    palor,
    partToDress,
    pastMedicalHistory,
    pbnh,
    problem1,
    problem2,
    problem3,
    problem4,
    problem5,
    provisionalDiagnosis1,
    provisionalDiagnosis2,
    provisionalDiagnosis3,
    provisionalDiagnosis4,
    provisionalDiagnosis5,
    pulse,
    respiratory,
    respiratoryRate,
    seen_by,
    social,
    tempreture,
    vital_height,
    vital_weight,
    hypertensiveDuration,
    optimalSugarControl,
    hypertensiveRegularOnMedication,
    facilityId,
    presenting_complaints,
  } = req.body;

  console.log(req.body);

  const stmt = `insert into diagnosis (presenting_complaints,BMR, LLL, RLL, RUL, abdomen, allergy, drugAllergy, asthmatic, athropometry_height, athropometry_weight, bloodpressure, cns, cvs, dehydration, development, diabetic, dresswith, drugHistory, eye_opening, generalexamination, headcircumference, pastSurgicalHistory, hypertensive, patient_id, immunization, management_plan, mss, muac, nutrition, observation_request, obtsGyneaHistory, otherAllergies, otherSocialHistory, otherSysExamination, others, palor, partToDress, pastMedicalHistory, pbnh, problem1, problem2, problem3, problem4, problem5, provisionalDiagnosis1, provisionalDiagnosis2, provisionalDiagnosis3, provisionalDiagnosis4, provisionalDiagnosis5, pulse, respiratory, respiratoryRate, seen_by, social, tempreture, vital_height, vital_weight,hypertensiveDuration,hypertensiveRegularOnMedication,optimalSugarControl,status,facilityId) 
      values("${presenting_complaints}","${BMR}","${LLL}","${RLL}","${RUL}","${abdomen}","${allergy}",
      "${drugAllergy}","${asthmatic}","${athropometry_height}","${athropometry_weight}","${bloodpressure}",
      "${cns}","${cvs}","${dehydration}","${development}","${diabetic}","${dresswith}","${drugHistory}",
      "${eye_opening}","${generalexamination}","${headcircumference}","${pastSurgicalHistory}","${hypertensive}",
      "${patient_id}","${immunization}","${management_plan}","${mss}","${muac}","${nutrition}","${observation_request}",
      "${obtsGyneaHistory}","${otherAllergies}","${otherSocialHistory}","${otherSysExamination}","${others}","${palor}",
      "${partToDress}","${pastMedicalHistory}","${pbnh}","${problem1}","${problem2}","${problem3}","${problem4}",
      "${problem5}","${provisionalDiagnosis1}","${provisionalDiagnosis2}","${provisionalDiagnosis3}",
      "${provisionalDiagnosis4}","${provisionalDiagnosis5}","${pulse}","${respiratory}","${respiratoryRate}",
      "${seen_by}","${social}","${tempreture}","${vital_height}","${vital_weight}","${hypertensiveDuration}",
      "${hypertensiveRegularOnMedication}","${optimalSugarControl}","seen","${facilityId}")`;
  const stmt2 = `UPDATE patientrecords set assigned_to="" and date_assigned=null where id="${patient_id}" and facilityId="${facilityId}"`;

  db.sequelize
    .query(stmt)
    .then(() => {
      db.sequelize
        .query(stmt2)
        .then((results) => {
          res.json({ results });
        })
        .catch((err) => res.status(500).json({ err }));
    })
    .catch((err) => res.status(500).json({ err }));
};

exports._consultationRecord = (req, res) => {
  const today = moment().format("YYYY-MM-DD");
  const {
    query_type = "list",
    report_type = "by_date",
    presenting_complaints = "",
    patientStatus = "",
    dressingInfo = "",
    facilityId = "",
    consult_id = "",
    patient_id = "",
    treatmentPlan = "",
    report_date = today,
    admissionStatus = "",
    userId = null,
    nursingReq = null,
    dateFrom = today,
    dateTo = today,
    patient_name = "",
    created_by = "",
  } = req.query;
  switch (query_type) {
    case "insert":
      db.sequelize
        .query(
          `INSERT INTO consultations (id, consultation_notes,userId, decision, dressing_request, nursing_request,facilityId,patient_id,treatmentPlan,patient_name,seen_by,created_at) 
        VALUES ("${consult_id}", "${presenting_complaints}", "${userId}", "${patientStatus}", "${dressingInfo}", "${nursingReq}","${facilityId}","${patient_id}","${treatmentPlan}","${patient_name}","${created_by}","${report_date}");`
        )
        .then((results) => {
          if (admissionStatus === "pending") {
            db.sequelize
              .query(
                `UPDATE patientrecords SET patientStatus='pending-admission', seen_by="${userId}", date_seen="${report_date}" WHERE id='${patient_id}' AND facilityId="${facilityId}";`
              )
              .then((results) => {
                res.json({ success: true, results });
              })
              .catch((err) => {
                console.log(err);
                res.status(500).json({ success: false, err });
              });
          } else {
            res.json({ success: true, results });
          }
        })
        .catch((err) => {
          console.log(err);
          res.status(500).json({ success: false, err });
        });

      break;
    case "update":
      db.sequelize
        .query(
          `UPDATE consultations SET consultation_notes=:consultation_note, treatmentPlan=:treatment_plan, updatedAt=:date WHERE id=:consult_id;`,
          {
            replacements: {
              consultation_note: presenting_complaints,
              treatmentPlan: treatmentPlan,
              date: report_date,
              consult_id: consult_id,
            },
          }
        )
        .then((results) => {
          res.json({ success: true, results: results });
        })
        .catch((err) => {
          console.log(err);
          res.status(500).json({ success: false, err });
        });
      break;
    case "list by patient":
      if (report_type === "by_date") {
        db.sequelize
          .query(
            `SELECT a.id, a.patient_id, a.userId, b.firstname ||' '|| b.lastname as reviewedBy, a.consultation_notes, a.treatmentPlan, a.decision, a.dressing_request, a.nursing_request, a.nursing_request_status, a.facilityId, a.created_at FROM consultations a JOIN users b ON a.userId = b.username WHERE patient_id=:pid AND date(a.created_at)=:report_date ORDER BY a.created_at DESC;`,
            {
              replacements: {
                pid: patient_id,
                report_date: report_date,
              },
            }
          )
          .then((results) => {
            res.json({ success: true, results: results[0] });
          })
          .catch((err) => {
            console.log(err);
            res.status(500).json({ success: false, err });
          });
      } else {
        db.sequelize
          .query(
            `SELECT a.id, a.patient_id, a.userId, b.firstname ||' '|| b.lastname as reviewedBy, a.consultation_notes, a.treatmentPlan, a.decision, a.dressing_request, a.nursing_request, a.nursing_request_status, a.facilityId, a.created_at FROM consultations a JOIN users b ON a.userId = b.username WHERE patient_id=:pid ORDER BY created_at DESC;`,
            {
              replacements: {
                pid: patient_id,
              },
            }
          )
          .then((results) => {
            res.json({ success: true, results: results[0] });
          })
          .catch((err) => {
            console.log(err);
            res.status(500).json({ success: false, err });
          });
      }
      break;
    case "by_id":
      db.sequelize
        .query(` SELECT * FROM consultations WHERE id=:consult_id;`, {
          replacements: {
            consult_id,
          },
        })
        .then((results) => {
          res.json({ success: true, results: results[0] });
        })
        .catch((err) => {
          console.log(err);
          res.status(500).json({ success: false, err });
        });
      break;
    case "pending nursing requests":
      db.sequelize
        .query(
          ` SELECT id, nursing_request,dressing_request, nursing_request_status,treatmentPlan FROM consultations WHERE nursing_request_status='pending' AND facilityId=:facilityId`,
          {
            replacements: {
              facilityId,
            },
          }
        )
        .then((results) => {
          res.json({ success: true, results: results[0] });
        })
        .catch((err) => {
          console.log(err);
          res.status(500).json({ success: false, err });
        });
      break;
    case "nursing_req_by_patient":
      db.sequelize
        .query(
          `SELECT a.id, a.created_at, nursing_request,dressing_request, nursing_request_status, b.firstname||' '||b.lastname as doctor_name FROM consultations a JOIN users b ON a.userId = b.username WHERE a.facilityId=b.facilityId AND patient_id=:pid AND nursing_request_status='pending' AND  a.facilityId=:facilityId AND (nursing_request!='' OR dressing_request!='') ORDER BY a.created_at DESC;`,
          {
            replacements: {
              facilityId,
            },
          }
        )
        .then((results) => {
          res.json({ success: true, results: results[0] });
        })
        .catch((err) => {
          console.log(err);
          res.status(500).json({ success: false, err });
        });
      break;
    case "treatment_plan_by_patient":
      db.sequelize
        .query(
          `SELECT a.id, a.created_at, treatmentPlan, b.firstname ||' '|| b.lastname as doctor_name FROM consultations a JOIN users b ON a.userId = b.username WHERE a.facilityId=b.facilityId AND patient_id=in_pid AND treatment_plan_status='pending' AND  a.facilityId=:facilityId AND treatmentPlan!='' ORDER BY a.created_at DESC;`,
          {
            replacements: {
              facilityId,
            },
          }
        )
        .then((results) => {
          res.json({ success: true, results: results[0] });
        })
        .catch((err) => {
          console.log(err);
          res.status(500).json({ success: false, err });
        });
      break;
    case "complete nursing req":
      db.sequelize
        .query(
          `UPDATE consultations SET nursing_request_status='completed',updatedAt=:date WHERE id=:consult_id;`,
          {
            replacements: {
              consult_id,
              date: report_date,
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
      break;
    case "treatment-done":
      db.sequelize
        .query(
          `UPDATE consultations SET treatment_plan_status='completed', treatment_by=in_user_id,updatedAt=:date WHERE id=:consult_id;`,
          {
            replacements: {
              consult_id,
              date: report_date,
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
      break;
    case "visit_days":
      db.sequelize
        .query(
          `SELECT DISTINCT date(created_at) as created_at FROM consultations WHERE patient_id=:pid ORDER BY created_at DESC;`,
          {
            replacements: {
              pid: patient_id,
            },
          }
        )
        .then((results) => {
          res.json({ success: true, results: results[0] });
        })
        .catch((err) => {
          console.log(err);
          res.status(500).json({ success: false, err });
        });
      break;

    case "surgery_days":
      db.sequelize.query(
        `SELECT DISTINCT date(createdAt) as created_at FROM operationnotes WHERE patientId=pid ORDER BY createdAt DESC;`,
        {
          replacements: {
            pid: patient_id,
          },
        }
      );
      break;

    case "history":
      db.sequelize
        .query(
          `SELECT a.patient_id, a.userId, a.consultation_notes, a.treatmentPlan, a.decision, a.dressing_request, a.nursing_request, a.nursing_request_status, a.facilityId, a.created_at, a.treatment_plan_status, a.treatment_by, b.surname || ' ' || b.firstname || ' ' || ifnull(b.other, '') as full_name FROM consultations a JOIN patientrecords b WHERE a.patient_id=b.id and a.facilityId=b.facilityId AND a.userId=:userId AND a.facilityId=:facilityId AND DATE(a.created_at) BETWEEN date(:dateFrom) AND date(:dateTo) ORDER BY a.created_at DESC;`,
          {
            replacements: {
              userId,
              facilityId,
              dateFrom,
              dateTo,
            },
          }
        )
        .then((results) => {
          res.json({ success: true, results: results[0] });
        })
        .catch((err) => {
          console.log(err);
          res.status(500).json({ success: false, err });
        });
      break;
    default:
      break;
  }
};

exports.getConsultation = (req, res) => {
  const today = moment().format("YYYY-MM-DD");
  const {
    query_type = "list",
    report_type = "by_date",
    presenting_complaints = "",
    patientStatus = "",
    dressingInfo = "",
    facilityId = "",
    consult_id = "",
    patient_id = "",
    treatmentPlan = "",
    report_date = today,
    admissionStatus = "",
    userId = null,
    nursingReq = null,
    dateFrom = today,
    dateTo = today,
    patient_name = "",
    created_by = "",
  } = req.query;
  // console.log(req.query)
  db.sequelize
    .query(
      `CALL consultation_record(:query_type,:presenting_complaints,:patientStatus,:dressingInfo,
        :nursingReq,:userId,:facilityId,:consult_id,:patient_id,:treatmentPlan,:report_type,
        :report_date,:admissionStatus,:dateFrom,:dateTo,:patient_name,:created_by)`,
      {
        replacements: {
          query_type,
          presenting_complaints,
          patientStatus,
          dressingInfo,
          nursingReq,
          userId,
          facilityId,
          consult_id,
          patient_id,
          treatmentPlan,
          report_type,
          report_date,
          admissionStatus,
          dateFrom,
          dateTo,
          patient_name,
          created_by,
        },
      }
    )
    .then((results) => {
      // if ((query_type = 'list by patient')) {
      //   // const
      // } else {
      res.json({ success: true, results });
      // }
    })
    .catch((err) => {
      console.log(err);
      res.status(500).json({ success: false, err });
    });
};

const pendingLabTxn = (data, callback = (f) => f, error = (f) => f) => {
  const {
    account = "0",
    query_type = "",
    description = "",
    group = "0",
    price = "0",
    test = "0",
    consult_id = "",
    status = "",
  } = data;
  db.sequelize
    .query(
      "CALL save_pending_lab_tx(:query_type,:account,:description,:group,:price,:test,:req_id,:status)",
      {
        replacements: {
          query_type: query_type,
          account: account,
          description: description,
          group: group,
          price: price,
          test: test,
          req_id: consult_id,
          status: status,
        },
      }
    )
    .then((results) => callback(results))
    .catch((err) => error(err));
};

exports.getPendingLabTxn = (req, res) => {
  const { query_type, consult_id } = req.query;
  pendingLabTxn(
    { query_type, consult_id },
    (results) => {
      res.json({ success: true, results });
    },
    (err) => {
      res.status(500).json({ success: false, err });
    }
  );
};

exports.consultationRecord = (req, res) => {
  const today = moment().format("YYYY-MM-DD");
  const {
    presenting_complaints = "",
    patientStatus = "",
    admissionStatus = "",
    dressingInfo = "",
    nursingReq = "",
    userId = "",
    facilityId = "",
    consult_id = "",
    patient_id = "",
    treatmentPlan = "",
    labInvestigations = [],
    report_date = today,
    patient_name = "",
    created_by = "",
  } = req.body;
  console.log(req.body);
  // console.log(req.body.labInvestigations.detail);

  db.sequelize
    .query(
      `INSERT INTO consultations (id, consultation_notes,userId, decision, dressing_request, nursing_request,facilityId,patient_id,treatmentPlan,patient_name,seen_by,created_at) 
    VALUES ("${consult_id}", "${presenting_complaints}", "${userId}", "${patientStatus}", "${dressingInfo}", "${nursingReq}","${facilityId}","${patient_id}","${treatmentPlan}","${patient_name}","${created_by}","${report_date}");`
    )
    .then((results) => {
      if (admissionStatus === "pending") {
        db.sequelize
          .query(
            `UPDATE patientrecords SET patientStatus='pending-admission', seen_by="${userId}", date_seen="${report_date}" WHERE id='${patient_id}' AND facilityId="${facilityId}";`
          )
          .then((results) => {
            res.json({ success: true, results });
          })
          .catch((err) => {
            console.log(err);
            res.status(500).json({ success: false, err });
          });
      } else {
        res.json({ success: true, results });
      }
    })
    .then((results) => {
      labInvestigations &&
        labInvestigations.detail &&
        labInvestigations.detail.forEach((item) => {
          console.log(JSON.stringify(item));
          _doctorLabRequest({
            department: item.department,
            test: item.test,
            percentage: item.percentage,
            price: item.price,
            code: item.code,
            noOfLabels: item.noOfLabels,
            test_group: item.test_group,
            print_type: item.print_type,
            label_type: item.label_type,
            patient_id: labInvestigations.patient_id,
            requested_by: labInvestigations.requested_by,
            facilityId: labInvestigations.facilityId,
            status: labInvestigations.status,
            query_type: "insert",
            request_id: consult_id,
            description: item.description,
            in_account: item.account,
            patientStatus:
              patientStatus === "admit" ? "In-Patient" : "Out-Patient",
            in_patient_name: item.patient_name,
          });
        });

      // _saveRequestHistory(patient_id, consult_id, "", "", "insert", facilityId);
      res.json({ success: true, results, message: "File Upload successfully" });
    })
    .catch((err) => {
      console.log(err);
      res.status(500).json({
        success: false,
        err,
        message: "Error occur before submitting",
      });
    });
};

function _doctorLabRequest(data, callback = (f) => f, error = (f) => f) {
  const {
    department = "",
    test = "",
    percentage = "",
    price = "",
    code = "",
    noOfLabels = "",
    test_group = "",
    print_type = "",
    label_type = "",
    patient_id = "",
    requested_by = "",
    facilityId = "",
    status = "",
    query_type = "",
    request_id = "",
    description = "",
    patientStatus = "",
    from = "",
    to = "",
    in_created_by = "",
    in_receiptDateSN = "",
    in_payment_status = "",
    in_old_price = "",
    in_payables_head = "",
    in_recievables_head = "",
    in_account = "",
    in_account_name = "",
    in_patient_name = "",
    in_department_code = "",
    in_unit_code = "",
    in_unit_name = "",
    in_unit = "",
    in_range_from = "",
    in_range_to = "",
    in_client_type = "",
    in_client_account = "",
    in_discount = "",
    in_discount_head = "",
    in_discount_head_name = "",
    in_approval_status = "",
    in_discount_amount = "",
    in_request_id = "",
  } = data;

  switch (query_type) {
    case "insert":
      db.sequelize
        .query(
          `INSERT INTO lab_requisition(test,patient_id,facilityId,price,percentage,
        department,test_group,status,created_by,receiptNo,payment_status,label_type,noOfLabels,
        print_type,payable_head,receivable_head,account,account_name,
        patient_name,department_code,unit_code,unit_name,unit,range_from,range_to,client_type,
        client_account,discount,discount_head,discount_head_name,approval_status,discount_amount,request_id, patient_status, requested_by,description) 
    VALUES ("${test}","${patient_id}","${facilityId}","${price}","${percentage}","${department}","${test_group}",
        "${status}","${in_created_by}","${in_receiptDateSN}","${in_payment_status}",in_label_type,in_noOfLabels,
        in_print_type,"${in_payables_head}","${in_recievables_head}","${in_account}","${in_account_name}",
        "${in_patient_name}","${in_department_code}","${in_unit_code}","${in_unit_name}","${in_unit}","${in_range_from}", in_range_to,
        "${in_client_type}","${in_client_account}","${in_discount}","${in_discount_head}","${in_discount_head_name}","${in_approval_status}",
        "${in_discount_amount}",in_req_id,in_patient_status,in_requested_by,in_description);`
        )
        .then((results) => callback(results))
        .catch((err) => error(err));
      break;
          case 'ordered_list':
            
          break;
    default:
      break;
  }

  // db.sequelize
  //   .query(
  //     `CALL doctorLabRequest(:department,:test,:percentage,:price,:code,
  //       :noOfLabels,:test_group,:print_type,:label_type,:patient_id,
  //       :requested_by,:facilityId,:status,:query_type,:request_id,:description,
  //       :patientStatus,:from,:to,:in_created_by,:in_receiptDateSN,:in_payment_status,
  //       :in_old_price,:in_payables_head,:in_recievables_head,:in_account,:in_account_name,
  //       :in_patient_name,:in_department_code,:in_unit_code,:in_unit_name,:in_unit,:in_range_from,
  //       :in_range_to,:in_client_type,:in_client_account,:in_discount,:in_discount_head,
  //       :in_discount_head_name,:in_approval_status,:in_discount_amount,:in_request_id)`,
  //     {
  //       replacements: {
  //         department,
  //         test,
  //         percentage,
  //         price,
  //         code,
  //         noOfLabels,
  //         test_group,
  //         print_type,
  //         label_type,
  //         patient_id,
  //         requested_by,
  //         facilityId,
  //         status,
  //         query_type,
  //         request_id,
  //         description,
  //         patientStatus,
  //         from,
  //         to,
  //         in_created_by,
  //         in_receiptDateSN,
  //         in_payment_status,
  //         in_old_price,
  //         in_payables_head,
  //         in_recievables_head,
  //         in_account,
  //         in_account_name,
  //         in_patient_name,
  //         in_department_code,
  //         in_unit_code,
  //         in_unit_name,
  //         in_unit,
  //         in_range_from,
  //         in_range_to,
  //         in_client_type,
  //         in_client_account,
  //         in_discount,
  //         in_discount_head,
  //         in_discount_head_name,
  //         in_approval_status,
  //         in_discount_amount,
  //         in_request_id,
  //       },
  //     }
  //   )

  // .then((results) => callback(results))
  // .catch((err) => error(err));
}

exports.doctorLabRequest = _doctorLabRequest;

exports.getOrderedLabs = (req, res) => {
  const today = moment().format("YYYY-MM-DD");
  const {
    department,
    test,
    percentage,
    price,
    code,
    noOfLabels,
    test_group,
    print_type,
    label_type,
    patient_id,
    requested_by,
    facilityId,
    status,
    query_type,
    request_id,
    from = today,
    to = today,
  } = req.query;
  _doctorLabRequest(
    {
      department,
      test,
      percentage,
      price,
      code,
      noOfLabels,
      test_group,
      print_type,
      label_type,
      patient_id,
      requested_by,
      facilityId,
      status,
      query_type,
      request_id,
      from,
      to,
    },
    (results) => res.json({ success: true, results }),
    (err) => {
      console.log(err);
      res.status(500).json({ err });
    }
  );
};

exports.updateLabRequest = (req, res) => {
  const {
    department,
    test,
    percentage,
    price,
    code,
    noOfLabels,
    test_group,
    print_type,
    label_type,
    patient_id,
    requested_by,
    facilityId,
    status,
    query_type,
    request_id,
  } = req.body;

  _doctorLabRequest(
    {
      department,
      test,
      percentage,
      price,
      code,
      noOfLabels,
      test_group,
      print_type,
      label_type,
      patient_id,
      requested_by,
      facilityId,
      status,
      query_type,
      request_id,
    },
    (results) => res.json({ success: true, results }),
    (err) => {
      console.log(err);
      res.status(500).json({ err });
    }
  );
};

exports.getDiagnosisByPatientID = (req, res) => {
  const { patientId, facilityId } = req.params;
  db.sequelize
    .query("call get_diagnoses_by_id(:patientId,:facilityId)", {
      replacements: { patientId, facilityId },
    })
    .then((results) => res.json({ results }))
    .catch((err) => res.status(500).json({ err }));
};

exports.saveNewInventory = (req, res) => {
  const {
    batchCode,
    itemType,
    supplier,
    price,
    quantity,
    invoiceNo,
    reorderLevel,
    facilityId,
    userId,
  } = req.body;

  db.sequelize
    .query(
      `INSERT INTO lab_inventory_table (batch_code,item_name,supplier,price,
        quantity,invoice_no,re_order_level,facilityId,created_by) 
        VALUES ("${batchCode}","${itemType}","${supplier}","${price}",
        "${quantity}","${invoiceNo}","${reorderLevel}","${facilityId}","${userId}")`
    )
    .then((results) => res.json({ success: true, results }))
    .catch((err) => res.status(500).json({ err }));
};
exports.getLabInventoryAll = (req, res) => {
  const { facilityId } = req.params;

  db.sequelize
    .query(`SELECT * FROM lab_inventory_table WHERE facilityId="${facilityId}"`)
    .then((results) => res.json({ success: true, results: results[0] }))
    .catch((err) => res.status(500).json({ err, success: false }));
};

exports.getLabPreview = (req, res) => {
  const {
    department,
    test,
    percentage,
    price,
    code,
    noOfLabels,
    subhead,
    print_type,
    label_type,
    patient_id,
    requested_by,
    status,
    facilityId,
  } = req.body;
  const { query_type } = req.query;
  db.sequelize
    .query(
      `CALL doctorLabRequest(:department,:test,:percentage,:price,:code,
      :noOfLabels,:test_group,:print_type,:label_type,:patient_id,
      :requested_by,:facilityId,:status,:query_type)`,
      {
        replacements: {
          department: department ? department : null,
          test: test ? test : null,
          percentage: percentage ? percentage : null,
          price: price ? price : null,
          code: code ? code : null,
          noOfLabels: noOfLabels ? noOfLabels : null,
          test_group: subhead ? subhead : null,
          print_type: print_type ? print_type : null,
          label_type: label_type ? label_type : null,
          patient_id: patient_id ? patient_id : null,
          requested_by: requested_by ? requested_by : requested_by,
          facilityId: facilityId ? facilityId : null,
          status: status ? status : null,
          query_type,
        },
      }
    )
    .then((results) => res.json({ results }))
    .catch((err) => res.status(500).json({ err }));
};
