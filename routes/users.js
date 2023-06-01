const { localUpload } = require('../config/multer')

module.exports = (app) => {
  const users = require('../controller/users')

  // create a new user
  app.post('/auth/sign-up', users.create)

  // user login
  app.post('/auth/login', users.login)

  app.get('/auth/verify-token', users.verifyUserToken2)

  //retrieve all users
  app.get('/users/:facilityId', users.findAllUsers)
  app.get('/users/getById/:id/:facilityId', users.findAllUsersById)
  app.get('/users/roles/:facilityId', users.getRoles)

  app.get('/doctors/:facilityId', users.getDoctors)

  app.post('/users/doctors/create', users.createDoctor)

  app.put('/users/doctors/profile/:userId', users.updateDoctor)

  app.get('/users/profile/:userId', users.profile)

  app.post('/users/check/username', users.checkUsername)

  app.post('/users/check/email', users.checkEmail)

  app.post('/users/check/prefix', users.checkPrefix)

  app.post('/referrals/doctor/new', users.referral)

  app.get('/doctors/speciality/list', users.getDoctorsSpecilities)

  app.get('/doctors/all/list', users.getDoctorsList)

  app.get('/doctors/admin/all', users.getDoctorsForAdmin)
  app.get('/admin/unapprovedUsers', users.getUnapprovedUsers)

  app.get('/admin/manageadminrole', users.findUsersRole)

  app.get('/doctors/count', users.countDoc)

  app.post('/guests/contactform', users.submitContactForm)

  app.put('/users/lead/referrallink/:id', users.generateReferralLink)

  app.put('/users/approve/:id', users.approveUser)

  app.put('/users/doctor/availability/:docId', users.updateDocAvailability)
  app.post('/admin/reset-user-pass', users.adminResetUser)
  app.post('/api/users/changepassword', users.changeUserPassword)

  app.post('/api/users/resetpassword', users.resetUserPassword)

  app.put('/users/suspend/:id', users.suspendUser)
  app.post('/users/reportissues', users.reportIssues)
  app.post('/users/testmail/:id', users.testMail)
  app.post('/users/testmail/approval/:id', users.testApprovalMail)
  app.delete('/users/delete/:id/:facilityId', users.deleteUser)
  app.put('/users/access/update', users.updateUsers)

  app.post(
    '/users/profile/image',
    localUpload.single('image'),
    users.uploadProfileImage,
  )

  // retrieve user by id
  app.get('/users/:userId', users.findById)

  // update a user with id
  app.put('/users/:userId', users.update)

  // delete a user
  app.delete('/users/:userId', users.delete)
}
