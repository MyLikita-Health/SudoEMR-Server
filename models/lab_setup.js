const Sequelize = require("sequelize");
module.exports = function (sequelize, DataTypes) {
  return sequelize.define(
    "lab_setup",
    {
      id: {
        autoIncrement: true,
        type: DataTypes.INTEGER,
        allowNull: false,
        primaryKey: true,
      },
      subhead: {
        type: DataTypes.STRING(255),
        allowNull: false,
      },
      qms_dept_id: {
        type: DataTypes.STRING(255),
        allowNull: false,
      },
      description: {
        type: DataTypes.STRING(255),
        allowNull: false,
      },
      price: {
        type: DataTypes.INTEGER(11),
        allowNull: false,
      },
      old_price: {
        type: DataTypes.INTEGER(11),
        allowNull: false,
      },
      sort_index: {
        type: DataTypes.INTEGER(11),
        allowNull: false,
      },
      account: {
        type: DataTypes.STRING(255),
        allowNull: true,
      },
      head: {
        type: DataTypes.STRING(255),
        allowNull: false,
      },
      unit: {
        type: DataTypes.STRING(255),
        allowNull: true,
      },
      range_from: {
        type: DataTypes.STRING(255),
        allowNull: true,
      },
      range_to: {
        type: DataTypes.STRING(255),
        allowNull: true,
      },
      other_range: {
        type: DataTypes.STRING(255),
        allowNull: true,
      },
      specimen: {
        type: DataTypes.STRING(255),
        allowNull: false,
      },
      commission_type: {
        type: DataTypes.STRING(255),
        allowNull: false,
      },
      percentage: {
        type: DataTypes.INTEGER(11),
        allowNull: false,
      },
      noOfLabels: {
        type: DataTypes.INTEGER(11),
        allowNull: false,
      },
      label_type: {
        type: DataTypes.STRING(255),
        allowNull: true,
      },
      report_type: {
        type: DataTypes.STRING(255),
        allowNull: true,
      },
      print_type: {
        type: DataTypes.STRING(255),
        allowNull: true,
      },
      collect_sample: {
        type: DataTypes.STRING(255),
        allowNull: true,
      },
      to_be_analyzed: {
        type: DataTypes.STRING(255),
        allowNull: true,
      },
      to_be_reported: {
        type: DataTypes.STRING(255),
        allowNull: true,
      },
      upload_doc: {
        type: DataTypes.STRING(255),
        allowNull: true,
      },
      facilityId: {
        type: DataTypes.STRING(255),
        allowNull: false,
      },
      created_by: {
        type: DataTypes.STRING(255),
        allowNull: false,
      },
      lab_head: {
        type: DataTypes.INTEGER(11),
        allowNull: false,
      },
      lab_code: {
        type: DataTypes.INTEGER(11),
        allowNull: false,
      },
      label_name: {
        type: DataTypes.STRING(255),
        allowNull: false,
      },
      selectable: {
        type: DataTypes.STRING(255),
        allowNull: false,
      },
      unit_code: {
        type: DataTypes.STRING(255),
        allowNull: false,
      },
      unit_name: {
        type: DataTypes.STRING(255),
        allowNull: false,
      },
      payable_head: {
        type: DataTypes.STRING(255),
        allowNull: false,
      },
      receivable_head: {
        type: DataTypes.STRING(255),
        allowNull: false,
      },
      account_name: {
        type: DataTypes.STRING(255),
        allowNull: false,
      },
      payable_head_name: {
        type: DataTypes.STRING(255),
        allowNull: false,
      },
      receivable_head_name: {
        type: DataTypes.STRING(255),
        allowNull: false,
      },
      department_code: {
        type: DataTypes.STRING(255),
        allowNull: false,
      },
      printable: {
        type: DataTypes.BOOLEAN,
        allowNull: false,
        defaultValue: true,
      },
      created_at: {
        type: DataTypes.DATE,
        allowNull: false,
      },
      updated_at: {
        type: DataTypes.STRING(255),
        allowNull: true,
      },
    },
    {
      sequelize,
      tableName: "lab_setup",
      timestamps: false,
      indexes: [
        {
          name: "PRIMARY",
          unique: true,
          using: "BTREE",
          fields: [{ name: "id" }],
        },
      ],
    }
  );
};
