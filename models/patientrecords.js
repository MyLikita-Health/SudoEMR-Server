const Sequelize = require("sequelize");
module.exports = function (sequelize, DataTypes) {
  return sequelize.define(
    "patientrecords",
    {
      facilityId: {
        type: DataTypes.STRING(50),
        allowNull: false,
        primaryKey: true,
      },
      title: {
        type: DataTypes.STRING(10),
        allowNull: true,
      },
      accountType: {
        type: DataTypes.STRING(50),
        allowNull: true,
      },
      surname: {
        type: DataTypes.STRING(50),
        allowNull: true,
      },
      firstname: {
        type: DataTypes.STRING(50),
        allowNull: true,
      },
      other: {
        type: DataTypes.STRING(50),
        allowNull: true,
      },
      Gender: {
        type: DataTypes.STRING(10),
        allowNull: true,
      },
      age: {
        type: DataTypes.INTEGER,
        allowNull: true,
        defaultValue: 0,
      },
      maritalstatus: {
        type: DataTypes.STRING(20),
        allowNull: true,
        defaultValue: "0",
      },
      DOB: {
        type: DataTypes.STRING(20),
        allowNull: true,
      },
      dateCreated: {
        type: DataTypes.STRING(50),
        allowNull: true,
      },
      phoneNo: {
        type: DataTypes.STRING(30),
        allowNull: true,
        defaultValue: "",
      },
      email: {
        type: DataTypes.STRING(50),
        allowNull: true,
        defaultValue: "",
      },
      state: {
        type: DataTypes.STRING(50),
        allowNull: true,
        defaultValue: "",
      },
      lga: {
        type: DataTypes.STRING(50),
        allowNull: true,
        defaultValue: "",
      },
      occupation: {
        type: DataTypes.STRING(50),
        allowNull: true,
        defaultValue: "",
      },
      address: {
        type: DataTypes.TEXT,
        allowNull: true,
        defaultValue: "",
      },
      kinName: {
        type: DataTypes.STRING(100),
        allowNull: true,
        defaultValue: "",
      },
      kinRelationship: {
        type: DataTypes.STRING(20),
        allowNull: true,
        defaultValue: "",
      },
      kinPhone: {
        type: DataTypes.STRING(30),
        allowNull: true,
        defaultValue: "0",
      },
      kinEmail: {
        type: DataTypes.STRING(50),
        allowNull: true,
        defaultValue: "0",
      },
      kinAddress: {
        type: DataTypes.STRING(500),
        allowNull: true,
        defaultValue: "0",
      },
      accountNo: {
        type: DataTypes.INTEGER,
        allowNull: true,
      },
      beneficiaryNo: {
        type: DataTypes.INTEGER,
        allowNull: true,
      },
      balance: {
        type: DataTypes.INTEGER,
        allowNull: true,
        defaultValue: 0,
      },
      id: {
        type: DataTypes.STRING(10),
        allowNull: false,
        primaryKey: true,
      },
      patient_id: {
        type: DataTypes.INTEGER,
        allowNull: false,
        primaryKey: true
      },
      enteredBy: {
        type: DataTypes.STRING(20),
        allowNull: true,
      },
      patientStatus: {
        type: DataTypes.STRING(50),
        allowNull: true,
      },
      assigned_to: {
        type: DataTypes.STRING(20),
        allowNull: true,
      },
      date_assigned: {
        type: DataTypes.DATE,
        allowNull: true,
      },
      status: {
        type: DataTypes.STRING(50),
        allowNull: true,
        defaultValue: "registered",
      },
      hematology: {
        type: DataTypes.STRING(20),
        allowNull: true,
      },
      microbiology: {
        type: DataTypes.STRING(20),
        allowNull: true,
      },
      chem_path: {
        type: DataTypes.STRING(20),
        allowNull: true,
      },
      radiology: {
        type: DataTypes.STRING(20),
        allowNull: true,
      },
      seen_by: {
        type: DataTypes.STRING(50),
        allowNull: true,
      },
      date_seen: {
        type: DataTypes.DATE,
        allowNull: true,
      },
      patient_passport: {
        type: DataTypes.STRING(100),
        allowNull: true,
      },
    },
    {
      sequelize,
      tableName: "patientrecords",
      timestamps: true,
      indexes: [
        {
          name: "id_patientfileno_ind",
          unique: true,
          using: "BTREE",
          fields: [
            
            { name: "facilityId" },
            { name: "id" },
            { name: "patient_id" },
          ],
        },
        {
          name: "facilityId_patientfileno_idx",
          using: "BTREE",
          fields: [{ name: "facilityId" }],
        },
        {
          name: "patient_id_patientfileno",
          using: "BTREE",
          fields: [{ name: "patient_id" }],
        },
        {
          name: "seen_by_patientfileno",
          using: "BTREE",
          fields: [{ name: "seen_by" }, { name: "date_seen" }],
        },
        {
          name: "accountNo_patientfileno_idx",
          using: "BTREE",
          fields: [{ name: "accountNo" }],
        },
        {
          name: "status_patientfileno",
          using: "BTREE",
          fields: [{ name: "status" }],
        },
        {
          name: "assigned_to_patientfileno",
          using: "BTREE",
          fields: [{ name: "assigned_to" }],
        },
        {
          name: "patientStatus_patientfileno",
          using: "BTREE",
          fields: [{ name: "patientStatus" }],
        },
        {
          name: "id_patientfileno_index1",
          using: "BTREE",
          fields: [{ name: "id" }],
        },
      ],
    }
  );
};
