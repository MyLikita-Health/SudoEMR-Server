const Sequelize = require('sequelize');
module.exports = function(sequelize, DataTypes) {
  return sequelize.define('drug_schedule', {
    id: {
      autoIncrement: true,
      type: DataTypes.INTEGER,
      allowNull: false,
      primaryKey: true
    },
    allocation_id: {
      type: DataTypes.STRING(50),
      allowNull: true
    },
    patient_id: {
      type: DataTypes.STRING(50),
      allowNull: false
    },
    prescription_id: {
      type: DataTypes.STRING(50),
      allowNull: false
    },
    drug_name: {
      type: DataTypes.STRING(50),
      allowNull: false
    },
    time_stamp: {
      type: DataTypes.DATE,
      allowNull: true
    },
    status: {
      type: DataTypes.STRING(10),
      allowNull: false,
      defaultValue: "scheduled"
    },
    administered_by: {
      type: DataTypes.STRING(50),
      allowNull: false
    },
    facilityId: {
      type: DataTypes.STRING(50),
      allowNull: false
    },
    served_by: {
      type: DataTypes.STRING(50),
      allowNull: true
    },
    stopped_by: {
      type: DataTypes.STRING(50),
      allowNull: false
    },
    reason: {
      type: DataTypes.STRING(500),
      allowNull: true
    },
    frequency: {
      type: DataTypes.STRING(50),
      allowNull: true
    }
  }, {
    sequelize,
    tableName: 'drug_schedule',
    timestamps: false,
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
        name: "prescription_id",
        using: "BTREE",
        fields: [
          { name: "prescription_id" },
        ]
      },
      {
        name: "patient_id",
        using: "BTREE",
        fields: [
          { name: "patient_id" },
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
        name: "status",
        using: "BTREE",
        fields: [
          { name: "status" },
        ]
      },
      {
        name: "served_by",
        using: "BTREE",
        fields: [
          { name: "served_by" },
        ]
      },
      {
        name: "administered_by",
        using: "BTREE",
        fields: [
          { name: "administered_by" },
        ]
      },
      {
        name: "allocation_id",
        using: "BTREE",
        fields: [
          { name: "allocation_id" },
        ]
      },
    ]
  });
};
