const { localUploadNew } = require('../config/multer')

module.exports = (app) => {
  const record = require('../controller/record')
  app.post(
    `/save/record/info`,
    localUploadNew.single('file'),
    record.saveRecordInfo,
  )
  app.get('/get/patient/:facId', record.getPatients)

  app.post('/beds/new', record.newBed)
  app.get('/beds', record.getBeds)
  app.post('/beds/allocation', record.bedAllocation)

  // nurses
  app.get('/record/in-patients', record.getInPatients)

  app.post('/vitals/new', record.newVitalSigns)
  app.get('/vitals/query', record.queryVitals)

  app.post('/nursing-reports/new', record.newNursingReport)
  app.get('/nursing-reports', record.getNursingReports)
  app.post('/upload-files', localUploadNew.array('files'), record.uploadFiles)
  app.get('/get/image-files-1', record.getUploadFiles)

  app.post('/dicom/save-dicom-files', record.saveDicomFilesData)
  app.get('/dicom-list', record.getAllDicomFiles)
  app.get('/dicom/patient-dicom-list', record.getDicomFilesForPatient)
  app.get('/record/get-patient-account', record.getPatientAccount)
  app.get('/record/patient-pending-drugs', record.getPatientPendingDrugs)
  app.post('/nursing-notes-setup/new', record.patient_nursing_notes)
}
