const express = require('express')
const passport = require('passport')
const port = process.env.PORT || 49495
// const port = process.env.PORT || 46475 // demo
const path = require('path')
const fs = require('fs')
const logger = require('morgan')
// const toobusy = require('node-toobusy');
// const winston = require('winston');
const cors = require('cors')
const cloudinary = require('cloudinary')

var cluster = require('cluster')

const bodyParser = require('body-parser')
let app = express()
app.use(require('express-status-monitor')());

const httpServer = require('http').createServer(app)

app.use(cors())


// Linking log folder and ensure directory exists
const logDirectory = path.join(__dirname, 'log')
fs.existsSync(logDirectory) || fs.mkdirSync(logDirectory)
fs.appendFile('./log/ServerData.log', '', function (err) {
  if (err) throw err
})

cloudinary.config({
  cloud_name: process.env.CLOUDINARY_CLOUD_NAME,
  api_key: process.env.CLOUDINARY_API_KEY,
  api_secret: process.env.CLOUDINARY_API_SECRET,
})
// const accessLogStream = fs.createWriteStream(path.join(__dirname, 'access.log'), { flags: 'a' })
const rfs = require('rotating-file-stream')
const accessLogStream = rfs.createStream('Server.log', {
  size: '10M', // rotate every 10 MegaBytes written
  interval: '1d', // rotate daily
  compress: 'gzip', // compress rotated files
  path: logDirectory, // folder path for log files
})

// Generating date and time for logger
logger.token('datetime', function displayTime() {
  return new Date().toString()
})

// defining mode of logging
app.use(logger('dev'))
app.use(
  logger(
    ':remote-addr :remote-user :datetime :req[header] :method :url HTTP/:http-version :status :res[content-length] :res[header] :response-time[digits] :referrer :user-agent',
    {
      stream: accessLogStream,
    },
  ),
)

// uncomment to redirect global console object to log file
// datalogger.logfile();

app.use(bodyParser.json())

// app.use(express.static(path.join(__dirname, 'public')))
app.use('/public', express.static(path.join(__dirname, 'public')))
app.use('/uploads', express.static(path.join(__dirname, 'uploads')))
// view engine setup
app.set('views', path.join(__dirname, 'views'))
app.set('view engine', 'ejs')

app.use(express.json())
app.use(express.urlencoded({ extended: false }))
// app.use(cookieParser());

// initialize passport here
app.use(passport.initialize())

require('./config/passport')(passport)

const models = require('./models')
app.get('/', (req, res) =>
  res.json({
    app_name: 'SudoEMR Opensource',
    app_version: '0.1',
    message: 'Welcome!',
    resource: 'https://sudoemr.com',
    email:"hello@sudoemr.com"
  }),
)


// force: true will drop the table if it already exits
// models.sequelize.sync({ force: true }).then(() => {
models.sequelize.sync().then(() => {
  console.log('Drop and Resync with {force: true}')
})

const swaggerUi = require('swagger-ui-express')
// const swaggerDocument = require('./swagger.json')
// app.use('/docs', swaggerUi.serve, swaggerUi.setup(swaggerDocument))
require('./routes/hospitals')(app)
require('./routes/users')(app)
require('./routes/patientrecords')(app)
require('./routes/diagnosis')(app)
require('./routes/prescriptionrequests')(app)
require('./routes/doc')(app)
require('./routes/pharmacy')(app)
require('./routes/record')(app)
require('./routes/dicom')(app)
require('./routes/drugs')(app)

// globally catching unhandled promise rejections
process.on('unhandledRejection', (reason, promise) => {
  console.error(
    'Unhandled Rejection at promise ' + promise + ' reason ',
    reason,
  )
  console.log('Server is still running...\n')
})

// globally catching unhandled exceptions
process.on('uncaughtException', (error) => {
  console.error('Uncaught Exception is thrown with ', error + '\n')
  process.exit()
})


// activate nodejs clusters depending on the number of cores on the server
if (cluster.isMaster) {
  console.log(`Master ${process.pid} is running`);
  var numWorkers = require('os').cpus().length
  console.log('Master cluster setting up ' + numWorkers + ' workers...')

  for (var i = 0; i < numWorkers; i++) {
    cluster.fork()
  }

  cluster.on('online', function (worker) {
    console.log('Worker ' + worker.process.pid + ' is online')
  })

  cluster.on('exit', function (worker, code, signal) {
    console.log(
      'Worker ' +
        worker.process.pid +
        ' died with code: ' +
        code +
        ', and signal: ' +
        signal,
    )
    console.log('Starting a new worker')
    cluster.fork()
  })
} else {
  //create a server
  const server = httpServer.listen(port, function () {
    const host = server.address().address
    const port = server.address().port
    console.log('host', host)
    console.log('port', port)

    console.log(`Worker ${process.pid} started on port ${port}`)
    // console.log(process.pid + ': App listening at http://%s:%s', host, port)
  })
}
