module.exports = {
    up: async (queryInterface) => {
      await queryInterface.sequelize.query(`CREATE  VIEW medication_report  AS SELECT a.patient_id AS patient_id, a.drug AS drug, a.dosage AS dosage, a.route AS route, a.time_stamp AS time_stamp, a.status AS status, a.served_by AS served_by, "surname || ' ' || firstname" AS nurse_name, a.reason AS reason FROM (drug_schedule_view a join users b on(a.served_by = b.username)) WHERE a.status in ('Served','Not Served')  ;
      `);
    },
    down: async (queryInterface) => {
        await queryInterface.sequelize.query(`DROP VIEW IF EXISTS medication_report;`)
    }
  };