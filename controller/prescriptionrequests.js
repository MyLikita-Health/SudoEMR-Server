const db = require("../models");
const moment = require("moment");
// const { queryDrugFreq } = require('./pharmacy')

// .query(`insert into dispensary(drug,quantity_dispensed,amount,expiry_date,by_whom,payment_status,receipt_no,facilityId) VALUES ${data
exports.dispense = (req, res) => {
  const { patientId } = req.params;
  db.sequelize
    .query("call get_diagnoses_by_id(:patientId)", {
      replacements: { patientId },
    })
    .then((results) => res.json({ results }))
    .catch((err) => res.status(500).json({ err }));
};

exports.newPrescription = (req, res) => {
  const { data, decision, facilityId } = req.body;
  let patientStatus = data[0][12];
  let patientId = data[0][5];

  db.sequelize
    .query(
      `insert into dispensary(drug,dosage,period,duration,frequency,patient_id,prescribed_by,
        facilityId,status,request_id,route,additionalInfo,decision,startTime,times_per_day,
        id,end_date) VALUES ${data.map((a) => "(?)").join(",")};`,
      { replacements: data }
    )
    .then((results) => {
      console.log(
        results,
        "-------------------------------------------------------------------------"
      );
      if (patientStatus === "admit") {
        doSchedule({ patient_id: patientId, facilityId }, () => {
          console.log("drug schedule run successfully");
          res.json({ results });
        });
      } else {
        res.json({ results });
      }
    })
    .catch((err) => res.json({ err }));
};

function savePrescription(
  {
    drug = "",
    dosage = "",
    period = "",
    duration = "",
    frequency = "",
    patient_id = "",
    prescribed_by = "",
    facilityId = "",
    status = "",
    request_id = "",
    route = "",
    additionalInfo = "",
    decision = "",
    startTime = "",
    times_per_day = "0",
    id = "",
    end_date = "",
    no_of_days = 0,
    drug_count = 0,
    no_times = 0,
  },
  callback = (f) => f,
  error = (f) => f
) {
  db.sequelize
    .query(
      `CALL new_prescription(:drug,:dosage,:period,:duration,:frequency,:patient_id,:prescribed_by,
        :facilityId,:status,:request_id,:route,:additionalInfo,:decision,:startTime,:times_per_day,
        :id,:end_date, :no_of_days, :drug_count, :no_times)`,
      {
        replacements: {
          drug,
          dosage,
          period,
          duration,
          frequency,
          patient_id,
          prescribed_by,
          facilityId,
          status,
          request_id,
          route,
          additionalInfo,
          decision,
          startTime,
          times_per_day,
          id,
          end_date,
          no_of_days,
          drug_count,
          no_times,
        },
      }
    )
    .then((r) => callback(r))
    .catch((err) => error(err));
}

// exports.newPrescriptionBatch = (req, res) => {
//   const { data, decision, facilityId, patientId } = req.body
//   // let patientStatus = data[0][12]
//   // let patientId = data[0][5]

//   for (let i = 0; i < data.length; i++) {
//     let currentP = data[i]
//     let currentHr = moment().format('HH:mm')
//     let currentDate = moment().format('YYYY-MM-DD')

//     let no_of_days = Math.round(
//       moment
//         .duration(
//           moment().add(currentP.duration, currentP.period).diff(moment()),
//         )
//         .asDays(),
//     )
//     console.log('Calculated Number of days =====================> ', no_of_days)

//     queryDrugFreq(
//       {
//         facilityId: facilityId,
//         query_type: 'freq_details',
//         param: currentP.frequency,
//         current_hour: currentHr,
//         current_date: currentDate,
//         no_of_days,
//       },
//       (resp) => {
//         console.log(resp[0])
//         let { next_time, end_time, no_of_times, no_times, drug_count } = resp[0]
//         // let startTime = moment.utc(next_time).format('YYYY-MM-DD HH:mm:ss')
//         // let endTime = moment(startTime)
//         //   .add(currentP.duration, currentP.period)
//         //   .format('YYYY-MM-DD HH:mm:ss')
//         // let noOfDays = moment
//         //   .duration(moment(endTime).diff(moment(startTime)))
//         //   .asDays()

//         currentP.startTime = moment.utc(next_time).format('YYYY-MM-DD HH:mm:ss')
//         currentP.times_per_day = no_of_times
//         currentP.end_date = moment.utc(end_time).format('YYYY-MM-DD HH:mm:ss')
//         currentP.no_of_days = no_of_days
//         currentP.drug_count = drug_count
//         currentP.no_times = no_times

//         savePrescription(
//           currentP,
//           (results) => {
//             console.log(results)

//             if (i === data.length - 1) {
//               if (decision === 'admit') {
//                 doSchedule({ patient_id: patientId, facilityId }, () => {
//                   console.log('drug schedule run successfully')
//                   res.json({ results })
//                 })
//               } else {
//                 res.json({ results })
//               }
//             }
//           },
//           (err) => {
//             console.log(err)
//             res.status(500).json({ success: false, err })
//           },
//         )
//       },
//     )
//   }

//   // })
//   // .catch((err) => res.json({ err }))
// }

exports.getPendingPrescriptions = (req, res) => {
  const today = moment().format("YYYY-MM-DD");
  const { status } = req.params;
  const {
    from = today,
    request_id = null,
    to = today,
    facilityId = "",
  } = req.query;
  db.sequelize
    .query(
      `call pending_prescription('general-data',:in_status,:facId,:request_id,:from,:to)`,
      {
        replacements: {
          in_status: status,
          facId: facilityId,
          request_id,
          from,
          to,
        },
      }
    )
    .then((results) => {
      res.json({
        success: true,
        results: results,
      });
    })
    .catch((err) => {
      console.log(err);
      res.status(500).json({ success: false, err });
    });
};

exports.getAll = (req, res) => {
  const { facilityId } = req.params;
  db.sequelize
    .query("call get_all_prescriptions(:facilityId)", {
      replacements: { facilityId },
    })
    .then((results) => res.send(200).json({ results }))
    .catch((err) => res.send(500).json({ err }));
};

exports.getPendingRequestPharm = (req, res) => {
  const { patient_id, facilityId } = req.params;
  db.sequelize
    .query(
      `SELECT a.id,a.drug,b.cost_price,b.cost_price+b.markUp as price, b.generic_name,b.drug_code,b.markUp,
      b.supplier,b.expiry_date,a.patient_id,a.request_id,route,additionalInfo,dosage,duration,period,
      a.drugCount,a.drugCount as qtyDispense,frequency 
        FROM dispensary a join drugpurchaserecords b ON a.drug=b.drug 
        WHERE patient_id="${patient_id}" AND a.facilityId='${facilityId}' AND a.status="request"`
    )
    .then((results) => {
      res.json({
        success: true,
        results: results[0],
      });
    })
    .catch((err) => {
      console.log(err);
      res.status(500).json({ success: false, err });
    });
};

exports.updateDispense = (req, res) => {
  const { id, facilityId, userId } = req.body;
  db.sequelize
    .query(
      `UPDATE dispensary SET status="Dispense", dispensed_by="${userId}" where request_id="${id}" and facilityId="${facilityId}"`
    )
    .then((results) => {
      res.json({
        success: true,
        results,
      });
    })
    .catch((err) => {
      console.log(err);
      res.status(500).json({ success: false, err });
    });
};

function getPatientDrugs(
  { query_type, patient_id, facilityId },
  callback = (f) => f,
  error = (f) => f
) {
  db.sequelize
    .query("CALL get_prescribed_drugs(:query_type, :patient_id, :facilityId)", {
      replacements: {
        query_type,
        patient_id,
        facilityId,
      },
    })
    .then((results) => callback(results))
    .catch((err) => error(err));
}

exports.postPrescribedDrugs = (req, res) => {
  getPatientDrugs(
    req.query,
    (results) => {
      res.json({
        success: true,
        results,
      });
    },
    (err) => {
      console.log(err);
      res.status(500).json({ success: false, err });
    }
  );
};

exports.getPatientPrescribedDrugs = (req, res) => {
  const { query_type = "", facilityId = "", patient_id = "" } = req.query;

  getPatientDrugs(
    { query_type, facilityId, patient_id },
    (results) => {
      res.json({
        success: true,
        results,
      });
    },
    (err) => {
      console.log(err);
      res.status(500).json({ success: false, err });
    }
  );

  // db.sequelize
  //   .query('CALL get_prescribed_drugs(:query_type, :patient_id, :facilityId)', {
  //     replacements: {
  //       query_type,
  //       patient_id,
  //       facilityId,
  //     },
  //   })
  //   .then((results) => {
  //     res.json({
  //       success: true,
  //       results,
  //     })
  //   })
  //   .catch((err) => {
  //     console.log(err)
  //     res.status(500).json({ success: false, err })
  //   })
};

function doSchedule(
  { patient_id, facilityId },
  callback = (f) => f,
  error = (f) => f
) {
  console.log("doSchedule called...");
  // getPatientDrugs(
  //   {
  //     query_type: 'pending',
  //     patient_id,
  //     facilityId,
  //   },
  //   (data) => {
  //     let prescriptionIds = []

  //     for (let i = 0; i < data.length; i++) {
  //       let current = data[i]
  //       const {
  //         startTime,
  //         drug,
  //         duration,
  //         period,
  //         frequency,
  //         times_per_day,
  //         end_date,
  //         prescription_id,
  //       } = current
  //       if (!prescriptionIds.includes(prescription_id)) {
  //         prescriptionIds.push(prescription_id)
  //       }

  //       let freq = frequency.split(' ')[0]
  //       // let total_daily = parseInt(freq) * parseInt(times_per_day)
  //       let r_end_time = end_date + ' ' + moment(startTime).format('HH:mm')

  db.sequelize
    .query(
      "call drug_schedule(:patient_id)",
      // 'call do_schedule(:startTime,:drug,:patient_id,:frequency,:times_per_day,:duration,:end_date)',
      {
        replacements: {
          // startTime,
          // drug,
          patient_id,
          // frequency: freq,
          // times_per_day,
          // duration,
          // end_date: r_end_time,
        },
      }
    )
    .then((results) => {
      // if (i === data.length - 1) {
      //   prescriptionIds.forEach((pr) => {
      //     db.sequelize.query(
      //       'CALL update_dispensary(:query_type, :status, :pr_id)',
      //       {
      //         replacements: {
      //           query_type: 'new schedule',
      //           status: 'scheduled',
      //           pr_id: pr,
      //         },
      //       },
      //     )
      //   })

      callback(results);
      // }
    })
    .catch((err) => {
      console.log(err);
      error(err);
      // res.status(500).json({ success: false, err })
    });
  //   }
  // },
  // )
}

exports.newDrugSchedule = (req, res) => {
  const { data } = req.body;
  let prescriptionIds = [];
  // data.forEach((i) => {
  // let pr_id = i[i.length - 1]
  // if (!prescriptionIds.includes(pr_id)) {
  //   prescriptionIds.push(pr_id)
  // }
  // })

  db.sequelize
    .query(
      "call do_schedule(:start_time,:drug_name,:patient_id,:frequency,:total_daily,:duration,:end_time)"
      // `INSERT INTO drug_schedule(allocation_id,patient_id,drug_name,time_stamp,status,administered_by,facilityId,prescription_id,frequency)
      //   VALUES ${data.map((a) => '(?)').join(',')};`,
      // { replacements: data },
    )
    .then((results) => {
      prescriptionIds.forEach((pr) => {
        db.sequelize.query(
          "CALL update_dispensary(:query_type, :status, :pr_id)",
          {
            replacements: {
              query_type: "new schedule",
              status: "scheduled",
              pr_id: pr,
            },
          }
        );
      });
      // db.sequelize.query('CALL update_dispensary(:query_type, :status, :pr_ids)', {
      //   replacements: {
      //     query_type: 'new schedule',
      //     status: 'scheduled',
      //     pr_ids: prescriptionIds.join(',')
      //   }
      // })
      // .then((results) => {

      res.json({ success: results });
      // })
      // .catch((err) => {
      //   res.status(500).json({ success: false, err })
      // })
      // res.json({ success: results })
    })
    .catch((err) => {
      console.log(err);
      res.status(500).json({ success: false, err });
    });
};

exports.getDrugSchedule = (req, res) => {
  const today = moment().format("YYYY-MM-DD");
  const {
    patient_id = "",
    facilityId = "",
    query_type = "",
    date = today,
  } = req.query;

  switch (query_type) {
    case "all_schedule":
      db.sequelize
        .query(
          `SELECT id, allocation_id, patient_id, prescription_id, drug_name, time_stamp, date(time_stamp) time_stamp_date, status, administered_by, facilityId, served_by, stopped_by, reason, frequency FROM drug_schedule where patient_id = :patient_id AND status != 'stop' ORDER BY time_stamp ASC, id;`,
          {
            replacements: {
              patient_id,
            },
          }
        )
        .then((results) => {
          res.json({
            success: true,
            results,
          });
        })
        .catch((err) => {
          console.log(err);
          res.status(500).json({ success: false, err });
        });
      break;
    case "by_date":
      if (patient_id === "all") {
        db.sequelize.query(
          `SELECT a.id, b.patient_name as name, a.patient_id, b.name as bed_name, b.class_type, a.drug as drug_name, a.dosage, a.route, time_stamp, a.status, administered_by, a.facilityId, a.frequency FROM drug_schedule_view a JOIN in_patient_list b ON a.patient_id = b.patient_id where a.status != 'stop' AND date(time_stamp) = :date AND a.facilityId=:facilityId ORDER BY time_stamp ASC, id;`,
          {
            replacements: {
              patient_id,
              facilityId,
              date
            },
            type: db.sequelize.QueryTypes.SELECT,
          }
        )
          .then((results) => {
            res.json({
              success: true,
              results,
            });
          })
          .catch((err) => {
            console.log(err);
            res.status(500).json({ success: false, err });
          });
      } else {
        db.sequelize.query(`SELECT * FROM drug_schedule where patient_id = :patient_id AND status != 'stop' AND date(time_stamp) = in_date ORDER BY time_stamp ASC,id;`,{
          replacements:{
            patient_id
          }
        }).then((results) => {
          res.json({
            success: true,
            results,
          });
        })
        .catch((err) => {
          console.log(err);
          res.status(500).json({ success: false, err });
        });
      }
      break;
    default:
      break;
  }
};

exports.updateDrugSchedule = (req, res) => {
  const { schedule_id, facilityId, userId, reason = "", query_type } = req.body;
  db.sequelize
    .query(
      "CALL update_prescription(:schedule_id,:userId,:facilityId,:reason,:query_type)",
      {
        replacements: {
          schedule_id,
          facilityId,
          userId,
          reason,
          query_type,
        },
      }
    )
    .then((results) => {
      res.json({
        success: true,
        results,
      });
    })
    .catch((err) => {
      console.log(err);
      res.status(500).json({ success: false, err });
    });
};
