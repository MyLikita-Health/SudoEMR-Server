const passport = require('passport');

module.exports = app => {
  const diagnosis = require('../controller/diagnosis');
  // const config = require('../config/config')
  // const allowOnly = require('../services/routesHelper').allowOnly;

  app.post('/diagnosis/new', diagnosis.newDiagnosis);
  app.post('/consultation/new', diagnosis.consultationRecord);
  app.get('/consultation/query', diagnosis._consultationRecord);
  app.get('/diagnosis/all/:patientId/:facilityId', diagnosis.getDiagnosisByPatientID)
  app.post('/diagnosis/inventory/new', diagnosis.saveNewInventory);
  app.get('/diagnosis/inventory/list/:facilityId', diagnosis.getLabInventoryAll);
  app.post('/diagnosis/new-preview/list', diagnosis.getLabPreview);

  app.get('/diagnosis/ordered-lab', diagnosis.getOrderedLabs)
  app.get('/diagnosis/get-pending-lab-tx', diagnosis.getPendingLabTxn)
  app.post('/diagnosis/update-pending-lab', diagnosis.updateLabRequest)


};
