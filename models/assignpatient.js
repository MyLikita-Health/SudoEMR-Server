const Sequelize = require('sequelize');
module.exports = function(sequelize, DataTypes) {
  return sequelize.define('assignpatient', {
    diagDate: {
      type: DataTypes.DATEONLY,
      allowNull: false
    },
    patientNo: {
      type: DataTypes.STRING(50),
      allowNull: false
    },
    seenBy: {
      type: DataTypes.STRING(50),
      allowNull: false
    }
  }, {
    sequelize,
    tableName: 'assignpatient',
    timestamps: false
  });
};
