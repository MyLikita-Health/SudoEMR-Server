const { v4 } = require("uuid");
const db = require("../models");
const moment = require("moment");
const { Op } = require("sequelize");
const HourList = db.hour_list;
const DrugList = db.druglist;
const DrugFrequency = db.drug_frequency;
const FluidChart = db.fluid_chart;
exports.addDrug = (req, res) => {
  const { facilityId } = req.body;
  const stmt =
    "call save_new_drug(:date,:drug,:unit_of_issue,:quantity,:price,:expiry_date,:facilityId)";
  db.sequelize
    .query(stmt, { replacements: { title, description, cost, facilityId } })
    .then((results) => res.json({ success: true, results }))
    .catch((err) => res.status(500).json({ err }));
};

function addDrugUpdateStmt(drugs = [], facilityId = "") {
  let drugNames = [];
  let change = "";

  drugs.forEach((d) => {
    change = change.concat(
      ' WHEN "' + d.drug + '" THEN quantity + ' + d.quantity
    );
    drugNames.push(d.drug);
  });

  let stmt = `UPDATE drugs
      SET quantity = (
        CASE drug ${change}
        END
      )
    WHERE drug IN("${drugNames.join('","')}") AND facilityId="${facilityId}";`;

  return stmt;
}

exports.batchAddDrug = (req, res) => {
  const { records, drugList, facilityId } = req.body;
  // console.log(records, drugList, facilityId)
  let stmt = addDrugUpdateStmt(drugList, facilityId);

  db.sequelize
    .query(
      `INSERT INTO drugpurchaserecords(
        date,drug,quantity,cost,expiry_date,supplier,generic_name,unit_of_issue,reorder_level,cost_price,markUp,selling_price,by_whom,payment_status,receipt_no,facilityId
      ) VALUES ${records.map((a) => "(?)").join(",")};`,
      {
        replacements: records,
      }
    )
    .then(() => {
      db.sequelize
        .query(stmt)
        .then((results) => {
          res.json({ success: true, results });
        })
        .catch((err) => {
          res.status(500).json({ success: false, err });
          console.log(err);
        });
      // res.json({ results });
    })
    .catch((err) => {
      res.status(500).json({ success: false, err });
      console.log(err);
    });
};

exports.getAll = (req, res) => {
  const { facilityId } = req.params;
  db.sequelize
    .query("call get_drugs_list(:facilityId)", {
      replacements: { facilityId },
    })
    .then((results) => res.json({ success: true, results }))
    .catch((err) => res.status(500).json({ err }));
};
exports.drugList = (req, res) => {
  const {
    drug_name = null,
    generic_name = null,
    id = null,
    query_type = null,
  } = req.body;
  db.sequelize
    .query("call get_list_of_drugs(:name,:generic_name,:id,:query_type)", {
      replacements: {
        name: drug_name,
        generic_name,
        id,
        query_type,
      },
    })
    .then((results) => res.json({ success: true, results }))
    .catch((err) => {
      console.log(err);
      res.status(500).json({ err });
    });
};

exports.getDrugList = (req, res) => {
  db.sequelize
    .query("call get_list_of_drugs('','','','')")
    .then((results) => res.json({ success: true, results }))
    .catch((err) => res.status(500).json({ err }));
};
exports.createDrug = (req, res) => {
  const {
    drug_name = "",
    generic_name = "",
    formulation = "",
    facilityId = "",
  } = req.body;

  DrugList.create({
    name: drug_name,
    generic_name,
    formulation,
    facilityId,
  })

    .then(() => {
      res.json({
        success: true,
      });
    })
    .catch((e) => {
      res.status(500).json({ success: false, e, message: "Error" });
    });
};

exports.addNewDrug = (req, res) => {
  const {
    drug,
    unit_of_issue,
    quantity,
    price,
    expiry_date,
    genericName,
    reorder_level,
    expiryAlert,
    facilityId,
  } = req.body;
  // console.log(reorder_level)
  const stmt =
    "call add_new_drug(:drug,:unit_of_issue,:quantity,:price,:expiry_date,:genericName,:reorderlevel,:expiryalert,:facilityId)";
  db.sequelize
    .query(stmt, {
      replacements: {
        drug,
        unit_of_issue,
        quantity,
        price,
        expiry_date,
        genericName,
        reorderlevel: reorder_level,
        expiryalert: expiryAlert,
        facilityId,
      },
    })
    .then((results) => res.json({ success: true, results }))
    .catch((err) => {
      res.status(500).json({ success: false, err });
      console.log(err);
    });
};

exports.updateDrug = (req, res) => {
  const {
    drug,
    unit_of_issue,
    quantity,
    price,
    expiry_date,
    reorder_level,
    genericName,
    expiryAlert,
    facilityId,
  } = req.body;
  const { drugId } = req.params;

  db.sequelize
    .query(
      `UPDATE drugpurchaserecords
        SET drug="${drug}",quantity="${quantity}",cost_price="${price}",unit_of_issue="${unit_of_issue}",
        reorder_level="${reorder_level}",expiryAlert="${expiryAlert}",genericName="${genericName}",
         WHERE drug="${drug}" AND expiry_date = "${expiry_date}" AND facilityId="${facilityId}";`
    )
    .then((results) => res.json({ success: true, results }))
    .catch((err) => res.status(500).json({ err }));
};

exports.deleteDrug = (req, res) => {
  console.log(req.body);
  const { id = "", facilityId = "" } = req.body;
  DrugList.destroy({
    where: {
      id,
      facilityId,
    },
  })
    .then((results) => res.json({ success: true, results }))
    .catch((err) => {
      console.log(err);
      res.status(500).json({ err });
    });
};

exports.updateDrugQttyById = (req, res) => {
  const { quantity, drugId } = req.params;
  const { facilityId } = req.body;
  db.sequelize
    .query("call update_drug_qtty(:drugId,:quantity,:facilityId)", {
      replacements: { drugId, quantity, facilityId },
    })
    .then((results) => res.json({ success: true, results }))
    .catch((err) => res.status(500).json({ err }));
};

function drugQttyUpdateStmt(drugList, facilityId) {
  let drugNames = [];

  let change = "";

  drugList.forEach((d) => {
    change = change.concat(
      ' WHEN "' +
        d.drug +
        '" AND expiry_date="' +
        d.expiry_date +
        '" THEN quantity - ' +
        d.quantity
    );
    drugNames.push(d.drug);
  });
  // drugpurchase
  let stmt = `UPDATE drugpurchaserecords
      SET quantity = (
        CASE drug ${change}
        END
      )
    WHERE drug IN("${drugNames.join('","')}") AND facilityId="${facilityId}";`;

  return stmt;
}

exports.dispenseDrugs = (req, res) => {
  const { data, facilityId } = req.body;
  console.log(data);
  // console.log(finalData)
  let finalData = [];

  data.dispense &&
    data.dispense.forEach((item) => {
      finalData.push([...item, facilityId]);
      console.log(finalData);
    });

  let updateStmt = drugQttyUpdateStmt(data.drugs, facilityId);
  db.sequelize
    .query(
      `INSERT INTO dispensary(drug, dosage, quantity_dispensed, unit_of_issue, amount,discount,price,total, patient_id, dispensed_by, facilityId) VALUES ${finalData
        .map((a) => "(?)")
        .join(",")};`,
      {
        replacements: finalData,
      }
    )
    .then(() => {
      console.log(updateStmt);
      db.sequelize
        .query(updateStmt)
        .then((results) => {
          res.json({ success: true, results });
        })
        .catch((err) => {
          res.status(500).json({ success: false, err });
          console.log(err);
        });
    })
    .catch((err) => {
      res.status(500).json({ success: false, err });
      console.log(err);
    });
};

exports.getDrugPriceById = (req, res) => {
  const { drugId, facilityId } = req.params;
  db.sequelize
    .query("call get_drug_price_by_id(:id, :facilityId)", {
      replacements: { id: drugId, facilityId },
    })
    .then((results) => res.json({ price: results[0].price }))
    .catch((err) => res.status(500).json({ err }));
};

exports.getExpiryAlert = (req, res) => {
  const { facilityId } = req.params;
  db.sequelize
    .query("call drug_expiry_alert(:facilityId)", {
      replacements: { facilityId },
    })
    .then((results) => res.json({ success: true, results }))
    .catch((err) => res.status(500).json({ err }));
};

exports.getExpiredDrugs = (req, res) => {
  const { facilityId } = req.params;
  db.sequelize
    .query("call get_expired_drugs(:facilityId)", {
      replacements: { facilityId },
    })
    .then((results) => res.json({ success: true, results }))
    .catch((err) => res.status(500).json({ err }));
};

exports.getQttyAlert = (req, res) => {
  const { facilityId } = req.params;
  db.sequelize
    .query("call drug_qtty_alert(:facilityId)", {
      replacements: { facilityId },
    })
    .then((results) => res.json({ success: true, results }))
    .catch((err) => res.status(500).json({ err }));
};

exports.newDrugPurchase = (req, res) => {
  const {
    drug_code,
    drug,
    cost,
    expiry,
    generic,
    unit_of_issue,
    reorder,
    markup,
    quantity,
    userId,
    supplierId,
    paymentStatus,
    date,
    receipt_image,
    expiry_alert,
    description,
    source,
    amount,
    receiptsn,
    receiptno,
    modeOfPayment,
    destination,
    sourceAcct,
    facilityId,
    selling_price,
  } = req.body;
  console.log(req.body);

  db.sequelize
    .query(
      `CALL new_drug_purchase(:drug,:cost,:expiry,:generic,:unit_of_issue,:reorder,:markup,
        :quantity,:userId,:supplierId,:paymentStatus,:date,:receipt_image,:expiry_alert,:description,
        :source,:amount,:receiptsn,:receiptno,:modeOfPayment,:destination,:facilityId,:drug_code,
        :selling_price,:in_date)`,
      {
        replacements: {
          drug_code,
          drug,
          cost,
          expiry,
          generic,
          unit_of_issue,
          reorder,
          markup,
          quantity,
          userId,
          supplierId,
          paymentStatus,
          date,
          receipt_image,
          expiry_alert,
          description,
          source: "30001",
          amount,
          receiptsn,
          receiptno,
          modeOfPayment,
          destination: sourceAcct ? sourceAcct : "",
          facilityId,
          selling_price,
          in_date: moment().format("YYYY-MM-DD hh:mm:ss"),
        },
      }
    )
    .then((results) => {
      res.json({ success: true, results });
    })
    .catch((err) => {
      res.status(500).json({ success: false, err });
    });
};

exports.getDrugInfoFromDrugCode = (req, res) => {
  const { drugCode, facilityId } = req.params;
  db.sequelize
    .query(
      `SELECT drug,drug_code,generic_name,cost_price,balance,dispensary_balance,
        expiry_date,markup,supplier,unit_of_issue,supplier
        FROM drugpurchaserecords
        WHERE drug_code="${drugCode}" AND facilityId="${facilityId}"`
    )
    .then((results) => {
      res.json({ success: true, results: results[0] });
    })
    .catch((err) => {
      res.status(500).json({ success: false, err });
    });
};

exports.getDrugInfoFromDrugCodeForSale = (req, res) => {
  const { drugCode, facilityId } = req.params;

  db.sequelize
    .query(
      `SELECT drug,drug_code,(price + markup) as price,genericName as generic_name,
        unit_of_issue,expiry_date,supplier,
        expiry_date,markup
        FROM drugs
        WHERE drug_code="${drugCode}" AND facilityId="${facilityId}" AND source='dispensary'`
    )
    .then((results) => {
      res.json({ success: true, results: results[0] });
    })
    .catch((err) => {
      res.status(500).json({ success: false, err });
    });
};

exports.drugSearch = (req, res) => {
  let drug = req.query.drug || "";
  const { facilityId } = req.params;
  // drug like '%${drug}' OR drug like '${drug}%' OR drug_code like '%${drug}' OR drug_code like '${drug}%'
  db.sequelize
    .query(
      `
      SELECT drug,drug_code,generic_name,cost_price,cost_price+markUp as price,balance,dispensary_balance as d_balance,
        supplier,unit_of_issue,supplier, expiry_date,markUp as markup
        FROM drugpurchaserecords
        WHERE facilityId="${facilityId}" AND date(created_at) = (
          SELECT MIN(date(created_at)) FROM drugpurchaserecords WHERE drug like '%${drug}%' OR drug_code like '%${drug}%'
        ) AND (drug like '%${drug}%' OR drug_code like '%${drug}%')`
    )
    .then((results) => {
      res.json({ success: true, drugInfo: results[0] });
    })
    .catch((err) => {
      res.status(500).json({ success: false, err });
    });
};

exports.drugSearchForSale = (req, res) => {
  let drug = req.query.drug || "";
  const { facilityId } = req.params;
  // drug like '%${drug}' OR drug like '${drug}%' OR drug_code like '%${drug}' OR drug_code like '${drug}%'
  // ) AND (a.drug like '%${drug}%' OR a.drug_code like '%${drug}%') AND a.source='dispensary' AND markup <> 0
  db.sequelize
    .query(
      // `
      // SELECT distinct a.drug,a.drug_code,a.generic_name AS genericName,a.cost_price,a.cost_price+a.markUp as price,
      // a.unit_of_issue,a.supplier, a.expiry_date,a.markUp as markup
      // FROM drugpurchaserecords a
      // WHERE a.facilityId="${facilityId}" AND date(a.created_at) = (
      //   SELECT MIN(date(a.created_at)) FROM drugpurchaserecords WHERE a.drug like '%${drug}%' OR a.drug_code like '%${drug}%'
      // ) AND (a.drug like '%${drug}%' OR a.drug_code like '%${drug}%')
      // group by a.drug
      // ORDER BY markUp DESC`
      // `SELECT distinct drug,drug_code,genericName,price+markup as price,
      // unit_of_issue,supplier, expiry_date,markup as markup ,SUM(qty_in-qty_out) FROM
      // drugs WHERE facilityId="${facilityId}" and drug like '%${drug}%' and source="dispensary" GROUP by drug,drug_code,genericName,price,markup ,
      //  unit_of_issue,supplier, expiry_date ORDER by expiry_date ASC`
      // `
      // SELECT distinct a.drug,a.drug_code,genericName,a.price as cost_price,a.price+a.markup as price,
      // a.unit_of_issue,a.supplier, a.expiry_date,a.markup as markup
      // FROM drugs a
      // WHERE a.facilityId="${facilityId}" AND date(a.created_at) = (
      //   SELECT MIN(date(a.created_at)) FROM drugs  where  a.drug like '%${drug}%' OR a.drug_code like '%${drug}%'
      // ) AND (a.drug like '%${drug}%' OR a.drug_code like '%${drug}%' and a.status !="suspend") AND a.source='dispensary' and a.status !="suspend"
      // group by a.drug
      // ORDER BY markup DESC`
      `SELECT drug , cost_price+markUp as price,cost_price,expiry_date FROM drugpurchaserecords WHERE dispensary_balance>0 and status !="suspend"`
    )
    .then((results) => {
      res.json({ success: true, drugInfo: results[0] });
    })
    .catch((err) => {
      res.status(500).json({ success: false, err });
    });
};

exports.getDrugQtty = (req, res) => {
  const { facilityId } = req.params;
  let drug = req.query.drugName || "";
  let code = req.query.drugCode || "";
  let expiry_date = req.query.expiry_date || "";

  db.sequelize
    .query(
      `SELECT dispensary_balance as balance, cost_price + markUp as price, cost_price from drugpurchaserecords 
      WHERE drug='${drug}'  AND expiry_date='${expiry_date}'  and dispensary_balance>0
      AND facilityId="${facilityId}"`
    )
    .then((results) => {
      res.json({ success: true, results: results[0][0] });
    })
    .catch((err) => {
      res.status(500).json({ success: false, err });
    });
};

exports.getFactoryDrugQtty = (req, res) => {
  const { facilityId } = req.params;
  let drug = req.query.drugName || "";

  db.sequelize
    .query(
      `SELECT sum(qty_in - qty_out) as balance from drugs 
      WHERE drug='${drug}' AND source='dispensary' 
      AND facilityId="${facilityId}"`
    )
    .then((results) => {
      res.json({ success: true, results: results[0][0] });
    })
    .catch((err) => {
      res.status(500).json({ success: false, err });
    });
};

exports.getTotalDrugList = (req, res) => {
  const { facilityId, filterText } = req.query;
  console.log(req.query);
  DrugList.count({
    where: {
      facilityId: facilityId,
      [Op.or]: [
        { name: { [Op.like]: `%${filterText}%` } },
        { formulation: { [Op.like]: `%${filterText}%` } },
        { generic_name: { [Op.like]: `%${filterText}%` } },
      ],
    },
  })
    .then((results) => {
      console.log(results);
      res.json({
        results: results,
        success: true,
      });
    })
    .catch((err) => res.status(500).json({ err }));
};

exports.getDrugSearch = (req, res) => {
  const { facilityId, searchValue, from, to, query = "" } = req.query;
  switch (query) {
    case "default":
      PharmStore.findAll({
        where: {
          balance: { [Op.gt]: 0 },
          [Op.or]: [
            { drug_name: { [Op.like]: `%${searchValue}%` } },
            { drug_category: { [Op.like]: `%${searchValue}%` } },
            { uom: { [Op.like]: `%${searchValue}%` } },
            { generic_name: { [Op.like]: `%${searchValue}%` } },
            { barcode: { [Op.like]: `%${searchValue}%` } },
          ],
          [Op.or]: [
            { expiry_date: { [Op.gt]: Sequelize.literal('datetime("now")') } },
            { expiry_date: "1111-11-11" },
          ],
          facilityId: facilityId,
        },
        limit: [from, to],
      })
        .then((results) =>
          res.status(200).json({ results: results, success: true })
        )
        .catch((err) => res.status(500).json({ err }));
      break;
    case "drug_list":
      DrugList.findAll({
        where: {
          [Op.or]: [
            { name: { [Op.like]: `%${searchValue}%` } },
            { formulation: { [Op.like]: `%${searchValue}%` } },
            { generic_name: { [Op.like]: `%${searchValue}%` } },
          ],
          facilityId: facilityId,
        },
        limit: [from, to],
      })
        .then((results) => {
          console.log(results);
          res.status(200).json({ results: results, success: true });
        })
        .catch((err) => res.status(500).json({ err }));
      break;
    default:
      break;
  }
};

exports.getDrugList = (req, res) => {
  const { facilityId, from, to } = req.query;
  DrugList.findAll({
    where: {
      facilityId: facilityId,
    },
    order: [["createdAt", "DESC"]],
    limit: 100,
  })
    .then((results) => res.status(200).json({ results, success: true }))
    .catch((err) => {
      console.log(err);
      res.status(500).json({ err });
    });
};

exports.moveDrugsToDispensary = (req, res) => {
  const {
    drug_code,
    drug,
    cost,
    expiry,
    generic,
    unit_of_issue,
    quantity,
    userId,
    facilityId,
    selling_price,
    supplierId,
    markup,
    itemSource,
    receiptsn,
    shift,
  } = req.body;
  // console.log(req.body);

  db.sequelize
    .query(
      `CALL move_items_to_dispensary(:drug,:cost,:expiry,:drug_code,:price,
        :unit_of_issue,:quantity,:userId,:generic,:facilityId,:supplierId,
        :itemSource,:markup,:receiptsn,:shift)`,
      {
        replacements: {
          drug_code,
          drug,
          cost: cost ? cost : 0,
          expiry,
          generic: generic ? generic : "",
          unit_of_issue: unit_of_issue ? unit_of_issue : 0,
          quantity,
          userId,
          facilityId,
          price: selling_price ? selling_price : 0,
          supplierId,
          markup,
          itemSource,
          receiptsn,
          shift: shift ? shift : "",
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

exports.newPurchaseFromSupplier = (req, res) => {
  const {
    supplierId,
    amountPaid,
    receiptsn,
    receiptno,
    description,
    payment_mode,
    facId,
    destination,
    paymentStatus,
    goodsAmount,
    goodsHead,
    userId,
  } = req.body;

  db.sequelize
    .query(
      `CALL new_purchase_from_supplier(:supplierAcc,:amountPaid,:userId,:receiptsn,:receiptno,
            :description,:payment_mode,:facId,:destination,:paymentStatus,:goodsAmount,:goodsHead,
            :in_date,:in_payables_head)`,
      {
        replacements: {
          supplierAcc: supplierId,
          amountPaid: amountPaid ? amountPaid : "0",
          receiptsn,
          receiptno,
          description,
          payment_mode,
          facId,
          paymentStatus,
          goodsAmount: goodsAmount ? goodsAmount : "0",
          destination,
          // payment_mode && payment_mode.toLowerCase() === 'cash'
          //   ? '400021'
          //   : '400022',
          goodsHead: "30001",
          userId,
          in_date: moment().format("YYYY-MM-DD hh:mm:ss"),
          in_payables_head: "500021",
        },
      }
    )
    .then((resp) => {
      res.json({ success: true, resp });
    })
    .catch((err) => {
      res.status(500).json({ success: false, err });
    });
};

exports.getInstantPayment = (req, res) => {
  const { facilityId } = req.params;
  db.sequelize
    .query(
      `SELECT accountNo FROM patientfileno where accName="Instant Payment" AND facilityId="${facilityId}"`
    )
    .then((results) => {
      res.json({ success: true, results: results[0][0] });
    })
    .catch((err) => {
      res.status(500).json({ success: false, err });
    });
};

function getInstantAcc(facilityId, cb, error) {
  db.sequelize
    .query(
      `SELECT accountNo FROM patientfileno where accName="Instant Payment" AND facilityId="${facilityId}"`
    )
    .then((resp) => {
      let instaAccNo = resp[0][0].accountNo;
      cb(instaAccNo);
    })
    .catch((err) => {
      error(err);
      console.log(err);
    });
}

function getAccHeadForAcc(acc, facilityId, cb, error) {
  db.sequelize
    .query(`CALL get_acc_head_for_acc(:desc,:facId)`, {
      replacements: {
        desc: acc,
        facId: facilityId,
      },
    })
    .then((resp) => {
      cb(resp);
    })
    .catch((err) => {
      error(err);
      console.log(err);
    });
}

exports.returnDrug = (req, res) => {
  const {
    drug,
    drug_code,
    genericName,
    cost,
    price,
    supplier,
    unit_of_issue,
    expiry_date,
    markup,
    quantityReturned = 1,
    facilityId,
    userId,
    receipt_no,
    modeOfPayment,
    patientAcc,
    client_acct,
    bank,
    transaction_date,
    discount = "",
    txn_status = "completed",
    amount_paid = 0,
    services_list = "",
  } = req.body;

  // getInstantAcc(
  //   facilityId,
  //   (instaAccNo) => {
  db.sequelize
    .query(
      "CALL record_returned_drugs(:quantityReturned,:receiptno,:d_code,:cost,:expiry_date,:facilityId,:userId,:drug,:price,:unit_of_issue,:supplier, :generic_name,:client_acc)",
      {
        replacements: {
          drug,
          d_code: drug_code,
          generic_name: genericName,
          cost: price,
          price,
          supplier,
          unit_of_issue,
          expiry_date,
          markup,
          quantityReturned,
          facilityId,
          userId,
          receiptno: receipt_no,
          client_acc: patientAcc ? patientAcc : "",
        },
      }
    )
    .then((results) => {
      // getAccHeadForAcc("discount", facilityId, (acc) => {
      db.sequelize
        .query(
          `CALL service_transaction(:description,:accNo,:amount,:receiptsn,:receiptno,:modeOfPayment,
                  :accNo,:facilityId,:sourceAcct,:userId,:serviceHead,:transactionType,:in_date,
                  :payables_head, :recievables_head,:bank,:txn_date,:discount,:discount_head,:txn_status, 
                  :amount_paid,:services_list)`,
          {
            replacements: {
              // drug_code,
              drug,
              cost,
              expiry: expiry_date,
              generic: genericName,
              unit_of_issue,
              quantity: quantityReturned,
              userId,
              supplierId: supplier,
              description: `Returned Drugs (${drug})`,
              amount: price * quantityReturned,
              receiptsn: receipt_no,
              receiptno: "",
              modeOfPayment,
              facilityId,
              selling_price: price,
              accNo: client_acct,
              transactionType: "insta",
              sourceAcct: "20001",
              serviceHead:
                modeOfPayment && modeOfPayment.toLowerCase() === "cash"
                  ? "400021"
                  : "400022",
              in_date: moment().format("YYYY-MM-DD hh:mm:ss"),
              payables_head: "500021",
              recievables_head: "400023",
              bank: bank ? bank : "",
              txn_date: transaction_date
                ? transaction_date
                : moment().format("YYYY-MM-DD"),
              discount: discount ? discount : 0,
              discount_head: "30030",
              txn_status,
              amount_paid,
              services_list,
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
      // });
      // res.json({ success: true, results });
    })
    .catch((err) => {
      console.log(err);
      res.status(500).json({ success: false, err });
    });
  // },
  // (err) => console.log(err),
  // );
};

exports.newDrugSale = (req, res) => {
  let today = moment().format("YYYY-MM-DD");
  const data = req.body;
  data.forEach((item) => {
    const {
      drug_code,
      drug,
      cost,
      cost_price,
      expiry,
      generic,
      unit_of_issue,
      quantity,
      userId,
      supplierId,
      description,
      source,
      amount,
      receiptsn,
      receiptno,
      modeOfPayment,
      destination,
      facilityId,
      selling_price,
      patientAcc,
      transactionType,
      sourceAcct,
      serviceHead,
      transaction_date,
      bank,
      discount,
      txn_status = "completed",
      patient_id = "",
      amount_paid = 0,
      services_list = "",
    } = item;
    console.log(req.body);

    db.sequelize
      .query(
        `SELECT accountNo FROM patientfileno where accName="Instant Payment" AND facilityId="${facilityId}"`
      )
      .then((resp) => {
        let instaAccNo =
          (resp &&
            resp.length &&
            resp[0] &&
            resp[0][0] &&
            resp[0][0].accountNo) ||
          null;
        db.sequelize
          .query(
            `CALL pharm_new_drug_sale(:drug,:cost,:expiry,:generic,:unit_of_issue,
            :quantity,:userId,:supplierId,:description,:source,:amount,:receiptsn,
            :receiptno,:modeOfPayment,:destination,:facilityId,:drug_code,
            :selling_price,:accNo,:transactionType,:txn_date)`,
            {
              replacements: {
                drug_code: drug_code ? drug_code : "",
                drug: drug ? drug : "",
                cost: cost ? cost : "",
                expiry: expiry ? expiry : "",
                generic: generic ? generic : "",
                unit_of_issue: unit_of_issue ? unit_of_issue : "",
                quantity: quantity ? quantity : "",
                userId: userId ? userId : "",
                supplierId: supplierId ? supplierId : "",
                description: description ? description : "",
                source: source ? source : "",
                amount: amount ? amount : "",
                receiptsn: receiptsn ? receiptsn : "",
                receiptno: receiptno ? receiptno : "",
                modeOfPayment: modeOfPayment ? modeOfPayment : "",
                destination: destination ? destination : "",
                facilityId: facilityId ? facilityId : "",
                selling_price: selling_price ? selling_price : "",
                accNo: patientAcc ? patientAcc : instaAccNo,
                transactionType: transactionType ? transactionType : "",
                txn_date: today,
                txn_date: transaction_date ? transaction_date : "",
              },
            }
          )
          .then((results) => {
            // if (transactionType === 'insta') {

            db.sequelize
              .query(
                `CALL service_transaction(:description,:accNo,:amount,:receiptsn,:receiptno,:modeOfPayment,
                  :patient_id,:facilityId,:sourceAcct,:userId,:serviceHead,:transactionType,:in_date,
                  :payables_head,:recievables_head,:bank,:txn_date,:discount,:discount_head,:txn_status,
                  :amount_paid, :services_list)`,
                // :drug,:cost,:expiry,:generic,:unit_of_issue,
                // :quantity,:userId,:supplierId,
                // :source,:destination,:drug_code,
                // :selling_price,:transactionType)
                {
                  replacements: {
                    drug_code: drug_code ? drug_code : "",
                    drug: drug ? drug : "",
                    cost: cost ? cost : "",
                    expiry: expiry ? expiry : "",
                    generic: generic ? generic : "",
                    unit_of_issue: unit_of_issue ? unit_of_issue : "",
                    quantity: quantity ? quantity : 0,
                    userId: userId ? userId : "",
                    supplierId: supplierId ? supplierId : "",
                    description: description ? description : "",
                    source: source ? source : "",
                    amount: amount ? amount : "",
                    receiptsn: receiptsn ? receiptsn : "",
                    receiptno: receiptno ? receiptno : "",
                    modeOfPayment: modeOfPayment ? modeOfPayment : "",
                    destination: destination ? destination : "",
                    facilityId: facilityId ? facilityId : "",
                    selling_price: selling_price ? selling_price : "",
                    accNo: patientAcc ? patientAcc : instaAccNo,
                    transactionType: transactionType ? transactionType : "",
                    sourceAcct:
                      modeOfPayment.toLowerCase() === "cash"
                        ? "400021"
                        : "400022",
                    serviceHead: "20025",
                    in_date: moment().format("YYYY-MM-DD hh:mm:ss"),
                    payables_head: "500021",
                    recievables_head: "400023",
                    bank: bank ? bank : "",
                    txn_date: transaction_date
                      ? transaction_date
                      : moment().format("YYYY-MM-DD"),
                    discount: discount ? discount : 0,
                    discount_head: "30030",
                    txn_status,
                    patient_id,
                    amount_paid,
                    services_list,
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
  });
};

exports.getPurchaseRecords = (req, res) => {
  const { facilityId } = req.params;
  db.sequelize
    .query("call get_purchase_records(:facilityId)", {
      replacements: { facilityId },
    })
    .then((results) => res.json({ success: true, results }))
    .catch((err) => res.status(500).json({ err }));
};

exports.getDispensaryRecords = (req, res) => {
  const { facilityId } = req.params;
  db.sequelize
    .query("call get_dispensary_records(:facilityId)", {
      replacements: { facilityId },
    })
    .then((results) => res.json({ success: true, results }))
    .catch((err) => res.status(500).json({ err }));
};

exports.getPendingPurchase = (req, res) => {
  const { facilityId } = req.params;
  db.sequelize
    .query("call get_pending_purchases(:facilityId)", {
      replacements: { facilityId },
    })
    .then((results) => res.json({ success: true, results }))
    .catch((err) => res.status(500).json({ err }));
};

exports.batchAddDrugsWithoutPurchase = (req, res) => {
  db.sequelize
    .query(
      `insert into drugs(drug,unit_of_issue,quantity,expiry_date,price,facilityId) VALUES ${data
        .map((a) => "(?)")
        .join(",")};`,
      {
        replacements: data,
      }
    )
    .then((results) => {
      res.json({ results });
    })
    .catch((err) => res.status(500).json({ err }));
};

exports.addNewSupplier = (req, res) => {
  const { supplier_name, address, phone, code, facilityId } = req.body;
  // console.log(supplier_name, address, phone, code)
  const stmt =
    "call add_new_supplier(:name,:address,:phone,:code, :facilityId)";
  db.sequelize
    .query(stmt, {
      replacements: { name: supplier_name, address, phone, code, facilityId },
    })
    .then((results) => res.json({ success: true, results }))
    .catch((err) => res.status(500).json({ err }));
};

exports.getAllSuppliers = (req, res) => {
  const { facilityId } = req.params;
  db.sequelize
    .query("call get_all_suppliers(:facilityId)", {
      replacements: { facilityId },
    })
    .then((results) => res.json({ success: true, results }))
    .catch((err) => {
      console.log(err);
      res.status(500).json({ err });
    });
};

exports.updateSupplier = (req, res) => {
  const {
    body: { facilityId, supplier_name, address, phone, code },
    params: { supplierId },
  } = req;
  db.sequelize
    .query(
      "call update_supplier(:supplierId, :supplier_name, :address, :phone, :code, :facilityId)",
      {
        replacements: {
          supplierId,
          supplier_name,
          address,
          phone,
          code,
          facilityId,
        },
      }
    )
    .then((results) => res.json({ success: true, results }))
    .catch((err) => res.status(500).json({ err }));
};

exports.deleteSupplier = (req, res) => {
  const {
    body: { facilityId },
    params: { supplierId },
  } = req;
  db.sequelize
    .query("call delete_supplier(:supplierId, :facilityId)", {
      replacements: { facilityId, supplierId },
    })
    .then((results) => res.json({ success: true, results }))
    .catch((err) => res.status(500).json({ err }));
};

exports.getUnitOfIssue = (req, res) => {
  const {
    params: { facilityId, drugName },
  } = req;
  db.sequelize
    .query("call getUnitOfIssue(:drugName,:facilityId)", {
      replacements: {
        drugName,
        facilityId,
      },
    })
    .then((results) => res.json({ success: true, results }))
    .catch((err) => res.status(500).json({ err }));
};

exports.getSaleSummary = (req, res) => {
  const { facilityId, from, to } = req.params;
  let today = moment().format("YYYY-MM-DD");
  db.sequelize
    .query("call get_pharm_sales_summary(:facilityId, :from, :to)", {
      replacements: { facilityId, from, to },
    })
    .then((results) => res.json({ success: true, results }))
    .catch((err) => res.status(500).json({ err }));
};

exports.getPharmTotalStock = (req, res) => {
  const { facilityId } = req.params;
  db.sequelize
    .query("call get_pharm_total_stock(:facilityId)", {
      replacements: { facilityId },
    })
    .then((results) => res.json({ results: results[0] }))
    .catch((err) => res.status(500).json({ err }));
};

exports.getDrugsSoldWithinRange = (req, res) => {
  const { facilityId, from, to } = req.params;

  db.sequelize
    .query("call get_drugs_sold(:facilityId,:from,:to)", {
      replacements: { facilityId, from, to },
    })
    .then((results) => res.json({ success: true, results }))
    .catch((err) => res.status(500).json({ success: false, err }));
};

exports.getBestSellingStaff = (req, res) => {
  const { facilityId, from, to } = req.params;

  db.sequelize
    .query(
      `SELECT SUM(a.qty_out) + SUM(a.price) AS amount, concat(b.firstname, ' ', b.lastname) as staff 
        FROM drugs a JOIN users b on a.created_by = b.username WHERE date(a.created_at) 
        BETWEEN date("${from}") AND date("${to}") AND a.source='dispensary' 
        AND a.facilityId="${facilityId}" GROUP BY staff ORDER BY amount DESC`
    )
    // .query('call get_best_selling_staff(:facilityId,:from,:to)', {
    //   replacements: { facilityId, from, to },
    // })
    .then((results) => res.json({ success: true, results: results[0] }))
    .catch((err) => res.status(500).json({ success: false, err }));
};

exports.getTopFivePopularDrugsForToday = (req, res) => {
  const { facilityId } = req.params;
  const today = moment().format("YYYY-MM-DD");
  db.sequelize
    .query("call get_top_5_popular_drugs(:facilityId, :today)", {
      replacements: { facilityId, today },
    })
    .then((results) => res.json({ success: true, results }))
    .catch((err) => {
      res.status(500).json({ success: false, err });
      console.log(err);
    });
};

exports.getAllDrugs = (req, res) => {
  db.sequelize
    .query("SELECT DISTINCT name from druglist")
    .then((results) => res.json({ success: true, results: results[0] }))
    .catch((err) => {
      console.log(err);
      res.status(500).json({ success: false, err });
    });
};

exports.getFastSellingItems = (req, res) => {
  const { from, to } = req.params;

  db.sequelize
    .query("call get_fast_selling_items(:from, :to)", {
      replacements: {
        from,
        to,
      },
    })
    .then((results) => res.json({ success: true, results }))
    .catch((err) => res.json({ success: false, err }));
};

exports.getMostProfitableItems = (req, res) => {
  const { from, to } = req.params;
  db.sequelize
    .query("CALL get_most_profitable(:from, :to)", {
      replacements: {
        from,
        to,
      },
    })
    .then((results) => res.json({ success: true, results }))
    .catch((err) => res.json({ success: false, err }));
};

exports.getDispensaryBalanceWithoutStore = (req, res) => {
  const { facilityId } = req.params;
  db.sequelize
    .query(
      `
  SELECT a.drug,a.qty_in as dispensary_quantity, a.qty_out ,a.price as cost_price, a.expiry_date,a.created_at,b.supplier_name as supplier 
    FROM drugs a JOIN suppliersinfo b ON a.supplier=b.id WHERE a.facilityId="${facilityId}" AND source='dispensary' ORDER BY created_at`
    )
    .then((results) => res.json({ success: true, results: results[0] }))
    .catch((err) => res.json({ success: false, err }));
};
// SELECT drug, SUM(qty_in)- SUM(qty_out) AS quantity_in_shelf, SUM(qty_in*(price+markup)) AS amount_in_shelf, SUM(qty_out) AS quantity_sold, sum(qty_out*(price+markup)) as amount_sold, source FROM drugs WHERE source='dispensary' GROUP BY drug

exports.getReturnedDrugs = (req, res) => {
  const { code, receiptNo } = req.params;
  db.sequelize
    .query(
      `SELECT (debit) as dr,description,quantity,transaction_id 
        FROM transactions 
        WHERE source = "${code}" And receipt_number = "${receiptNo}"`
    )
    .then((results) => res.json({ success: true, results: results[0] }))
    .catch((err) => res.status(500).json({ success: false, err }));
};
// 101020637

exports.updateDrugDispensaryMarkupAndQuantity = (req, res) => {
  const {
    drug_name,
    cost_price,
    markUp,
    quantity_in_shelf,
    expiry_date,
    drug,
  } = req.body;
  console.log(req.body);
  db.sequelize
    .query(
      `UPDATE drugpurchaserecords SET markUp='${markUp}', dispensary_balance='${quantity_in_shelf}',
      cost_price='${cost_price}',expiry_date='${expiry_date}'
        WHERE drug='${drug}'`
    )
    .then((results) => {
      res.json({
        success: true,
        results,
      });
    })
    .catch((err) => res.json({ success: false, err }));
};

exports.deleteDrugsPurchase = (req, res) => {
  let drug = req.query.drug || "";
  let cost_price = req.query.cost_price || "";
  let expiry_date = req.query.expiry_date || "";
  db.sequelize
    .query(`call suspend_drugs(:drug,:cost_price,:expiry_date) `, {
      replacements: {
        drug,
        cost_price,
        expiry_date,
      },
    })
    .then((results) => res.json({ success: true, results: results }))
    .catch((err) => {
      console.log(err);
      res.status(500).json({ success: false, err });
    });
};

function drugFreqSetupApi(
  {
    query_type = "",
    title = "",
    timing = "",
    timingInt = "0",
    facilityId = "",
  },
  callback = (f) => f,
  error = (f) => f
) {
  console.log({
    query_type,
    title,
    timing,
    timingInt,
    facilityId,
  });
  switch (query_type) {
    case "hours":
      HourList.findAll()
        .then((results) => callback(results))
        .catch((err) => {
          console.log(err);
          error(err);
        });
      break;
    case "new":
      DrugFrequency.create({
        description: title,
        time: timing,
        drug_time: timingInt,
        no_times: timingInt,
        facilityId: facilityId,
      })
        .then((results) => callback(results))
        .catch((err) => {
          console.log(err);
          error(err);
        });
      break;
    case "list":
      DrugFrequency.findAll({
        where: {
          facilityId: facilityId,
        },
      })
        .then((results) => callback(results))
        .catch((err) => {
          console.log(err);
          error(err);
        });

    default:
      break;
  }
}

exports.getDrugFreqSetup = (req, res) => {
  const { query_type, facilityId } = req.query;
  drugFreqSetupApi(
    { query_type, facilityId },
    (results) => {
      res.json({ success: true, results });
    },
    (err) => {
      console.log(err);
      res.status(500).json({ success: false, err });
    }
  );
};

exports.deleteDrugFreqSetup = (req, res) => {
  const { facilityId, title } = req.body;
  DrugFrequency.destroy({
    where: {
      description: title,
      facilityId: facilityId,
    },
  })
    .then((results) => res.json({ success: true, results }))
    .catch((err) => {
      console.log(err);
      res.json({ success: false, err });
    });
};

exports.newDrugFreqSetup = (req, res) => {
  const { query_type, title, selectedTiming, facilityId = "" } = req.body;

  for (let i = 0; i < selectedTiming.length; i++) {
    let current = selectedTiming[i];
    drugFreqSetupApi(
      {
        query_type,
        title,
        timing: current.hour,
        timingInt: current.hourInt,
        facilityId,
      },
      (results) => {
        console.log(results);
      },
      (err) => {
        console.log(err);
        res.status(500).json({ success: false, err });
      }
    );
  }

  res.json({ success: true });
};

exports.fluidChart = (req, res) => {
  const {
    patient_id = null,
    input_volume = null,
    input_route = null,
    input_type = null,
    output_volume = null,
    output_route = null,
    output_type = null,
    created_by = null,
  } = req.body;
  const { query_type } = req.query;

  switch (query_type) {
    case "insert":
      FluidChart.create({
        patient_id,
        input_volume,
        input_route,
        input_type,
        output_volume,
        output_route,
        output_type,
        created_by,
      })
        .then((results) => res.json({ success: true, results: results }))
        .catch((err) => res.json({ success: false, err }));
      break;
    case "select":
      FluidChart.findAll({
        where: { patient_id },
      })
        .then((results) => {
          res.json({ success: true, results });
        })
        .catch((err) => res.json({ success: false, err }));
      break;
    default:
      break;
  }
};

exports.nurseryNote = (req, res) => {
  const {
    report = null,
    created_at = null,
    created_by = null,
    patient_id = null,
  } = req.body;
  const { query_type } = req.query;
  db.sequelize
    .query(
      "CALL nursing_note(:report,:patient_id,:created_at,:created_by,:query_type)",
      {
        replacements: {
          patient_id,
          report,
          created_at,
          query_type,
          created_by,
        },
      }
    )
    .then((results) => res.json({ success: true, results }))
    .catch((err) => res.json({ success: false, err }));
};
