const Sequelize = require('sequelize');
module.exports = function(sequelize, DataTypes) {
  return sequelize.define('pagenavigation', {
    id: {
      autoIncrement: true,
      type: DataTypes.INTEGER,
      allowNull: false,
      primaryKey: true
    },
    role: {
      type: DataTypes.STRING(30),
      allowNull: false
    },
    home_page: {
      type: DataTypes.STRING(100),
      allowNull: false
    },
    facilityId: {
      type: DataTypes.STRING(50),
      allowNull: false
    }
  }, {
    sequelize,
    tableName: 'pagenavigation',
    timestamps: false,
    indexes: [
      {
        name: "id_pagenavigation",
        unique: true,
        using: "BTREE",
        fields: [
          { name: "id" },
        ]
      },
      {
        name: "role_pagenavigation",
        using: "BTREE",
        fields: [
          { name: "role" },
        ]
      },
      {
        name: "facilityId_pagenavigation",
        using: "BTREE",
        fields: [
          { name: "facilityId" },
        ]
      },
    ]
  });
};
