var Service = require('node-windows').Service

// Create a new service obj
var svc = new Service({
  name: 'MyLikita',
  description: 'Hospital Management Software',
  script: 'C:hmsserverapp.js',
})

svc.on('install', function () {
  svc.start()
})

svc.install()
