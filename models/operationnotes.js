const Sequelize = require('sequelize');
module.exports = function(sequelize, DataTypes) {
  return sequelize.define('operationnotes', {
    id: {
      autoIncrement: true,
      type: DataTypes.INTEGER,
      allowNull: false,
      primaryKey: true
    },
    uuid: {
      type: DataTypes.STRING(70),
      allowNull: true
    },
    created_by: {
      type: DataTypes.STRING(50),
      allowNull: false
    },
    report: {
      type: DataTypes.TEXT,
      allowNull: false
    },
    facilityId: {
      type: DataTypes.STRING(50),
      allowNull: true
    },
    date: {
      type: DataTypes.DATE,
      allowNull: true
    },
    postOpOrder:{
      type: DataTypes.STRING(1500),
      allowNull: true
    },
    pathologyRequest:{
      type: DataTypes.STRING(2000),
      allowNull: false
    },
    procedureNotes:{
      type: DataTypes.STRING(2000),
      allowNull: true
    },
    intraOpFindings:{
      type: DataTypes.STRING(2000),
      allowNull: true
    },
    intraOpAntibiotics:{
      type: DataTypes.STRING(20),
      allowNull: true
    },
    bloodLoss:{
      type: DataTypes.STRING(20),
      allowNull: true
    },
    pintsGiven:{
      type: DataTypes.STRING(10),
      allowNull: true
    },
    name:{
      type: DataTypes.STRING(100),
      allowNull: true
    },
    remarks:{
      type: DataTypes.STRING(50),
      allowNull: true
    },
    scrubNurse:{
      type: DataTypes.STRING(50),
      allowNull: true
    },
    anesthetic:{
      type: DataTypes.STRING(150),
      allowNull: true
    },
    anesthetist:{
      type: DataTypes.STRING(150),
      allowNull: true
    },
    surgery:{
      type: DataTypes.STRING(150),
      allowNull: true
    },
    surgeons:{
      type: DataTypes.STRING(300),
      allowNull: true
    },
    diagnosis:{
      type: DataTypes.STRING(150),
      allowNull: true
    },
    patientId:{
      type: DataTypes.STRING(20),
      allowNull: false
    }
  }, {
    sequelize,
    tableName: 'operationnotes',
    timestamps: true,
    indexes: [
      {
        name: "id_operationnotes",
        unique: true,
        using: "BTREE",
        fields: [
          { name: "id" },
        ]
      },
      {
        name: "facilityId_operationnotes",
        using: "BTREE",
        fields: [
          { name: "facilityId" },
        ]
      },
      {
        name: "created_by_operationnotes",
        using: "BTREE",
        fields: [
          { name: "created_by" },
        ]
      },
    ]
  });
};
