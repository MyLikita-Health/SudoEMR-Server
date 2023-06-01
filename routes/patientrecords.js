const passport = require("passport");
const { localUploadNew } = require("../config/multer");

module.exports = (app) => {
  const patientrecords = require("../controller/patientrecords");
  const record = require("../controller/record");
  // const config = require('../config/config')
  // const allowOnly = require('../services/routesHelper').allowOnly;

  app.post("/patientrecords/patient/new", patientrecords.getPatientList);
  app.get(
    "/patientrecords/patientlist/:facilityId",
    patientrecords.getPatientList
  );
  app.get(
    "/patientrecords/unassignedPatientlist/:facilityId",
    patientrecords.getUnassignedPatients
  );
  app.get(
    "/patientrecords/patientClarking/:facilityId",
    patientrecords.patientClarking
  );
  app.get(
    "/accounts/approved/list/:facilityId",
    patientrecords.getApprovedAccounts
  );
  app.get('/client/next-patient-id/:facId', patientrecords.getNextPatientNo)
    app.get(
    '/client/nextBeneficiaryId/:accountNo/:facId',
    patientrecords.getNextClientBeneficiaryNo,
  );
  app.get(
    "/patientrecords/fetchUserById/:id/:facilityId",
    patientrecords.getUsersById
  );
  app.get(
    "/patientrecords/patient/:id/:facilityId",
    patientrecords.getPatientById
  );

  app.post(
    "/patientrecords/update/patient",
    localUploadNew.single("file"),
    patientrecords.updatePatientInformation
  );

  app.get("/patientrecords/doctor/:doctor/:facilityId", patientrecords.doctor);
  app.get("/patientrecords/getId/:facilityId", patientrecords.getId);
  app.get("/patientrecords/getAccount/:facilityId", patientrecords.getAccount);
  app.post("/patientrecords/new", patientrecords.newRecord);
  app.post("/patientrecords/upload", patientrecords.upload);
  app.put("/patientrecords/edit", patientrecords.edit);
  app.post("/patientrecords/delete", patientrecords.delete);
  app.post("/patientrecords/assign", patientrecords.assign);
  app.get("/patientrecords/assign", patientrecords.assignQuery);
  app.get(
    "/patientrecords/patientAssignedToday/:facilityId",
    patientrecords.patientAssignedToday
  );
  app.get('/lab/patients/:condition/:type/:facilityId', record.getInPatients)
  app.get('/lab/service/all/:facilityId', patientrecords.getAllLabServices);
  app.get('/lab/get-children/:head/:facilityId', patientrecords.getLabChildren);
  app.get(
    "/lab/patient/full-info/:patientId/:facilityId",
    patientrecords.getPatientInfo
  );
  app.get(
    "/lab/patient/info/:patientId/:facilityId",
    patientrecords.getPatientFullInfo
  );
  app.get(
    "/patientrecords/fetchByDoctor/:facilityId",
    patientrecords.fetchByDoctor
  );
  app.get("/patientrecords/getAll/:facilityId", patientrecords.getAll);
  app.get("/patientrecords/getIds/:facilityId", patientrecords.getIds);
  app.get(
    "/patientrecords/getBeneficiaryNo/:accountNo/:facilityId",
    patientrecords.getBeneficiaryNo
  );
  // app.post("/patientrecords/operation", patientrecords.operationNote);
  app.get("/client/get-list", patientrecords.getClientAccNos);
  app.post("/surgical-note/new", patientrecords.surgicalNote);
};
