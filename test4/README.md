# Django Reporting Service

A Django REST Framework microservice that generates reports from the Node.js API.

## Features

- **Summary Report**: `/report/summary` - Total users, total videos, top categories
- **User Activity Report**: `/report/user/<id>` - User-specific activity report

## Setup

1. Create a virtual environment:
```bash
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate
```

2. Install dependencies:
```bash
pip install -r requirements.txt
```

3. Set environment variables:
```bash
export NODE_API_URL=http://localhost:3000
export SECRET_KEY=your-secret-key-here
export DEBUG=True
```

4. Run migrations:
```bash
python manage.py migrate
```

5. Run the server:
```bash
python manage.py runserver
```

The service will be available at `http://localhost:8000`

## API Endpoints

### GET /report/summary
Returns summary statistics:
```json
{
  "total_users": 10,
  "total_videos": 25,
  "top_categories": [
    {"category": "Programming", "count": 8},
    {"category": "Design", "count": 5}
  ]
}
```

### GET /report/user/<user_id>
Returns user activity report:
```json
{
  "user": {
    "id": 1,
    "name": "John Doe",
    "email": "john@example.com"
  },
  "total_videos": 5,
  "total_duration_seconds": 1500,
  "videos_by_category": {
    "Programming": 3,
    "Design": 2
  },
  "videos": [...]
}
```

## Running Tests

```bash
python manage.py test
```

## Production Deployment

1. Set `DEBUG=False` in environment
2. Set a secure `SECRET_KEY`
3. Configure `ALLOWED_HOSTS` in settings.py
4. Use a production WSGI server (gunicorn, uwsgi)
5. Set up reverse proxy (Nginx)

