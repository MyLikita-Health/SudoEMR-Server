const Sequelize = require("sequelize");
module.exports = function (sequelize, DataTypes) {
  return sequelize.define(
    "bed_allocation",
    {
      id: {
        autoIncrement: true,
        type: DataTypes.INTEGER,
        allowNull: false,
        primaryKey: true,
      },
      bed_id: {
        type: DataTypes.INTEGER,
        allowNull: false,
      },
      patient_id: {
        type: DataTypes.STRING(50),
        allowNull: false,
      },
      allocation_status: {
        type: DataTypes.STRING(20),
        allowNull: true,
      },
      allocated: {
        type: DataTypes.DATE,
        allowNull: false,
        defaultValue: DataTypes.NOW,
      },
      ended: {
        type: DataTypes.DATE,
        allowNull: true,
      },
      allocated_by: {
        type: DataTypes.STRING(50),
        allowNull: false,
      },
      ended_by: {
        type: DataTypes.STRING(50),
        allowNull: true,
      },
      facilityId: {
        type: DataTypes.STRING(50),
        allowNull: false,
      },
    },
    {
      sequelize,
      tableName: "bed_allocation",
      timestamps: false,
      indexes: [
        {
          name: "idx_bed_allocation_id",
          unique: true,
          using: "BTREE",
          fields: [{ name: "id" }],
        },
        {
          name: "allocation_status",
          using: "BTREE",
          fields: [{ name: "allocation_status" }],
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
          name: "allocated_by",
          using: "BTREE",
          fields: [{ name: "allocated_by" }],
        },
        {
          name: "ended",
          using: "BTREE",
          fields: [{ name: "ended" }],
        },
        {
          name: "allocated",
          using: "BTREE",
          fields: [{ name: "allocated" }],
        },
        {
          name: "bed_id",
          using: "BTREE",
          fields: [{ name: "bed_id" }],
        },
      ],
    }
  );
};
