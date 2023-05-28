const Sequelize = require('sequelize');
module.exports = function(sequelize, DataTypes) {
  return sequelize.define('patient_history', {
    id: {
      autoIncrement: true,
      type: DataTypes.INTEGER,
      allowNull: false,
      primaryKey: true
    },
    patient_id: {
      type: DataTypes.STRING(50),
      allowNull: false
    },
    request_id: {
      type: DataTypes.INTEGER,
      allowNull: false
    },
    history: {
      type: DataTypes.STRING(1000),
      allowNull: false
    },
    file: {
      type: DataTypes.STRING(200),
      allowNull: false
    },
    facilityId: {
      type: DataTypes.STRING(50),
      allowNull: false
    }
  }, {
    sequelize,
    tableName: 'patient_history',
    timestamps: true,
    indexes: [
      {
        name: "id_patient_history",
        unique: true,
        using: "BTREE",
        fields: [
          { name: "id" },
        ]
      },
      {
        name: "patient_id_patient_history",
        using: "BTREE",
        fields: [
          { name: "patient_id" },
        ]
      },
      {
        name: "request_id_patient_history",
        using: "BTREE",
        fields: [
          { name: "request_id" },
        ]
      },
      {
        name: "facilityId_patient_history",
        using: "BTREE",
        fields: [
          { name: "facilityId" },
        ]
      },
      {
        name: "createdAt_patient_history",
        using: "BTREE",
        fields: [
          { name: "createdAt" },
        ]
      },
    ]
  });
};
