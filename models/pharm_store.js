const Sequelize = require('sequelize');
module.exports = function(sequelize, DataTypes) {
  return sequelize.define('pharm_store', {
    balance: {
      type: DataTypes.INTEGER,
      allowNull: true,
      defaultValue: 0
    },
    drug_name: {
      type: DataTypes.STRING(100),
      allowNull: true
    },
    price: {
      type: DataTypes.FLOAT,
      allowNull: true
    },
    prefix: {
      type: DataTypes.STRING(50),
      allowNull: true
    },
    item_code: {
      type: DataTypes.STRING(50),
      allowNull: false,
      primaryKey: true
    },
    group_code: {
      type: DataTypes.STRING(50),
      allowNull: true
    },
    specification: {
      type: DataTypes.STRING(50),
      allowNull: true
    },
    facilityId: {
      type: DataTypes.STRING(50),
      allowNull: false,
      primaryKey: true
    },
    expired_status: {
      type: DataTypes.STRING(50),
      allowNull: true,
      defaultValue: "false"
    },
    expiry_date: {
      type: DataTypes.DATEONLY,
      allowNull: false,
      defaultValue: "1111-11-11",
      primaryKey: true
    },
    store: {
      type: DataTypes.STRING(50),
      allowNull: false,
      primaryKey: true
    },
    selling_price: {
      type: DataTypes.FLOAT,
      allowNull: false,
      primaryKey: true
    },
    supplier_name: {
      type: DataTypes.STRING(100),
      allowNull: true
    },
    supplier_code: {
      type: DataTypes.STRING(100),
      allowNull: true
    },
    store_location: {
      type: DataTypes.STRING(50),
      allowNull: true
    },
    generic_name: {
      type: DataTypes.STRING(50),
      allowNull: true
    },
    insert_date: {
      type: DataTypes.DATE,
      allowNull: true
    },
    reoder_level: {
      type: DataTypes.INTEGER,
      allowNull: true
    },
    uom: {
      type: DataTypes.STRING(100),
      allowNull: true
    },
    drug_category: {
      type: DataTypes.STRING(100),
      allowNull: true
    },
    item_id: {
      type: DataTypes.STRING(60),
      allowNull: true,
      unique: "item_id"
    },
    barcode: {
      type: DataTypes.STRING(100),
      allowNull: true
    },
    grn_no: {
      type: DataTypes.STRING(20),
      allowNull: true
    }
  }, {
    sequelize,
    tableName: 'pharm_store',
    timestamps: false,
    indexes: [
      {
        name: "id_pharm_store",
        unique: true,
        using: "BTREE",
        fields: [
          { name: "item_code" },
          { name: "facilityId" },
          { name: "expiry_date" },
          { name: "store" },
          { name: "selling_price" },
        ]
      },
      {
        name: "item_id_pharm_store",
        unique: true,
        using: "BTREE",
        fields: [
          { name: "item_id" },
        ]
      },
    ]
  });
};
