# Backend for MyLikita Opensource Hospital Management Software

Backend App developed with Authentication, Access level control and password encryption
compatible with MyLikita Opensource Hospital Management Software

## Offline Support
App uses winser to install the backend app as a service.

Steps are as follows:
- Install winser using ```npm install winser```
- Add ```
    "scripts": {
    "install-windows-service": "winser -i",
    "uninstall-windows-service": "winser -r"
  }
``` to your script package.json file;
- Run 'npm run-script install-windows-service';
- You can access the app on http://127.0.0.1:4000/

checkout https://github.com/jfromaniello/winser for more details on winser.

