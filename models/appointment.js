const Sequelize = require('sequelize');
module.exports = function(sequelize, DataTypes) {
  return sequelize.define('appointment', {
    id: {
      autoIncrement: true,
      type: DataTypes.INTEGER,
      allowNull: false,
      primaryKey: true
    },
    user_id: {
      type: DataTypes.STRING(20),
      allowNull: true
    },
    patientId: {
      type: DataTypes.STRING(20),
      allowNull: true
    },
    patient_name: {
      type: DataTypes.STRING(70),
      allowNull: true
    },
    appointmentType: {
      type: DataTypes.STRING(40),
      allowNull: true
    },
    location: {
      type: DataTypes.STRING(80),
      allowNull: true
    },
    notes: {
      type: DataTypes.STRING(100),
      allowNull: true
    },
    start_at: {
      type: DataTypes.DATE,
      allowNull: false,
      defaultValue: Sequelize.Sequelize.fn('current_timestamp')
    },
    end_at: {
      type: DataTypes.DATE,
      allowNull: false,
      defaultValue: Sequelize.Sequelize.fn('current_timestamp')
    },
    facilityId: {
      type: DataTypes.STRING(60),
      allowNull: true
    }
  }, {
    sequelize,
    tableName: 'appointment',
    timestamps: false,
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
