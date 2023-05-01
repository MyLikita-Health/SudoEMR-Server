module.exports = (app) => {
  const pharmacy = require('../controller/pharmacy');
  // const config = require('../config/config')
  // const allowOnly = require('../services/routesHelper').allowOnly;

  app.post('/client/new', pharmacy.createClientAccount);
  app.post('/org-client/new', pharmacy.createOrgClient);
  app.post('/client/beneficiary/new', pharmacy.addClientBeneficiary);

  app.get('/client/nextId/:facId', pharmacy.getNextClientAccountNo);
  app.get(
    '/client/nextBeneficiaryId/:accountNo/:facId',
    pharmacy.getNextClientBeneficiaryNo,
  );
  app.get('/client/next-patient-id/:facId', pharmacy.getNextPatientNo)

  app.get('/drugs/bybatch/:facId', pharmacy.getDrugListByBatch)
  app.get('/returndrugs/new/:receipt/:facilityId', pharmacy.getReturnDrugs)

  app.get('/drugs/drugs_freq', pharmacy.getDrugFreq)

  // app.get('/services/print', services.printPage)
};