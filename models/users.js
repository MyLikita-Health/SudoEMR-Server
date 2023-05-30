"use strict";
module.exports = (sequelize, DataTypes) => {
  const Users = sequelize.define(
    "users",
    {
      id: {
        type: DataTypes.INTEGER,
        allowNull: false,
        primaryKey: true,
        autoIncrement:true
      },
      firstname: {
        type: DataTypes.STRING,
        allowNull: false,
      },
      lastname: {
        type: DataTypes.STRING,
        allowNull: false,
      },
      privilege: {
        type: DataTypes.INTEGER,
        allowNull: false,
      },
      role: {
        type: DataTypes.STRING,
        allowNull: false,
      },
      accessTo: {
        type: DataTypes.STRING,
        allowNull: false,
      },
      username: {
        type: DataTypes.STRING,
        allowNull: false,
      },
      email: {
        type: DataTypes.STRING,
        allowNull: false,
      },
      phone: {
        type: DataTypes.STRING,
        allowNull: false,
      },
      password: {
        type: DataTypes.STRING,
        allowNull: false,
      },
      image: {
        type: DataTypes.STRING,
        allowNull: false,
      },
      facilityId: {
        type: DataTypes.STRING,
        allowNull: false,
      },
      speciality: {
        type: DataTypes.STRING,
        allowNull: true,
      },
      licenceNo: {
        type: DataTypes.STRING,
        allowNull: true,
      },
      prefix: {
        type: DataTypes.STRING,
        allowNull: true,
      },
      createdBy: {
        type: DataTypes.STRING,
        allowNull: true,
      },
      userType: {
        type: DataTypes.STRING,
        allowNull: true,
      },
      serviceCost: {
        type: DataTypes.INTEGER,
        allowNull: true,
      },
      status: {
        type: DataTypes.STRING,
        defaultValue: "pending",
      },
      referralId: {
        type: DataTypes.STRING(255),
        allowNull: true,
      },
      loggedIn: {
        type: DataTypes.STRING(255),
        allowNull: true,
      },
      lastLogin: {
        type: DataTypes.STRING(255),
        allowNull: true,
      },
      address: {
        type: DataTypes.STRING(255),
        allowNull: true,
      },
      availableDays: {
        type: DataTypes.STRING(255),
        allowNull: true,
      },
      availableFromTime: {
        type: DataTypes.STRING(255),
        allowNull: true,
      },
      availableToTime: {
        type: DataTypes.STRING(255),
        allowNull: true,
      },
      department: {
        type: DataTypes.STRING(255),
        allowNull: true,
      },
      functionality: {
        type: DataTypes.STRING(2000),
        allowNull: true,
      },
    },
    {
      sequelize,
      tableName: "users",
      timestamps: true,
      indexes: [
        {
          name: "id_users",
          unique: true,
          using: "BTREE",
          fields: [{ name: "id" }, { name: "facilityId" }],
        },
        {
          name: "facilityId_users",
          using: "BTREE",
          fields: [{ name: "facilityId" }],
        },
        {
          name: "createdAt_users",
          using: "BTREE",
          fields: [{ name: "createdAt" }],
        },
        {
          name: "id_users_001",
          using: "BTREE",
          fields: [{ name: "id" }],
        },
      ],
    }
  );
  return Users;
};
