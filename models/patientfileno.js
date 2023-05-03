const Sequelize = require('sequelize');
module.exports = function(sequelize, DataTypes) {
  return sequelize.define('patientfileno', {
    id: {
      autoIncrement: true,
      type: DataTypes.INTEGER,
      allowNull: false,
      primaryKey: true
    },
    facilityId: {
      type: DataTypes.STRING(50),
      allowNull: true
    },
    accountNo: {
      type: DataTypes.INTEGER,
      allowNull: true
    },
    accName: {
      type: DataTypes.STRING(50),
      allowNull: true
    },
    description: {
      type: DataTypes.STRING(100),
      allowNull: true
    },
    accountType: {
      type: DataTypes.STRING(50),
      allowNull: true
    },
    contactName: {
      type: DataTypes.STRING(100),
      allowNull: true
    },
    contactAddress: {
      type: DataTypes.STRING(500),
      allowNull: true
    },
    contactPhone: {
      type: DataTypes.STRING(20),
      allowNull: true
    },
    contactEmail: {
      type: DataTypes.STRING(50),
      allowNull: true
    },
    contactWebsite: {
      type: DataTypes.STRING(50),
      allowNull: true
    },
    firstname: {
      type: DataTypes.STRING(50),
      allowNull: true
    },
    surname: {
      type: DataTypes.STRING(50),
      allowNull: true
    },
    beneficiaries: {
      type: DataTypes.BIGINT,
      allowNull: false,
      defaultValue: 0
    },
    balance: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    },
    status: {
      type: DataTypes.STRING(50),
      allowNull: false,
      defaultValue: "approved"
    },
    guarantor_name: {
      type: DataTypes.STRING(50),
      allowNull: true
    },
    guarantor_address: {
      type: DataTypes.STRING(100),
      allowNull: true
    },
    guarantor_phone: {
      type: DataTypes.STRING(20),
      allowNull: true
    },
    created_by: {
      type: DataTypes.STRING(50),
      allowNull: true
    },
    approved_by: {
      type: DataTypes.STRING(50),
      allowNull: true
    },
    approved_at: {
      type: DataTypes.DATE,
      allowNull: true
    },
    payable_head_name: {
      type: DataTypes.STRING(150),
      allowNull: true
    },
    payable_head: {
      type: DataTypes.STRING(50),
      allowNull: true
    },
    receivable_head_name: {
      type: DataTypes.STRING(150),
      allowNull: true
    },
    receivable_head: {
      type: DataTypes.STRING(50),
      allowNull: true
    }
  }, {
    sequelize,
    tableName: 'patientfileno',
    timestamps: true,
    indexes: [
      {
        name: "PRIMARY",
        unique: true,
        using: "BTREE",
        fields: [
          { name: "id" },
        ]
      },
      {
        name: "facilityId",
        using: "BTREE",
        fields: [
          { name: "facilityId" },
        ]
      },
      {
        name: "accountNo",
        using: "BTREE",
        fields: [
          { name: "accountNo" },
        ]
      },
    ]
  });
};
