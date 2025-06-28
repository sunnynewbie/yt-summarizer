import { Sequelize } from "sequelize";
import initModels from "./models/init-models.js";
const sequelize = new Sequelize({
    dialect: "postgres",
    host: "localhost",
    port: 5432,
    username: "postgres",
    password: "root",
    database: "yt-summarize",
    logging: true,
    pool: {
        max: 5,
        min: 0,
        acquire: 30000,
        idle: 10000
    },
    define: {
        timestamps: false
    },
});
async function connectDB() {
    try {
        await sequelize.authenticate();
        console.log('Connection has been established successfully.');
        initModels(sequelize)
    } catch (error) {
        console.error('Unable to connect to the database:', error);
    }
}

export { connectDB, sequelize }