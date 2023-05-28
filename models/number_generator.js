const Sequelize = require('sequelize');
module.exports = function(sequelize, DataTypes) {
  return sequelize.define('number_generator', {
    description: {
      type: DataTypes.STRING(100),
      allowNull: false
    },
    prefix: {
      type: DataTypes.STRING(100),
      allowNull: false,
      primaryKey: true
    },
    code_no: {
      type: DataTypes.INTEGER,
      allowNull: false
    }
  }, {
    sequelize,
    tableName: 'number_generator',
    timestamps: false,
    indexes: [
      {
        name: "id_number_generator",
        unique: true,
        using: "BTREE",
        fields: [
          { name: "prefix" },
        ]
      },
    ]
  });
};
