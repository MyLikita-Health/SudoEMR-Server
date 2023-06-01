const passport = require('passport')

module.exports = (app) => {
  const hospital = require('../controller/hospitals')
  const config = require('../config/config')
  // const allowOnly = require('./services/routesHelper').allowOnly;

  // create a hospital
  app.post('/hospitals/create', hospital.create)

  app.post('/hospitals/beds/new', hospital.createBedSpace)
  app.get('/hospitals/beds/:facilityId', hospital.getAllBedsForFacility)
  app.get('/facility/info/:facilityId', hospital.getFacilityInfo)
  app.get('/facility/count', hospital.countFacilities)
  app.put('/hospital/near-update/:id', hospital.nearUpdate)

  //fetch all hospitals
  app.get('/hospitals', hospital.findAll)

  // get a hospital by id
  app.get('/hospitals/:hospitalId', hospital.findById)

  // update hospital
  app.put('/hospitals/:hospitalId', hospital.update)

  // delete hospital
  app.delete('/hospitals/:hospitalId', hospital.delete)
}
