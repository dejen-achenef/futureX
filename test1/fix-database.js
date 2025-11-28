// Script to fix database schema
import db from './models/index.js';

async function fixDatabase() {
  try {
    console.log('Connecting to database...');
    await db.sequelize.authenticate();
    console.log('✓ Database connected');

    console.log('Syncing models...');
    await db.sequelize.sync({ alter: true });
    console.log('✓ Database synced successfully');

    process.exit(0);
  } catch (error) {
    console.error('✗ Error:', error.message);
    console.error(error.stack);
    process.exit(1);
  }
}

fixDatabase();

