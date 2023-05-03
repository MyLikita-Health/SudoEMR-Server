const Sequelize = require('sequelize');
module.exports = function(sequelize, DataTypes) {
  return sequelize.define('hospitals', {
    id: {
      type: DataTypes.STRING(50),
      allowNull: false,
      primaryKey: true
    },
    name: {
      type: DataTypes.STRING(255),
      allowNull: true
    },
    code: {
      type: DataTypes.STRING(255),
      allowNull: true
    },
    address: {
      type: DataTypes.STRING(255),
      allowNull: true
    },
    admin: {
      type: DataTypes.STRING(225),
      allowNull: true
    },
    useLetterHead: {
      type: DataTypes.STRING(10),
      allowNull: true
    },
    printTitle: {
      type: DataTypes.STRING(100),
      allowNull: true
    },
    printSubtitle1: {
      type: DataTypes.STRING(200),
      allowNull: true
    },
    printSubtitle2: {
      type: DataTypes.STRING(200),
      allowNull: true
    },
    modules: {
      type: DataTypes.STRING(100),
      allowNull: true
    },
    features: {
      type: DataTypes.STRING(500),
      allowNull: true
    },
    logo: {
      type: DataTypes.STRING(200),
      allowNull: true
    },
    type: {
      type: DataTypes.STRING(20),
      allowNull: true
    },
    hasStore: {
      type: DataTypes.INTEGER,
      allowNull: true
    },
    balance: {
      type: DataTypes.FLOAT,
      allowNull: false,
      defaultValue: 0
    }
  }, {
    sequelize,
    tableName: 'hospitals',
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
    ]
  });
};
