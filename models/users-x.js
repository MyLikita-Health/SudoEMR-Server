const Sequelize = require('sequelize');
module.exports = function(sequelize, DataTypes) {
  return sequelize.define('users', {
    id: {
      autoIncrement: true,
      type: DataTypes.INTEGER,
      allowNull: false,
      primaryKey: true
    },
    firstname: {
      type: DataTypes.STRING(255),
      allowNull: true
    },
    lastname: {
      type: DataTypes.STRING(255),
      allowNull: true
    },
    privilege: {
      type: DataTypes.INTEGER,
      allowNull: true,
      defaultValue: 4
    },
    role: {
      type: DataTypes.STRING(255),
      allowNull: true
    },
    speciality: {
      type: DataTypes.STRING(50),
      allowNull: true
    },
    accessTo: {
      type: DataTypes.STRING(255),
      allowNull: true
    },
    functionalities: {
      type: DataTypes.STRING(2000),
      allowNull: true
    },
    username: {
      type: DataTypes.STRING(255),
      allowNull: true
    },
    email: {
      type: DataTypes.STRING(255),
      allowNull: true
    },
    prefix: {
      type: DataTypes.STRING(50),
      allowNull: true
    },
    userType: {
      type: DataTypes.STRING(10),
      allowNull: true
    },
    serviceCost: {
      type: DataTypes.STRING(10),
      allowNull: true
    },
    licenceNo: {
      type: DataTypes.STRING(50),
      allowNull: true
    },
    placeOfWork: {
      type: DataTypes.STRING(100),
      allowNull: true
    },
    password: {
      type: DataTypes.STRING(255),
      allowNull: true
    },
    status: {
      type: DataTypes.STRING(20),
      allowNull: true,
      defaultValue: "pending"
    },
    loggedIn: {
      type: DataTypes.STRING(200),
      allowNull: true
    },
    availableDays: {
      type: DataTypes.STRING(200),
      allowNull: true
    },
    availableFromTime: {
      type: DataTypes.STRING(20),
      allowNull: true
    },
    availableToTime: {
      type: DataTypes.STRING(20),
      allowNull: true
    },
    address: {
      type: DataTypes.STRING(200),
      allowNull: true
    },
    phone: {
      type: DataTypes.STRING(50),
      allowNull: true
    },
    paymentMethod: {
      type: DataTypes.STRING(50),
      allowNull: true
    },
    paymentAmount: {
      type: DataTypes.INTEGER,
      allowNull: true
    },
    referralId: {
      type: DataTypes.STRING(50),
      allowNull: true
    },
    lastLogin: {
      type: DataTypes.STRING(20),
      allowNull: true
    },
    image: {
      type: DataTypes.STRING(255),
      allowNull: true
    },
    facilityId: {
      type: DataTypes.STRING(50),
      allowNull: false,
      primaryKey: true
    },
    createdBy: {
      type: DataTypes.STRING(50),
      allowNull: true
    },
    department: {
      type: DataTypes.STRING(50),
      allowNull: true
    },
    functionality: {
      type: DataTypes.STRING(2000),
      allowNull: true
    },
    branch_name: {
      type: DataTypes.STRING(50),
      allowNull: true
    }
  }, {
    sequelize,
    tableName: 'users',
    timestamps: true,
    indexes: [
      {
        name: "id_users",
        unique: true,
        using: "BTREE",
        fields: [
          { name: "id" },
          { name: "facilityId" },
        ]
      },
      {
        name: "facilityId_users",
        using: "BTREE",
        fields: [
          { name: "facilityId" },
        ]
      },
      {
        name: "createdAt_users",
        using: "BTREE",
        fields: [
          { name: "createdAt" },
        ]
      },
      {
        name: "id",
        using: "BTREE",
        fields: [
          { name: "id" },
        ]
      },
    ]
  });
};
