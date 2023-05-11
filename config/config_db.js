require("dotenv").config();
module.exports = {
  development: {
    username: 'root' || process.env.USERNAME,
    password: process.env.PASSWORD,
    database: process.env.DATABASE,
    host: "localhost",
    dialect: "mysql",
    use_env_variable: false,
    pool: {
      max: 5,
      min: 0,
      acquire: 30000,
      idle: 10000,
    },
  },
  production_: {
    username: "",
    password: "",
    database: "",
    host: "",
    dialect: "",
  },
};
