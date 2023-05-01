const nodemailer = require('nodemailer')

const transport = nodemailer.createTransport({
    host: "[host]",
    port: 587,
    secure: false,
    auth: {
        user: "[user]",
        pass: "[password]"
    },
    tls: {
        rejectUnauthorized: false
    }
})

module.exports = transport