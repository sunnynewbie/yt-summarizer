import http from 'http';
import app from './app.js';
import './config/env.js';
import { assertRequiredEnv, env } from './config/env.js';
import { connectDB } from './db.js';

const server = http.createServer(app);

async function startServer() {
  try {
    assertRequiredEnv();
    await connectDB();

    server.listen(env.port, () => {
      console.log(`Server is running on port ${env.port}`);
    });
  } catch (error) {
    console.error('Failed to start server:', error);
    process.exit(1);
  }
}

startServer();
