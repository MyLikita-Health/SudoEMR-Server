const Sequelize = require('sequelize');
module.exports = function(sequelize, DataTypes) {
  return sequelize.define('bedlist', {
    id: {
      autoIncrement: true,
      type: DataTypes.INTEGER,
      allowNull: false,
      primaryKey: true
    },
    sort_index: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 0
    },
    class_type: {
      type: DataTypes.STRING(50),
      allowNull: false
    },
    account: {
      type: DataTypes.STRING(10),
      allowNull: false
    },
    price: {
      type: DataTypes.INTEGER,
      allowNull: false
    },
    name: {
      type: DataTypes.STRING(100),
      allowNull: false
    },
    no_of_beds: {
      type: DataTypes.INTEGER,
      allowNull: false
    },
    facilityId: {
      type: DataTypes.STRING(50),
      allowNull: false
    }
  }, {
    sequelize,
    tableName: 'bedlist',
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
        name: "facilityId",
        using: "BTREE",
        fields: [
          { name: "facilityId" },
        ]
      },
      {
        name: "class_type",
        using: "BTREE",
        fields: [
          { name: "class_type" },
        ]
      },
      {
        name: "id",
        using: "BTREE",
        fields: [
          { name: "id" },
        ]
      },
    ]
  });
};
