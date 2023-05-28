const Sequelize = require('sequelize');
module.exports = function(sequelize, DataTypes) {
  return sequelize.define('nursing_report', {
    id: {
      autoIncrement: true,
      type: DataTypes.INTEGER,
      allowNull: false,
      primaryKey: true
    },
    created_by: {
      type: DataTypes.STRING(50),
      allowNull: false
    },
    report: {
      type: DataTypes.TEXT,
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
    tableName: 'nursing_report',
    timestamps: true,
    indexes: [
      {
        name: "id_nursing_report",
        unique: true,
        using: "BTREE",
        fields: [
          { name: "id" },
        ]
      },
      {
        name: "created_at_nursing_report",
        using: "BTREE",
        fields: [
          { name: "created_at" },
        ]
      },
      {
        name: "facilityId_nursing_report",
        using: "BTREE",
        fields: [
          { name: "facilityId" },
        ]
      },
      {
        name: "created_by_nursing_report",
        using: "BTREE",
        fields: [
          { name: "created_by" },
        ]
      },
    ]
  });
};
