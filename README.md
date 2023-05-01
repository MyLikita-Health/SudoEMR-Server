# Hospital Management Software

Backend App developed with Authentication, Access level control and password encryption

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

## API Documentation

User route

```
POST:           '/auth/sign-up'
Purpose:        User Registration
Access Level:    Admin
Model:          User {
      firstname: DataTypes.STRING,
      lastname: DataTypes.STRING,
      privilege: DataTypes.INTEGER,
      role: DataTypes.STRING,
      accessTo: DataTypes.STRING,
      username: DataTypes.STRING,
      email: DataTypes.STRING,
      password: DataTypes.STRING,
      image: DataTypes.STRING,
    },
POST:          '/auth/login'
Purpose:        Users login
Access Level:   N/A

GET:           '/api/users'
Purpose:        Get list of users
Access Level:    Admin

GET:           '/api/users/:userId'
Purpose:        Get info about a user
Access Level:    User

PUT:           '/api/users/:userId'
Purpose:        Update user's details
Access Level:    User

DELETE:        '/api/users/:userId'
Purpose:        Delete user record
Access Level:    Admin
```

Appointments route

```
POST:           '/transactions/deposit'
Purpose:        Deposit
Access Level:   User
Model:          Appointment {
                    title: String!
                    complaint: String!
                    appointmentWith: String!
                    appointmentDate: Date!
                    UserId: String!
                } 

GET:           '/transactions/getReceiptNo'
Purpose:        Get list of all appointments
Access Level:    Admin

GET:           '/transactions/getNextTransactionID'
Purpose:        Get info about an appointment
Access Level:    User

PUT:           '/transactions/balance/:accountNo'
Purpose:        Update an appointment
Access Level:   User

DELETE:        '/transactions/all'
Purpose:        Delete an appointment
Access Level:    User
```

Posts route

```
POST:           '/api/posts/create'
Purpose:        Create a post
Access Level:    User
Model:          Post {
                    title: String,
                    body: String,
                    UserId: String,
                } 

GET:           '/api/posts'
Purpose:        Get list of all posts
Access Level:    N/A

GET:           '/api/posts/:postId'
Purpose:        Get a post by ID
Access Level:    User

PUT:           '/api/posts/:postId'
Purpose:        Update a post
Access Level:    User

DELETE:        '/api/posts/:postId'
Purpose:        Delete a post
Access Level:    Admin
```

Comment route

```
POST:           '/api/comments/create'
Purpose:        Create a comment
Access Level:    User
Model:          Comment {
                    title: String,
                    body: String!,
                    UserId: String!,
                    PostId: String!,
                } 

GET:           '/api/comments'
Purpose:        Get all comments
Access Level:    User

GET:           '/api/comments/:commentId'
Purpose:        Get a comment by ID
Access Level:    User

PUT:           '/api/comments/:commentId'
Purpose:        Edit comment
Access Level:    User

DELETE:        '/api/comments/:commentId'
Purpose:        Delete comment record
Access Level:    User
```