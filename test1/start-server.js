// Simple startup script to test server
import 'dotenv/config';
import db from './models/index.js';

async function start() {
  try {
    console.log('Testing database connection...');
    await db.sequelize.authenticate();
    console.log('✓ Database connection successful');
    
    console.log('Starting server...');
    const { default: app } = await import('./server.js');
    console.log('✓ Server module loaded');
  } catch (error) {
    console.error('✗ Error starting server:');
    console.error(error.message);
    console.error(error.stack);
    process.exit(1);
  }
}

start();

