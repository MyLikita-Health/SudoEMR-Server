const passport = require('passport')

module.exports = (app) => {
  const prescriptionrequests = require('../controller/prescriptionrequests')
  
  app.post('/prescriptions/dispense', prescriptionrequests.dispense)
  app.post('/prescriptions/requests/new', prescriptionrequests.newPrescription)
  // app.post(
  //   '/prescriptions/requests/batch-new',
  //   prescriptionrequests.newPrescriptionBatch,
  // )
  app.get(
    '/prescriptions/pending/:status',
    prescriptionrequests.getPendingPrescriptions,
  )
  app.get('/prescriptions/all', prescriptionrequests.getAll)
  app.get(
    '/prescriptions/all/:patient_id/:facilityId',
    prescriptionrequests.getPendingRequestPharm,
  )
  app.put('/prescriptions/update/dispense', prescriptionrequests.updateDispense)

  app.get(
    '/prescriptions/patient-prescribed',
    prescriptionrequests.getPatientPrescribedDrugs,
  )
  app.post(
    '/prescriptions/post-prescribed-drugs',
    prescriptionrequests.postPrescribedDrugs,
  )

  app.post('/drug-schedule/new', prescriptionrequests.newDrugSchedule)
  app.put(
    '/drug-schedule/update-status',
    prescriptionrequests.updateDrugSchedule,
  )
  app.get('/drug-schedule', prescriptionrequests.getDrugSchedule)
}
