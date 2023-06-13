const Sequelize = require('sequelize');
module.exports = function(sequelize, DataTypes) {
  return sequelize.define('medical_report', {
    id: {
      autoIncrement: true,
      type: DataTypes.INTEGER,
      allowNull: false,
      primaryKey: true
    },
    user_id: {
      type: DataTypes.STRING(100),
      allowNull: false
    },
    admit_date:{
      type: DataTypes.DATE,
      allowNull: false
    },
    proceduce_date:{
      type: DataTypes.DATE,
      allowNull: false
    },
    discharge_date:{
      type: DataTypes.DATE,
      allowNull: false
    },
    special_instruction:{
      type: DataTypes.STRING(3000),
      allowNull: false
    },
    other_info:{
      type: DataTypes.STRING(3000),
      allowNull: false
    },
    facilityId:{
      type: DataTypes.STRING(100),
      allowNull: false
    }
  }, {
    sequelize,
    tableName: 'medical_report',
    timestamps: false,
    indexes: [
      {
        name: "id_medical_report",
        unique: true,
        using: "BTREE",
        fields: [
          { name: "id" },
        ]
      },
    ]
  });
};
