/* jshint indent: 2 */

module.exports = function (sequelize, DataTypes) {
  return sequelize.define(
    'wholesale_transaction',
    {
      id: {
        type: DataTypes.UUID,
        allowNull: false,
        primaryKey: true,
        defaultValue: DataTypes.UUIDV4,
      },
      date: {
        type: DataTypes.STRING(100),
        allowNull: false,
      },
      time: {
        type: DataTypes.STRING(50),
        allowNull: true,
      },
      name: {
        type: DataTypes.STRING(50),
        allowNull: true,
      },
      phone_no: {
        type: DataTypes.STRING(50),
        allowNull: true,
      },
      unit: {
        type: DataTypes.INTEGER(11),
        allowNull: true,
      },
      amount: {
        type: DataTypes.STRING(50),
        allowNull: false,
      },
      type: {
        type: DataTypes.STRING(20),
        allowNull: false,
      },
      giver: {
        type: DataTypes.STRING(100),
        allowNull: true,
      },
      reciever: {
        type: DataTypes.STRING(100),
        allowNull: true,
      },
      description: {
        type: DataTypes.STRING(100),
        allowNull: true,
      },
    },
    {
      tableName: 'wholesale_transaction',
    }
  );
};
