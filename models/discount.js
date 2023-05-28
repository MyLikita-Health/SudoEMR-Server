const Sequelize = require('sequelize');
module.exports = function(sequelize, DataTypes) {
  return sequelize.define('discount', {
    id: {
      autoIncrement: true,
      type: DataTypes.INTEGER,
      allowNull: false,
      primaryKey: true
    },
    discountName: {
      type: DataTypes.STRING(50),
      allowNull: false
    },
    discountType: {
      type: DataTypes.STRING(20),
      allowNull: false
    },
    discountAmount: {
      type: DataTypes.INTEGER,
      allowNull: false
    },
    discountHead: {
      type: DataTypes.STRING(50),
      allowNull: false
    },
    discountHeadName: {
      type: DataTypes.STRING(50),
      allowNull: false
    },
    created_by: {
      type: DataTypes.STRING(50),
      allowNull: false
    },
    facilityId: {
      type: DataTypes.STRING(50),
      allowNull: false
    }
  }, {
    sequelize,
    tableName: 'discount',
    timestamps: true,
    indexes: [
      {
        name: "id_discount",
        unique: true,
        using: "BTREE",
        fields: [
          { name: "id" },
        ]
      },
    ]
  });
};
