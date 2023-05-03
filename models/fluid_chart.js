const Sequelize = require('sequelize');
module.exports = function(sequelize, DataTypes) {
  return sequelize.define('fluid_chart', {
    id: {
      autoIncrement: true,
      type: DataTypes.INTEGER,
      allowNull: false,
      primaryKey: true
    },
    patient_id: {
      type: DataTypes.STRING(50),
      allowNull: true
    },
    input_volume: {
      type: DataTypes.STRING(50),
      allowNull: true
    },
    input_route: {
      type: DataTypes.STRING(50),
      allowNull: true
    },
    input_type: {
      type: DataTypes.STRING(50),
      allowNull: true
    },
    output_volume: {
      type: DataTypes.STRING(50),
      allowNull: true
    },
    output_route: {
      type: DataTypes.STRING(60),
      allowNull: true
    },
    output_type: {
      type: DataTypes.STRING(60),
      allowNull: true
    },
    created_by: {
      type: DataTypes.STRING(50),
      allowNull: true
    }
  }, {
    sequelize,
    tableName: 'fluid_chart',
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
