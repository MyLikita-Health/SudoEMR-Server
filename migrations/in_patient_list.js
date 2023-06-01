module.exports = {
    up: async (queryInterface) => {
      await queryInterface.sequelize.query(`CREATE  VIEW in_patient_list  AS SELECT b.sort_index AS sort_index, a.bed_id AS bed_id, a.allocation_id AS allocation_id, a.allocation_status AS allocation_status, a.allocated AS allocated, a.allocated_by AS allocated_by, a.patient_name AS patient_name, a.patient_id AS patient_id, a.accountNo AS accountNo, b.name AS name, b.class_type AS class_type, b.account AS account, b.price AS price, a.facilityId AS facilityId FROM (patient_bed a join bedlist b on(a.bed_id = b.id)) WHERE a.facilityId = b.facilityId;`);
    },
    down: async (queryInterface) => {
        await queryInterface.sequelize.query(`DROP VIEW IF EXISTS in_patient_list;`)
    }
  };