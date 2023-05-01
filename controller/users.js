const bcrypt = require('bcryptjs')
const jwt = require('jsonwebtoken')
const cuid = require('cuid')
const transport = require('../config/nodemailer')
// const passport = require('passport');

const db = require('../models')
const User = db.user
const Contact = db.contact
const Referral = db.referral
const Feedbacks = db.feedbacks

const sendMail = require('../services/emailApi').sendMail
const constants = require('../services/constants').constants

// load input validation
const validateRegisterForm = require('../validation/register')
const validateLoginForm = require('../validation/login')

// create user
exports.create = (req, res) => {
  const { errors, isValid } = validateRegisterForm(req.body)
  let {
    firstname,
    lastname,
    facilityId,
    role,
    privilege,
    accessTo,
    username,
    email,
    password,
    speciality,
    department,
    functionality,
    userId,
    image,
  } = req.body

  // check validations
  if (!isValid) {
    return res.status(400).json({ errors })
  }

  User.findAll({ where: { username } }).then((user) => {
    if (user.length && username !== '') {
      return res.status(400).json({ username: 'Username already exists!' })
    } else {
      let newUser = {
        firstname,
        lastname,
        facilityId,
        role,
        privilege,
        accessTo,
        username,
        speciality,
        email,
        password,
        department,
        functionality,
        createdBy: userId,
        image:
          'https://res.cloudinary.com/emaitee/image/upload/v1593618169/mylikita/profile_images/docAvater.png',
      }
      bcrypt.genSalt(10, (err, salt) => {
        bcrypt.hash(newUser.password, salt, (err, hash) => {
          if (err) throw err
          newUser.password = hash
          User.create(newUser)
            .then((user) => {
              res.json({ user })
            })
            .catch((err) => {
              res.status(500).json({ err })
            })
        })
      })
    }
  })
}

exports.login = (req, res) => {
  const { errors, isValid } = validateLoginForm(req.body)
  let error

  // check validation
  if (!isValid) {
    return res.status(400).json({ error: errors.toString() })
  }

  const { username, password } = req.body

  User.findAll({
    where: {
      username,
      status: 'approved',
    },
  })
    .then((user) => {
      //check for user
      if (!user.length) {
        error = 'User not found or not approved!'
        return res.status(404).json({ error })
      }

      let originalPassword = user[0].dataValues.password

      //check for password
      bcrypt
        .compare(password, originalPassword)
        .then((isMatch) => {
          if (isMatch) {
            // user matched
            console.log('matched!')
            const { id, username } = user[0].dataValues
            const payload = { id, username } //jwt payload
            // console.log(payload)

            jwt.sign(
              payload,
              'secret',
              {
                expiresIn: 3600,
              },
              (err, token) => {
                // let accessTo = [],
                let result = {
                  success: true,
                  token: 'Bearer ' + token,
                  user: {
                    id: user[0].dataValues.id,
                    username: user[0].dataValues.username,
                    firstname: user[0].dataValues.firstname,
                    lastname: user[0].dataValues.lastname,
                    email: user[0].dataValues.email,
                    phone: user[0].dataValues.phone,
                    image: user[0].dataValues.image,
                    role: user[0].dataValues.role,
                    accessTo: user[0].dataValues.accessTo.split(','),
                    facilityId: user[0].dataValues.facilityId,
                    prefix: user[0].dataValues.prefix,
                    speciality: user[0].dataValues.speciality,
                    userType: user[0].dataValues.userType,
                    serviceCost: user[0].dataValues.serviceCost,
                    referralId: user[0].dataValues.referralId,
                    address: user[0].dataValues.address,
                    available: user[0].dataValues.available,
                    availableDays: user[0].dataValues.availableDays,
                    availableFromTime: user[0].dataValues.availableFromTime,
                    availableToTime: user[0].dataValues.availableToTime,
                    department: user[0].dataValues.department,
                    signature_title: user[0].dataValues.signature_title,
                    functionality: user[0].dataValues.functionality.split(','),
                  },
                }
                res.json(result)
              },
            )
          } else {
            error = 'Password not correct'
            return res.status(400).json({ error })
          }
        })
        .catch((err) => console.log(err))
    })
    .catch((err) => {
      console.log(err)
      res.status(500).json({ error })
    })
}

exports.verifyUserToken2 = (req, res) => {
  const authToken = req.headers['authorization']
  const token = authToken.split(' ')[1]
  // console.log(token)
  jwt.verify(token, 'secret', (err, decoded) => {
    // console.log(decoded)
    if (err) {
      return res.json({
        success: false,
        message: 'Failed to authenticate token.',
        err,
      })
    }

    const { id } = decoded

    User.findAll({
      where: { id },
    })
      .then((user) => {
        if (!user.length) {
          return res.json({ success: false, message: 'user not found' })
        }

        // membershipApi(
        //   Object.assign({}, req.query, {
        //     query_type: 'user_societies',
        //     user_id: user[0].dataValues.id,
        //     role: 'Member',
        //   }),
        //   (data) => {
            res.json({
              success: true,
              user: user[0],
              // societies: data,
            })
        //   },
        // )
      })
      .catch((err) => {
        console.log(err)
        res
          .status(500)
          .json({ success: false, message: 'An error occured', err })
      })
  })
}

exports.verifyUserToken = (req, res) => {
  const authToken = req.headers['authorization']
  const token = authToken.split(' ')[1]
  // console.log(token)
  jwt.verify(token, 'secret', (err, decoded) => {
    if (err) {
      return res.json({
        success: false,
        msg: 'Failed to authenticate token.',
        err,
      })
    }

    const { username } = decoded

    User.findAll({ where: { username } })
      .then((user) => {
        if (!user.length) {
          return res.json({ msg: 'user not found' })
        }

        res.json({
          success: true,
          user: user[0],
        })
      })
      .catch((err) => {
        console.log(err)
        res.status(500).json({ err })
      })
  })
}


exports.profile = (req, res) => {
  const { userId } = req.params

  User.findAll({
    where: {
      id: userId,
    },
  })
    .then((user) => {
      res.json({ success: true, user })
    })
    .catch((err) => res.json({ err }))
}


exports.findAllUsers = (req, res) => {
  let { facilityId } = req.params
  db.sequelize
    .query('call get_users(:facilityId)', {
      replacements: { facilityId },
    })
    .then((results) => res.status(200).json({ results }))
    .catch((err) => res.status(500).json({ err }))
}

exports.findAllUsersById = (req, res) => {
  let { id, facilityId } = req.params
  db.sequelize
    .query('call get_all_user_byId(:id,:facilityId)', {
      replacements: { id, facilityId },
    })
    .then((results) => res.status(200).json({ results }))
    .catch((err) => res.status(500).json({ err }))
}

exports.findUsersRole = (req, res) => {
  let { facilityId } = req.params
  db.sequelize
    .query('call select_admin_role()', {
      replacements: { facilityId },
    })
    .then((results) => res.status(200).json({ results }))
    .catch((err) => res.status(500).json({ err }))
}

// fetch user by userId
exports.findById = (req, res) => {
  const id = req.params.userId

  User.findAll({ where: { id } })
    .then((user) => {
      console.log('nome')
      if (!user.length) {
        return res.json({ msg: 'user not found' })
      }
      res.json({ success: true, user })
    })
    .catch((err) => res.status(500).json({ err }))
}

// update a user's info
exports.update = (req, res) => {
  let { firstname, lastname, HospitalId, role, image } = req.body
  const id = req.params.userId

  User.update(
    {
      firstname,
      lastname,
      HospitalId,
      role,
      image,
    },
    { where: { id } },
  )
    .then((user) => res.status(200).json({ user }))
    .catch((err) => res.status(500).json({ err }))
}

exports.updateDoctor = (req, res) => {
  let {
    firstname,
    lastname,
    speciality,
    email,
    serviceCost,
    phone,
    address,
  } = req.body
  const id = req.params.userId
  // console.log(req.body)

  db.sequelize
    .query(
      `UPDATE users set firstname="${firstname}", lastname="${lastname}", speciality="${speciality}", email="${email}", phone="${phone}",address="${address}", serviceCost="${serviceCost}" where id="${id}"`,
    )
    .then((results) => res.json({ success: true, results: results[0] }))
    .catch((err) => {
      console.log(err)
      res.status(500).json({ success: false, err })
    })
}

// delete a user
exports.delete = (req, res) => {
  const id = req.params.userId

  User.destroy({ where: { id } })
    .then(() =>
      res.status(200).json({ msg: 'User has been deleted successfully!' }),
    )
    .catch((err) => res.status(500).json({ msg: 'Failed to delete!' }))
}

exports.getRoles = (req, res) => {
  const { facilityId } = req.params
  db.sequelize
    .query('call get_roles(:facilityId)', {
      replacements: { facilityId },
    })
    .then((results) => {
      const arr = []
      results.forEach((i) => arr.push(i.role))
      res.status(200).json({ results: arr })
    })
    .catch((err) => res.status(500).json({ err }))
}

exports.getDoctors = (req, res) => {
  const { facilityId } = req.params
  const { query_type = '' } = req.query
  db.sequelize
    .query('call get_doctors(:facilityId,:query_type)', {
      replacements: { facilityId, query_type },
    })
    .then((results) => {
      res.status(200).json({ results })
    })
    .catch((err) => res.status(500).json({ err }))
}

exports.createDoctor = (req, res) => {
  const {
    fullname,
    username,
    email,
    phone,
    password,
    speciality,
    licenceNo,
    prefix,
    referralId,
  } = req.body

  let [firstname, lastname, ...others] = fullname.split(' ')

  User.findAll({ where: { username } }).then((user) => {
    if (user.length && username !== '') {
      return res
        .status(400)
        .json({ success: false, username: 'Username already exists!' })
    } else {
      let newDoc = {
        firstname,
        lastname,
        facilityId: 'doctors',
        role: 'Doctor',
        privilege: 4,
        accessTo: 'Doctors',
        username,
        speciality,
        email,
        phone,
        password,
        image:
          'https://res.cloudinary.com/emaitee/image/upload/v1593618169/mylikita/profile_images/docAvater.png',
        licenceNo,
        prefix,
        createdBy: referralId,
      }

      bcrypt.genSalt(10, (err, salt) => {
        bcrypt.hash(newDoc.password, salt, (err, hash) => {
          if (err) throw err
          newDoc.password = hash
          User.create(newDoc)
            .then((user) => {
              res.json({ success: true, user })
              transport
                .sendMail({
                  from: '"mylikita.clinic" <hello@mylikita.clinic>',
                  to: user.email,
                  subject: 'Thank you for registering',
                  html: `
                    <center>
                      <img src='https://res.cloudinary.com/emaitee/image/upload/v1590845025/logo.png' height='30px' width='100px' />
                    </center>

                    <h1>Warm welcome,</h1>
                    <h4>Thank you for registering with mylikita.clinic</h4>

                    <p>
                      Our team are reviewing your account information you would be notified 
                      once your account is activated and ready to be used.
                    </p>
                    <br />

                    <p>Best regards.</p>
                    <p>MyLikita Dev. Team</p>
                
                    <center>
                      <p style='text-align:center'>Follow us on: </p>
                      <a href="https://www.facebook.com/mylikitaNG" target="_blank">
                        <img src='https://cdn3.iconfinder.com/data/icons/capsocial-round/500/facebook-512.png' height='25px' width='25px' />
                      </a>
                      <a href="https://www.twitter.com/mylikitaNG" target="_blank">
                        <img src='https://cdn4.iconfinder.com/data/icons/social-media-icons-the-circle-set/48/twitter_circle-512.png' height='25px' width='25px' />
                      </a>
                      <a href="https://www.instagram.com/mylikitaNG" target="_blank" >
                        <img src='https://i.pinimg.com/originals/a2/5f/4f/a25f4f58938bbe61357ebca42d23866f.png' height='25px' width='25px' />
                      </a>
                    </center>
                  `,
                })
                .then((info) => {
                  console.log('Message sent: %s', info.messageId)
                })
                .catch((err) => console.log('Error', err))
            })
            .catch((err) => {
              res.status(500).json({ success: false, err })
            })
        })
      })
    }
  })
}

exports.checkUsername = (req, res) => {
  const { username } = req.body

  User.findAll({ where: { username } })
    .then((user) => {
      if (user.length && username !== '') {
        return res
          .status(400)
          .json({ success: false, username: 'Username already exists!' })
      } else {
        return res.json({ success: true, username: 'Username is available' })
      }
    })
    .catch((err) => {
      res.status(500).json({ err })
    })
}

exports.checkEmail = (req, res) => {
  const { email } = req.body

  User.findAll({ where: { email } })
    .then((user) => {
      if (user.length && email !== '') {
        return res
          .status(400)
          .json({ success: false, email: 'Email is taken!' })
      } else {
        return res.json({ success: true, email: 'Email is available' })
      }
    })
    .catch((err) => {
      res.status(500).json({ err })
    })
}

exports.checkPrefix = (req, res) => {
  const { prefix } = req.body

  User.findAll({ where: { prefix } })
    .then((user) => {
      if (user.length && prefix !== '') {
        return res
          .status(400)
          .json({ success: false, prefix: 'Prefix is taken!' })
      } else {
        return res.json({ success: true, prefix: 'Prefix is available' })
      }
    })
    .catch((err) => {
      res.status(500).json({ err })
    })
}

exports.referral = (req, res) => {
  const { referer, refereeContact } = req.body
  const newReferral = {
    referer: referer,
    referee: '',
    refereeContact: refereeContact,
  }

  Referral.create(newReferral)
    .then((results) => res.json({ success: true, results }))
    .catch((err) => {
      res.status(500).json({ success: false, err })
      console.log(err)
    })
}

exports.getDoctorsSpecilities = (req, res) => {
  db.sequelize
    .query(
      "SELECT DISTINCT speciality FROM users where speciality!='' AND status='approved'",
    )
    .then((results) => {
      res.json({ success: true, results: results[0] })
    })
    .catch((err) => {
      res.status(500).json({ success: false, err })
    })
}

exports.getDoctorsList = (req, res) => {
  db.sequelize
    .query(
      `SELECT * FROM users where role in ('doctor','speciality') 
            AND status='approved' 
            ORDER BY createdAt`,
    )
    .then((results) => {
      res.json({ success: true, results: results[0] })
    })
    .catch((err) => {
      res.status(500).json({ success: false, err })
    })
}

exports.getDoctorsForAdmin = (req, res) => {
  db.sequelize
    .query(
      "SELECT id, firstname, lastname, speciality, licenceNo, userType, status, createdAt from users where role='doctor' ORDER BY createdAt DESC",
    )
    .then((results) => {
      res.json({ success: true, results: results[0] })
    })
    .catch((err) => {
      res.status(500).json({ success: false, err })
    })
}

exports.getUnapprovedUsers = (req, res) => {
  db.sequelize
    .query(
      `SELECT 
        a.id AS id, 
        a.firstname AS firstname, 
        a.lastname AS lastname, 
        a.role AS role, 
        IFNULL(a.userType, "") AS userType, 
        a.status AS status, 
        a.createdAt AS createdAt,
        b.name AS facility,
        b.type AS facilityType
      FROM users AS a 
      JOIN hospitals AS b 
      ON a.facilityId = b.id
      WHERE a.status IN ('pending', 'suspended')  
      ORDER BY a.createdAt DESC`,
    )
    .then((results) => {
      res.json({ success: true, results: results[0] })
    })
    .catch((err) => {
      res.status(500).json({ success: false, err })
    })
}

exports.submitContactForm = (req, res) => {
  const { firstname, lastname, message, email } = req.body

  let contactform = {
    firstname,
    lastname,
    message,
    email,
  }

  Contact.create(contactform)
    .then((results) => {
      res.json({ success: true, results })
    })
    .catch((err) => {
      res.status(500).json({ success: false, err })
    })
}

exports.generateReferralLink = (req, res) => {
  const { id } = req.params
  let referralId = cuid()

  User.update(
    {
      userType: 'LEAD',
      referralId,
    },
    { where: { id } },
  )
    .then((results) => res.json({ success: true, results }))
    .catch((err) => res.status(500).json({ success: false, err }))
}

exports.approveUser = (req, res) => {
  const { id } = req.params

  User.update({ status: 'approved ' }, { where: { id } })
    .then((results) => {
      User.findAll({ where: { id } }).then((user) => {
        const u = user[0].dataValues
        // sendMail(u.id, constants.WELCOME_MAIL);
        transport
          .sendMail({
            from: '"MyLikita" <hello@mylikita.clinic>',
            to: u.email,
            subject: '[MyLikita] Account Approval',
            html: `
          <center>
            <img src='https://res.cloudinary.com/emaitee/image/upload/v1590845025/logo.png' height='30px' width='100px' />
          </center>

          <h4>Dear ${u.firstname},</h4>

          <p>
            Thank you for registering on our platform, we are happy to inform you that your account is
            now active and you proceed to login <a href="https://app.mylikita.clinic/auth" target="_blank">here</a>
            with the credentials with which you registered.
          </p>
          <p>
            We welcome you onboard.
          </p>
          <p>
            Feel free to reach out to us for any complaints or questions by replying to this email or
            sending us an email directly on <a href="mailto:hello@mylikita.clinic">this email address</a>.
          </p>
          <br />

          <p>Best regards.</p>
          <p>MyLikita Dev. Team</p>

          <center>
            <p style='text-align:center'>Follow us on: </p>
            <a href="https://www.facebook.com/mylikitaNG" target="_blank">
              <img src='https://cdn3.iconfinder.com/data/icons/capsocial-round/500/facebook-512.png' height='25px' width='25px' />
            </a>
            <a href="https://www.twitter.com/mylikitaNG" target="_blank">
              <img src='https://cdn4.iconfinder.com/data/icons/social-media-icons-the-circle-set/48/twitter_circle-512.png' height='25px' width='25px' />
            </a>
            <a href="https://www.instagram.com/mylikitaNG" target="_blank" >
              <img src='https://i.pinimg.com/originals/a2/5f/4f/a25f4f58938bbe61357ebca42d23866f.png' height='25px' width='25px' />
            </a>
          </center>
          `,
          })
          .then((info) => {
            console.log('Message sent: %s', info.messageId)
            res.json({ success: true, results })
          })
          .catch((err) => console.log('Error', err))
      })
    })
    .catch((err) => res.status(500).json({ success: false, err }))
}

exports.suspendUser = (req, res) => {
  const { id } = req.params
  User.update({ status: 'suspended ' }, { where: { id } })
    .then((results) => {
      res.json({ success: true, results })
    })
    .catch((err) => {
      res.status(500).json({ success: false, err })
      console.log(err)
    })
}

exports.reportIssues = (req, res) => {
  const { userId, message } = req.body

  Feedbacks.create({ userId, message })
    .then((results) => {
      res.json({ success: true, results })
    })
    .catch((err) => {
      res.status(500).json({ success: false, err })
      console.log(err)
    })
}

exports.updateDocAvailability = (req, res) => {
  const id = req.params.docId
  const { availableDays, availableFromTime, availableToTime } = req.body

  User.update(
    {
      availableDays,
      availableFromTime,
      availableToTime,
    },
    { where: { id } },
  )
    .then((results) => {
      res.json({ success: true, results })
    })
    .catch((err) => {
      res.status(500).json({ success: false, err })
      console.log(err)
    })
}

exports.countDoc = (req, res) => {
  db.sequelize
    .query(
      "SELECT count(*) AS doctors FROM users where role='Doctor' and status='approved';",
    )
    .then((results) =>
      res.json({ success: true, doctors: results[0][0].doctors }),
    )
    .catch((err) => {
      res.status(500).json({ success: false, err })
      console.log(err)
    })
}

exports.testMail = (req, res) => {
  const { id } = req.params

  sendMail(id, constants.WELCOME_MAIL)
}

exports.testApprovalMail = (req, res) => {
  const { id } = req.params

  sendMail(id, constants.ACCOUNT_APPROVAL)
}

exports.uploadProfileImage = (req, res) => {
  const { id } = req.body

  User.update({ image: req.file.path }, { where: { id } })
    .then(() => {
      res.json({ success: true })
    })
    .catch((error) => {
      console.log('Error', error)
      res.status(500).json({ success: false, error })
    })
}

exports.adminResetUser = (req, res) => {
  let { userId, newPassword } = req.body

  bcrypt.genSalt(10, (err, salt) => {
    bcrypt.hash(newPassword, salt, (err, hash) => {
      if (err) throw err
      newPassword = hash
      User.update({ password: newPassword }, { where: { id: userId } })
        .then((user) => {
          res.json({
            success: true,
            message: 'Password Reset Successful',
            user,
          })
        })
        .catch((err) => {
          res.status(500).json({ err })
        })
    })
  })
}

exports.changeUserPassword = (req, res) => {
  const { id, oldPassword, newPassword } = req.body

  User.findAll({
    where: {
      id,
    },
  })
    .then((user) => {
      //check for user
      if (!user.length) {
        errors.id = 'User not found!'
        return res.status(404).json(errors)
      }

      let originalPassword = user[0].dataValues.password

      //check for password
      bcrypt
        .compare(oldPassword, originalPassword)
        .then((isMatch) => {
          if (isMatch) {
            const { id } = user[0].dataValues

            bcrypt.genSalt(10, (err, salt) => {
              bcrypt.hash(newPassword, salt, (err, hash) => {
                if (err) throw err
                // lehashedPassword = hash;
                User.update({ password: hash }, { where: { id } })
                  .then((user) => {
                    res.json({ success: true, user })
                  })
                  .catch((error) => {
                    res.status(500).json({ success: false, error })
                  })
              })
            })
          } else {
            errors.password = 'Old Password not correct'
            return res.status(404).json(errors)
          }
        })
        .catch((error) => console.log(error))
    })
    .catch((error) => res.status(500).json({ success: false, error }))
}

exports.deleteUser = (req, res) => {
  const {
    params: { id, facilityId },
  } = req
  db.sequelize
    .query('call delete_user(:id, :facilityId)', {
      replacements: { facilityId, id },
    })
    .then((results) => res.json({ success: true, results }))
    .catch((err) => res.status(500).json({ err }))
}

exports.updateUsers = (req, res) => {
  const {
    accessTo,
    functionality,
    id,
    facilityId,
    firstname,
    lastname,
    role,
    department,
  } = req.body
  db.sequelize
    .query(
      'call update_user(:accessTo,:functionality,:id,:facilityId,:firstname,:lastname,:role,:department);',
      {
        replacements: {
          accessTo,
          functionality,
          id,
          facilityId,
          firstname,
          lastname,
          role,
          department,
        },
      },
    )
    .then((results) => res.json({ results }))
    .catch((err) => {
      console.log(err)
      res.status(500).json({ err })
    })
}

exports.getUnits = (req, res) => {
  const {
    department = '',
    facilityId = '',
    query_type = '',
    userId = '',
  } = req.query

  db.sequelize
    .query('CALL department(:query_type, :facilityId, :department, :userId)', {
      replacements: {
        department,
        facilityId,
        query_type,
        userId,
      },
    })
    .then((results) => {
      res.json({ success: true, results })
    })
    .catch((err) => {
      console.log(err)
      res.status(500).json({ success: false, err })
    })
}

exports.resetUserPassword = (req, res) => {
  const { id, newPassword } = req.body

  User.findAll({
    where: {
      id,
    },
  })
    .then((user) => {
      //check for user
      if (!user.length) {
        errors.id = 'User not found!'
        return res.status(404).json(errors)
      }
      const { id } = user[0].dataValues

      bcrypt.genSalt(10, (err, salt) => {
        bcrypt.hash(newPassword, salt, (err, hash) => {
          if (err) throw err
          // lehashedPassword = hash;
          User.update({ password: hash }, { where: { id } })
            .then((user) => {
              res.json({ success: true, user })
            })
            .catch((error) => {
              res.status(500).json({ success: false, error })
            })
        })
      })
    })
    .catch((error) => res.status(500).json({ success: false, error }))
}
