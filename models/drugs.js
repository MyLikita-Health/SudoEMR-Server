const Sequelize = require('sequelize');
module.exports = function(sequelize, DataTypes) {
  return sequelize.define('drugs', {
    drug_code: {
      type: DataTypes.STRING(50),
      allowNull: false
    },
    drug: {
      type: DataTypes.STRING(20),
      allowNull: true
    },
    expiry_date: {
      type: DataTypes.STRING(10),
      allowNull: true
    },
    price: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    },
    unit_of_issue: {
      type: DataTypes.STRING(20),
      allowNull: true,
      defaultValue: "0"
    },
    qty_in: {
      type: DataTypes.INTEGER,
      allowNull: false
    },
    qty_out: {
      type: DataTypes.INTEGER,
      allowNull: false
    },
    source: {
      type: DataTypes.STRING(100),
      allowNull: false
    },
    supplier: {
      type: DataTypes.STRING(100),
      allowNull: true
    },
    receipt_no: {
      type: DataTypes.STRING(11),
      allowNull: false,
      defaultValue: "0"
    },
    store_award_no: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    },
    created_by: {
      type: DataTypes.STRING(30),
      allowNull: true
    },
    receipt_image: {
      type: DataTypes.BLOB,
      allowNull: true
    },
    genericName: {
      type: DataTypes.STRING(50),
      allowNull: true
    },
    markup: {
      type: DataTypes.INTEGER,
      allowNull: false
    },
    client_acct: {
      type: DataTypes.STRING(50),
      allowNull: false
    },
    shift: {
      type: DataTypes.STRING(20),
      allowNull: false
    },
    facilityId: {
      type: DataTypes.STRING(50),
      allowNull: true
    }
  }, {
    sequelize,
    tableName: 'drugs',
    timestamps: true
  });
};
