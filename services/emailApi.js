// const nodemailer = require('nodemailer');
const Email = require('email-templates');
const path = require('path');
const db = require('../models');
const User = db.user;
const constants = require('./constants').constants;

const transport = require('../config/nodemailer');

const senderAddress = '[sender]@mylikita.clinic';
const senderName = 'MyLikita'

// const welcomeMailDir = path.join(__dirname, '../templates', 'welcome');
// // console.log(welcomeMailDir)
// const welcomeMail = new EmailTemplate(welcomeMailDir);

const email = new Email({
  message: {
    from: senderAddress,
  },
  // send: true,
  transport,
  views: {
    options: {
      extension: 'ejs', // <---- HERE
    },
  },
});

function sendMail(userId, type) {
  User.findAll({ where: { id: userId } })
    .then((user) => {
      const userObj = user[0];
      console.log(type);
      switch (type) {
        case constants.WELCOME_MAIL: {
          email
            .send({
              template: 'welcome',
              message: {
                to: userObj.email,
              },
              locals: {
                data: {
                  firstname: userObj.firstname,
                  lastname: userObj.lastname,
                  userType: userObj.userType,
                },
              },
            })
            .then((info) => {
              // console.log('result in emailApi', info);
              console.log('Message sent: %s', info.messageId);
            })
            .catch((error) => {
              console.log('error in emailApi', error);
            });
        }
        case constants.ACCOUNT_APPROVAL: {
          email
            .send({
              template: 'accountApproval',
              message: { to: userObj.email },
              locals: {
                data: {
                  firstname: userObj.firstname,
                  lastname: userObj.lastname,
                },
              },
            })
            .then((info) => {
              // console.log('result in emailApi', info);
              console.log('Message sent: %s', info.messageId);
            })
            .catch((error) => {
              console.log('error in emailApi', error);
            });
        }
        case constants.WELCOME: {
          email
            .send({
              template: 'Welcome',
              message: {
                to: userObj.email,
              },
              locals: {
                data: {
                  firstname: userObj.firstname,
                  lastname: userObj.lastname,
                  userType: userObj.userType,
                },
              },
            })
            .then((info) => {
              // console.log('result in emailApi', info);
              console.log('Message sent: %s', info.messageId);
            })
            .catch((error) => {
              console.log('error in emailApi', error);
            });
        }
        default:
          return null;
      }
    })
    .catch((err) => {
      console.log(err);
    });
}



exports.sendMail = sendMail;

exports.newMail = (recipient, content) => {
  transport
    .sendMail({
      from:  `"${senderName}" <${senderAddress}>`,
      to: recipient,
      subject: 'Warm welcome',
      html: content,
    })
    .then((info) => {
      console.log('Message sent: %s', info.messageId);
    })
    .catch((err) => console.log('Error', err));
};
