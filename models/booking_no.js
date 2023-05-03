const Sequelize = require('sequelize');
module.exports = function(sequelize, DataTypes) {
  return sequelize.define('booking_no', {
    id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      primaryKey: true
    },
    lab_code: {
      type: DataTypes.INTEGER,
      allowNull: false
    },
    year_code: {
      type: DataTypes.INTEGER,
      allowNull: false
    },
    booking: {
      type: DataTypes.INTEGER,
      allowNull: false
    }
  }, {
    sequelize,
    tableName: 'booking_no',
    timestamps: false
  });
};
