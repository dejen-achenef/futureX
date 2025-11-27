# Environment Setup

Create a `.env` file in the root directory with the following variables:

```env
# Server Configuration
PORT=3000
NODE_ENV=development

# Database Configuration
DB_HOST=localhost
DB_PORT=3306
DB_NAME=user_video_db
DB_USER=root
DB_PASSWORD=your_password_here

# JWT Configuration
JWT_SECRET=your-super-secret-jwt-key-change-this-in-production
JWT_EXPIRES_IN=7d

# Upload Configuration
UPLOAD_PATH=./uploads/avatars
MAX_FILE_SIZE=5242880
```

## Instructions

1. Copy this content to a new file named `.env` in the project root
2. Update the database credentials (DB_USER, DB_PASSWORD) to match your MySQL setup
3. Create the database in MySQL:
   ```sql
   CREATE DATABASE user_video_db;
   ```
4. Change the JWT_SECRET to a secure random string for production use
5. Update MAX_FILE_SIZE if you need to change the maximum avatar file size (in bytes)
