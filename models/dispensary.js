const Sequelize = require("sequelize");
module.exports = function (sequelize, DataTypes) {
  return sequelize.define(
    "dispensary",
    {
      drug: {
        type: DataTypes.STRING(40),
        allowNull: true,
      },
      dosage: {
        type: DataTypes.STRING(40),
        allowNull: true,
      },
      quantity_dispensed: {
        type: DataTypes.INTEGER,
        allowNull: true,
      },
      unit_of_issue: {
        type: DataTypes.STRING(20),
        allowNull: true,
      },
      price: {
        type: DataTypes.INTEGER,
        allowNull: false,
      },
      amount: {
        type: DataTypes.STRING(11),
        allowNull: true,
      },
      discount: {
        type: DataTypes.STRING(50),
        allowNull: false,
      },
      total: {
        type: DataTypes.INTEGER,
        allowNull: false,
      },
      patient_id: {
        type: DataTypes.STRING(11),
        allowNull: true,
      },
      id: {
        type: DataTypes.STRING(50),
        allowNull: false,
        primaryKey: true,
      },
      receiptNo: {
        type: DataTypes.STRING(11),
        allowNull: true,
      },
      facilityId: {
        type: DataTypes.STRING(50),
        allowNull: false,
      },
      dispensed_by: {
        type: DataTypes.STRING(50),
        allowNull: true,
      },
      prescribed_by: {
        type: DataTypes.STRING(50),
        allowNull: true,
      },
      duration: {
        type: DataTypes.STRING(20),
        allowNull: true,
      },
      period: {
        type: DataTypes.STRING(20),
        allowNull: true,
      },
      no_of_days: {
        type: DataTypes.INTEGER,
        allowNull: true,
      },
      frequency: {
        type: DataTypes.STRING(20),
        allowNull: true,
      },
      receipt_no: {
        type: DataTypes.STRING(50),
        allowNull: true,
      },
      expiry_date: {
        type: DataTypes.DATEONLY,
        allowNull: true,
      },
      status: {
        type: DataTypes.STRING(20),
        allowNull: true,
      },
      schedule_status: {
        type: DataTypes.STRING(50),
        allowNull: false,
        defaultValue: "pending",
      },
      request_id: {
        type: DataTypes.STRING(50),
        allowNull: false,
      },
      drug_id: {
        type: DataTypes.INTEGER,
        allowNull: true,
      },
      route: {
        type: DataTypes.STRING(20),
        allowNull: false,
      },
      additionalInfo: {
        type: DataTypes.STRING(500),
        allowNull: true,
      },
      decision: {
        type: DataTypes.STRING(20),
        allowNull: false,
      },
      drugCount: {
        type: DataTypes.STRING(10),
        allowNull: false,
      },
      startTime: {
        type: DataTypes.STRING(20),
        allowNull: false,
      },
      times_per_day: {
        type: DataTypes.INTEGER,
        allowNull: false,
      },
      end_date: {
        type: DataTypes.DATE,
        allowNull: true,
      },
      no_times: {
        type: DataTypes.INTEGER,
        allowNull: false,
      },
      created_at: {
        type: DataTypes.DATE,
        allowNull: true,
      },
    },
    {
      sequelize,
      tableName: "dispensary",
      timestamps: true,
      indexes: [
        {
          name: "id_dispensary",
          unique: true,
          using: "BTREE",
          fields: [{ name: "id" }],
        },
        {
          name: "request_id",
          using: "BTREE",
          fields: [{ name: "request_id" }],
        },
        {
          name: "patient_id_dispensary",
          using: "BTREE",
          fields: [{ name: "patient_id" }],
        },
        {
          name: "receiptNo_dispensary",
          using: "BTREE",
          fields: [{ name: "receiptNo" }],
        },
        {
          name: "facilityId_dispensary",
          using: "BTREE",
          fields: [{ name: "facilityId" }],
        },
        {
          name: "created_at_dispensary",
          using: "BTREE",
          fields: [{ name: "created_at" }],
        },
        {
          name: "status_dispensary",
          using: "BTREE",
          fields: [{ name: "status" }],
        },
        {
          name: "schedule_status_dispensary",
          using: "BTREE",
          fields: [{ name: "schedule_status" }],
        },
        {
          name: "end_date_dispensary",
          using: "BTREE",
          fields: [{ name: "end_date" }],
        },
      ],
    }
  );
};
