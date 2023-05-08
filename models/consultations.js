const Sequelize = require("sequelize");
module.exports = function (sequelize, DataTypes) {
  return sequelize.define(
    "consultations",
    {
      id: {
        type: DataTypes.STRING(50),
        allowNull: false,
        primaryKey: true,
      },
      patient_id: {
        type: DataTypes.STRING(50),
        allowNull: false,
      },
      patient_name: {
        type: DataTypes.STRING(60),
        allowNull: true,
      },
      userId: {
        type: DataTypes.STRING(50),
        allowNull: false,
      },
      seen_by: {
        type: DataTypes.STRING(60),
        allowNull: true,
      },
      consultation_notes: {
        type: DataTypes.STRING(4000),
        allowNull: false,
      },
      treatmentPlan: {
        type: DataTypes.STRING(4000),
        allowNull: false,
      },
      decision: {
        type: DataTypes.STRING(50),
        allowNull: false,
      },
      dressing_request: {
        type: DataTypes.STRING(500),
        allowNull: false,
      },
      nursing_request: {
        type: DataTypes.STRING(500),
        allowNull: false,
      },
      nursing_request_status: {
        type: DataTypes.STRING(20),
        allowNull: false,
        defaultValue: "pending",
      },
      facilityId: {
        type: DataTypes.STRING(50),
        allowNull: false,
      },
      treatment_plan_status: {
        type: DataTypes.STRING(20),
        allowNull: false,
        defaultValue: "pending",
      },
      treatment_by: {
        type: DataTypes.STRING(20),
        allowNull: true,
      },
      created_at: {
        type: DataTypes.DATE,
        allowNull: true,
      },
    },
    {
      sequelize,
      tableName: "consultations",
      timestamps: true,
      indexes: [
        {
          name: "PRIMARY",
          unique: true,
          using: "BTREE",
          fields: [{ name: "id" }],
        },
        {
          name: "patient_id",
          using: "BTREE",
          fields: [{ name: "patient_id" }],
        },
        {
          name: "facilityId",
          using: "BTREE",
          fields: [{ name: "facilityId" }],
        },
        {
          name: "created_at",
          using: "BTREE",
          fields: [{ name: "created_at" }],
        },
        {
          name: "decision",
          using: "BTREE",
          fields: [{ name: "decision" }],
        },
        {
          name: "nursing_request_status",
          using: "BTREE",
          fields: [{ name: "nursing_request_status" }],
        },
        {
          name: "treatment_plan_status",
          using: "BTREE",
          fields: [{ name: "treatment_plan_status" }],
        },
        {
          name: "treatment_by",
          using: "BTREE",
          fields: [{ name: "treatment_by" }],
        },
        {
          name: "userId",
          using: "BTREE",
          fields: [{ name: "userId" }],
        },
      ],
    }
  );
};
