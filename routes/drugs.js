const passport = require('passport')

module.exports = (app) => {
  const drugs = require('../controller/drugs')
  // const config = require('../config/config')
  // const allowOnly = require('../services/routesHelper').allowOnly;

  app.post('/drugs/new', drugs.addDrug)
  app.post('/drugs/new/batch', drugs.batchAddDrug)
  app.get('/drugs/all/:facilityId', drugs.getAll)
  app.get('/drugs/list', drugs.getDrugList)
  app.post('/drugs/list/new', drugs.addNewDrug)
  app.put('/drugs/update/:drugId', drugs.updateDrug)
  // app.put('/drugs/update/:drugId/:quantity', drugs.updateDrugQttyById);
  app.delete('/drugs/delete/:drugId', drugs.deleteDrug)
  app.get('/drugs/price/:drugId/:facilityId', drugs.getDrugPriceById)
  app.get('/drugs/alert/expiry/:facilityId', drugs.getExpiryAlert)
  app.get('/drugs/expired/:facilityId', drugs.getExpiredDrugs)
  app.get('/drugs/alert/quantity/:facilityId', drugs.getQttyAlert)
  app.post('/drugs/dispense', drugs.dispenseDrugs)
  app.get('/drugs/purchase/all/:facilityId', drugs.getPurchaseRecords)
  app.get('/drugs/dispensary/all/:facilityId', drugs.getDispensaryRecords)
  app.get('/drugs/purchase/pending/:facilityId', drugs.getPendingPurchase)
  app.post('/drugs/pending/sales', drugs.newDrugSale)
  app.post('/drugs/purchase/new', drugs.newDrugPurchase)
  app.post('/drugs/move/purchases/dispensary', drugs.moveDrugsToDispensary)
  app.post('/drugs/supplier/purchases/new', drugs.newPurchaseFromSupplier)
  app.get(
    '/drugs/drug/by/code/:drugCode/:facilityId',
    drugs.getDrugInfoFromDrugCode,
  )
  app.get(
    '/drugs/dispensary/by/code/:drugCode/:facilityId',
    drugs.getDrugInfoFromDrugCodeForSale,
  )

  app.post('/drugs/sales/return-outward', drugs.returnDrug)

  // app.post('/drugs/add/drugs', drugs.batchAddDrugsWithoutPurchase)
  app.post('/drugs/supplier/new', drugs.addNewSupplier)
  app.get('/drugs/supplier/all/:facilityId', drugs.getAllSuppliers)
  app.put('/drugs/supplier/update/:supplierId', drugs.updateSupplier)
  app.delete('/drugs/supplier/delete/:supplierId', drugs.deleteSupplier)
  app.get('/drugs/unitOfIssue/:drugName/:facilityId', drugs.getUnitOfIssue)
  app.get('/drugs/sales/summary/:from/:to/:facilityId', drugs.getSaleSummary)
  app.get('/drugs/stock/total/:facilityId', drugs.getPharmTotalStock)
  app.get(
    '/drugs/totalsold/:from/:to/:facilityId',
    drugs.getDrugsSoldWithinRange,
  )
  app.get(
    '/summary/sales/staff/:from/:to/:facilityId',
    drugs.getBestSellingStaff,
  )
  app.get(
    '/drugs/summary/top/5/:facilityId',
    drugs.getTopFivePopularDrugsForToday,
  )
  app.get('/drugs/drugs/all', drugs.getAllDrugs)
  app.get('/drugs/search/:facilityId', drugs.drugSearch)
  app.get('/drugs/sales/search/:facilityId', drugs.drugSearchForSale)
  app.get('/drugs/sales/quantity/:facilityId', drugs.getDrugQtty)
  app.get('/drugs/factory/quantity/:facilityId', drugs.getFactoryDrugQtty)

  app.get('/drugs/analytics/profit/:facilityId', drugs.getMostProfitableItems)
  app.get('/drugs/analytics/fastselling/:facilityId', drugs.getFastSellingItems)
  app.get(
    '/drugs/dispensary/only/balance/:facilityId',
    drugs.getDispensaryBalanceWithoutStore,
  )
  app.get('/api/inventory/get/return/:code/:receiptNo', drugs.getReturnedDrugs)

  app.put(
    '/drugs/shelf/update/quantity-price',
    drugs.updateDrugDispensaryMarkupAndQuantity,
  )
  app.get('/walkin/instant/acct/:facilityId', drugs.getInstantPayment)
  // app.post('/drugs/purchase/delete/:drug/:cost_price/:expiry_date', drugs.deleteDrugsPurchase);
  app.post('/drugs/purchase/delete', drugs.deleteDrugsPurchase)

  app.get('/frequency-setup/get', drugs.getDrugFreqSetup)
  app.post('/frequency-setup/new', drugs.newDrugFreqSetup)
  app.post('/fluid-chart-setup/new', drugs.fluidChart) 
  app.post("/drug-list/new", drugs.drugList);
 
}
