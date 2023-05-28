const Sequelize = require('sequelize');
module.exports = function(sequelize, DataTypes) {
  return sequelize.define('previous_doc', {
    id: {
      autoIncrement: true,
      type: DataTypes.INTEGER,
      allowNull: false,
      primaryKey: true
    },
    patient_id: {
      type: DataTypes.STRING(20),
      allowNull: true
    },
    file_type: {
      type: DataTypes.STRING(50),
      allowNull: true
    },
    file_url: {
      type: DataTypes.STRING(200),
      allowNull: true
    },
    file_date: {
      type: DataTypes.DATEONLY,
      allowNull: true
    }
  }, {
    sequelize,
    tableName: 'previous_doc',
    timestamps: true,
    indexes: [
      {
        name: "id_previous_doc",
        unique: true,
        using: "BTREE",
        fields: [
          { name: "id" },
        ]
      },
    ]
  });
};
