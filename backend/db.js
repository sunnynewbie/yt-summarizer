import { Sequelize } from "sequelize";
import initModels from "./models/init-models.js";
import { env } from "./config/env.js";
const sequelize = new Sequelize({
    dialect: "postgres",
    host: env.db.host,
    port: env.db.port,
    username: env.db.username,
    password: env.db.password,
    database: env.db.database,
    logging: env.db.logging,
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
        initModels(sequelize);
    } catch (error) {
        console.error('Unable to connect to the database:', error);
        throw error;
    }
}

export { connectDB, sequelize }
