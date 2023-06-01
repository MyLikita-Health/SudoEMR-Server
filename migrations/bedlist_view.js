module.exports = {
    up: async (queryInterface) => {
      await queryInterface.sequelize.query(` CREATE  VIEW bedlist_view  AS SELECT bedlist.id AS id, bedlist.sort_index AS sort_index, bedlist.class_type AS class_type, bedlist.price AS price, bedlist.name AS name, bedlist.no_of_beds AS no_of_beds, ifnull((select count(bed_allocation.bed_id) from bed_allocation where bed_allocation.bed_id = bedlist.id and bed_allocation.facilityId = bedlist.facilityId and bed_allocation.ended is null group by bed_allocation.bed_id),0) AS occupied, bedlist.facilityId AS facilityId FROM bedlist  ;`);
    },
    down: async (queryInterface) => {
        await queryInterface.sequelize.query(`DROP VIEW IF EXISTS bedlist_view;`)
    }
  };