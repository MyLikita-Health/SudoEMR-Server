const Sequelize = require('sequelize');
module.exports = function(sequelize, DataTypes) {
  return sequelize.define('sensitivity_results', {
    antibiotic: {
      type: DataTypes.STRING(50),
      allowNull: false,
      primaryKey: true
    },
    isolates: {
      type: DataTypes.STRING(50),
      allowNull: true
    },
    R: {
      type: DataTypes.STRING(10),
      allowNull: false
    },
    S: {
      type: DataTypes.STRING(10),
      allowNull: false
    },
    I: {
      type: DataTypes.STRING(10),
      allowNull: false
    },
    created_by: {
      type: DataTypes.STRING(50),
      allowNull: false
    },
    updated_by: {
      type: DataTypes.STRING(50),
      allowNull: false
    },
    labno: {
      type: DataTypes.STRING(50),
      allowNull: false,
      primaryKey: true
    }
  }, {
    sequelize,
    tableName: 'sensitivity_results',
    timestamps: true,
    indexes: [
      {
        name: "id_sensitivity_results",
        unique: true,
        using: "BTREE",
        fields: [
          { name: "antibiotic" },
          { name: "labno" },
        ]
      },
    ]
  });
};
