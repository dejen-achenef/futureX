require("dotenv").config();

module.exports = {
  development: {
    username: process.env.MYSQL_USERNAME || "root",
    password: process.env.MYSQL_PASSWORD || "",
    database: process.env.MYSQL_DATABASE || "user_video_db",
    host: process.env.MYSQL_HOST || "localhost",
    port: 3306,
    dialect: "mysql",
    logging: console.log,
  },
  test: {
    username: process.env.MYSQL_USER || "root",
    password: process.env.MYSQL_PASSWORD || "",
    database: process.env.MYSQL_DATABASE + "_test" || "user_video_db_test",
    host: process.env.MYSQL_HOST || "localhost",
    port: 3306,
    dialect: "mysql",
    logging: false,
  },
  production: {
    username: process.env.MYSQL_USERNAME,
    password: process.env.MYSQL_PASSWORD,
    database: process.env.MYSQL_DATABASE,
    host: process.env.MYSQL_HOST,
    port: process.env.DB_PORT || 3306,
    dialect: "mysql",
    logging: false,
  },
};
