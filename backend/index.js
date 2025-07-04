import http from 'http';
import app from './app.js';
import env from 'dotenv';
import { connectDB } from './db.js';
env.config('../.env');

const server = http.createServer(app);


server.listen(5000, async () => {
  await connectDB();

  console.log('Server is running on port 5000');
});
