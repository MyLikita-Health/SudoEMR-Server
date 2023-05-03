const Sequelize = require('sequelize');
module.exports = function(sequelize, DataTypes) {
  return sequelize.define('prescriptionrequests', {
    facilityId: {
      type: DataTypes.STRING(50),
      allowNull: false
    },
    date: {
      type: DataTypes.DATEONLY,
      allowNull: true
    },
    patient_id: {
      type: DataTypes.STRING(11),
      allowNull: false
    },
    dosage: {
      type: DataTypes.STRING(10),
      allowNull: false
    },
    drug_status: {
      type: DataTypes.STRING(10),
      allowNull: false
    },
    seen_by: {
      type: DataTypes.STRING(20),
      allowNull: false
    },
    duration: {
      type: DataTypes.STRING(10),
      allowNull: false
    },
    period: {
      type: DataTypes.STRING(5),
      allowNull: false
    },
    drug: {
      type: DataTypes.STRING(15),
      allowNull: false
    },
    frequency: {
      type: DataTypes.INTEGER,
      allowNull: false
    },
    drug_request_id: {
      type: DataTypes.INTEGER,
      allowNull: false
    },
    price: {
      type: DataTypes.INTEGER,
      allowNull: false
    },
    quantity_dispensed: {
      type: DataTypes.INTEGER,
      allowNull: false
    }
  }, {
    sequelize,
    tableName: 'prescriptionrequests',
    timestamps: false
  });
};
