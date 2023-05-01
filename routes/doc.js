module.exports = (app) => {
  const doc = require("../controller/doc");
  // const config = require('../config/config')
  // const allowOnly = require('../services/routesHelper').allowOnly;

  app.post("/doc/patients/new", doc.addPatient);

  app.get("/navigation/get-homepage", doc.getHomePage);
  app.get("/all/consultation/new", doc.getConsultation);
  app.post("/all/appointment/new", doc.appointment);
  app.post("/all/medical-report/new", doc.medical_report);
};
