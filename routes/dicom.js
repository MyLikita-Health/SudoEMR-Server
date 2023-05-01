module.exports = (app) => {
  const dicom = require("../controller/dicom");
  // const config = require('../config/config')
  // const allowOnly = require('../services/routesHelper').allowOnly;

  app.post("/dicom/upload/single", dicom.dicomSingleUpload);
  app.post("/dicom/upload/multiple", dicom.dicomMultipleUpload);
};
