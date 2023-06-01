module.exports = {
    up: async (queryInterface) => {
      await queryInterface.sequelize.query(`CREATE  VIEW patient_bed  AS SELECT a.id AS allocation_id, a.bed_id AS bed_id, a.allocated AS allocated, a.allocated_by AS allocated_by, a.allocation_status AS allocation_status,"surname || ' ' || firstname" AS patient_name, a.patient_id AS patient_id, b.accountNo AS accountNo, a.facilityId AS facilityId FROM (bed_allocation a join patientrecords b on(a.patient_id = b.id)) WHERE a.facilityId = b.facilityId AND a.ended is null ;  `
      );
    },
    down: async (queryInterface) => {
        await queryInterface.sequelize.query(`DROP VIEW IF EXISTS patient_bed;`)
    }
};