module.exports = {
  up: async (queryInterface) => {
    await queryInterface.sequelize.query(
      `CREATE  VIEW drug_schedule_view  AS SELECT a.drug AS drug, a.dosage AS dosage, a.patient_id AS patient_id, a.created_at AS created_at, b.id AS id, a.id AS prescription_id, a.prescribed_by AS prescribed_by, a.duration AS duration, a.period AS period, a.frequency AS frequency, a.route AS route, b.time_stamp AS time_stamp, b.administered_by AS administered_by, b.served_by AS served_by, b.reason AS reason, b.status AS status, a.facilityId AS facilityId FROM (dispensary a join drug_schedule b on(a.id = b.prescription_id))  ;`
    );
  },
  down: async (queryInterface) => {
    await queryInterface.sequelize.query(
      `DROP VIEW IF EXISTS drug_schedule_view;`
    );
  },
};
