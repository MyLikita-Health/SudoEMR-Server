const Sequelize = require("sequelize");
module.exports = function (sequelize, DataTypes) {
  return sequelize.define(
    "druglist",
    {
      id: {
        autoIncrement: true,
        type: DataTypes.INTEGER,
        allowNull: false,
        primaryKey: true,
      },
      name: {
        type: DataTypes.STRING(50),
        allowNull: false,
      },
      generic_name: {
        type: DataTypes.STRING(50),
        allowNull: true,
      },
      formulation: {
        type: DataTypes.STRING(100),
        allowNull: true,
      },
      facilityId: {
        type: DataTypes.STRING(100),
        allowNull: false,
      },
    },
    {
      sequelize,
      tableName: "druglist",
      timestamps: true,
      indexes: [
        {
          name: "id_druglist",
          unique: true,
          using: "BTREE",
          fields: [{ name: "id" }],
        },
      ],
    }
  );
};
