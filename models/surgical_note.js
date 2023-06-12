const Sequelize = require("sequelize");
module.exports = function (sequelize, DataTypes) {
  return sequelize.define(
    "surgical_note",
    {
      id: {
        autoIncrement: true,
        type: DataTypes.INTEGER,
        allowNull: false,
        primaryKey: true,
      },
      patient_id: {
        type: DataTypes.STRING(50),
        allowNull: false,
      },
      patient_name:{
        type: DataTypes.STRING(50),
        allowNull: false,
      },
      relative:{
        type: DataTypes.STRING(50),
        allowNull: false,
      },
      agreed:{
        type: DataTypes.STRING(50),
        allowNull: false,
      },
      witness_by:{
        type: DataTypes.STRING(50),
        allowNull: false,
      },
      created_by: {
        type: DataTypes.STRING(50),
        allowNull: false,
      },
      facilityId: {
        type: DataTypes.STRING(50),
        allowNull: false,
      },
    },
    {
      sequelize,
      tableName: "surgical_note",
      timestamps: true,
      indexes: [
        {
          name: "id_surgical_note",
          unique: true,
          using: "BTREE",
          fields: [{ name: "id" }],
        },
      ],
    }
  );
};
