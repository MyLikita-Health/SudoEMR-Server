'use strict';
module.exports = (sequelize, DataTypes) => {
  const User = sequelize.define(
    'user',
    {
      firstname: DataTypes.STRING,
      lastname: DataTypes.STRING,
      privilege: DataTypes.INTEGER,
      role: DataTypes.STRING,
      accessTo: DataTypes.STRING,
      username: DataTypes.STRING,
      email: DataTypes.STRING,
      phone: DataTypes.STRING,
      password: DataTypes.STRING,
      image: DataTypes.STRING,
      facilityId: DataTypes.STRING,
      speciality: DataTypes.STRING,
      licenceNo: DataTypes.STRING,
      prefix: DataTypes.STRING,
      createdBy: DataTypes.STRING,
      userType: DataTypes.STRING,
      serviceCost: DataTypes.STRING,
      status: {
        type: DataTypes.STRING,
        defaultValue: 'pending'
      },
      referralId: DataTypes.STRING,
      loggedIn: DataTypes.STRING,
      lastLogin: DataTypes.STRING,
      address: DataTypes.STRING,
      availableDays: DataTypes.STRING,
      availableFromTime: DataTypes.STRING,
      availableToTime: DataTypes.STRING,
      department: DataTypes.STRING,
      functionality: DataTypes.STRING(2000)
    },
    {}
  );

  // User.associate = function(models) {
  //   models.User.belongsTo(models.Hospital, {
  //     onDelete: 'CASCADE',
  //     foreignKey: {
  //       allowNull: false,
  //     },
  //   });
  //   models.User.belongsTo(models.Role);
  //   // models.User.hasMany(models.Appointment);
  //   // models.User.hasMany(models.Post);
  //   // models.User.hasMany(models.Comment);
  // };

  return User;
};
