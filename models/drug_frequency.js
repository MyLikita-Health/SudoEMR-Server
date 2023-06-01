const Sequelize = require('sequelize');
module.exports = function(sequelize, DataTypes) {
  return sequelize.define('drug_frequency', {
    id: {
      autoIncrement: true,
      type: DataTypes.INTEGER,
      allowNull: false,
      primaryKey: true
    },
    description: {
      type: DataTypes.STRING(20),
      allowNull: false
    },
    time: {
      type: DataTypes.TIME,
      allowNull: true
    },
    drug_time: {
      type: DataTypes.STRING(50),
      allowNull: true
    },
    no_times: {
      type: DataTypes.STRING(20),
      allowNull: true
    },
    facilityId: {
      type: DataTypes.STRING(100),
      allowNull: false
    }
  }, {
    sequelize,
    tableName: 'drug_frequency',
    timestamps: false,
    indexes: [
      {
        name: "id_drug_frequency",
        unique: true,
        using: "BTREE",
        fields: [
          { name: "id" },
        ]
      },
    ]
  });
};
