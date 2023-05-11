const Sequelize = require('sequelize');
module.exports = function(sequelize, DataTypes) {
  return sequelize.define('vital_signs', {
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
    body_temp: {
      type: DataTypes.STRING(5),
      allowNull: true
    },
    pulse_rate: {
      type: DataTypes.STRING(10),
      allowNull: true
    },
    blood_pressure: {
      type: DataTypes.STRING(10),
      allowNull: true
    },
    respiratory_rate: {
      type: DataTypes.STRING(10),
      allowNull: true
    },
    fasting_blood_sugar: {
      type: DataTypes.STRING(10),
      allowNull: true
    },
    random_blood_sugar: {
      type: DataTypes.STRING(10),
      allowNull: true
    },
    spo2: {
      type: DataTypes.STRING(50),
      allowNull: true
    },
    created_by: {
      type: DataTypes.STRING(50),
      allowNull: false
    },
    facilityId: {
      type: DataTypes.STRING(50),
      allowNull: false
    },
    created_at: {
      type: DataTypes.DATE,
      allowNull: false
    }
  }, {
    sequelize,
    tableName: 'vital_signs',
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
        name: "created_at",
        using: "BTREE",
        fields: [
          { name: "created_at" },
        ]
      },
      {
        name: "created_by",
        using: "BTREE",
        fields: [
          { name: "created_by" },
        ]
      },
    ]
  });
};
