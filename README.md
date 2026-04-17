
# Salary Management API (Backend)

## 🏗️ Architecture
- **Framework**: Ruby on Rails 7.1 (API-only mode)
- **Database**: MySQL 8.0+
- **Key Features**:
  - RESTful API with versioning (v1)
  - Optimized bulk inserts for seeding
  - Complex aggregation queries for insights
  - Comprehensive model validations
  - CORS enabled for frontend integration

## 📊 Database Schema

### Core Tables
1. **employees** - 10,000 records with comprehensive employee data
2. **job_titles** - 71 positions across Engineering, Product, Sales, Marketing, etc.
3. **departments** - 16 departments with hierarchical structure
4. **work_locations** - 22 global offices across 12 countries
5. **salary_histories** - Audit trail for all salary changes

### Key Relationships
- Employees belong to job_title, department, work_location
- Employees can have managers (self-referential)
- Salary changes automatically create history records

## 🚀 Getting Started

### Prerequisites
- Ruby 3.1.2+
- MySQL 8.0+

### Backend Setup
```bash
cd salary-management-api
bundle install

# Configure database
# Edit config/database.yml if needed (default: root user, no password)

bin/rails db:create
bin/rails db:migrate
bin/rails db:seed

# Start server on port 3001
bin/rails server -p 3001
```

### Access
- **Backend API**: http://localhost:3001/api/v1

## 📡 API Endpoints

### Employees
```
GET    /api/v1/employees       # List all (paginated)
GET    /api/v1/employees/:id   # Get details
POST   /api/v1/employees       # Create new
PATCH  /api/v1/employees/:id   # Update
DELETE /api/v1/employees/:id   # Soft delete
```

### Query Parameters
| Param | Description |
|---|---|
| `page` | Page number (default: 1) |
| `per_page` | Records per page (max: 100) |
| `status` | active / on_leave / terminated |
| `search` | Name, email, or employee_id |
| `country_code` | Filter by country |
| `department_id` | Filter by department |
| `job_title_id` | Filter by job title |
| `sort_by` | Sort field |
| `sort_order` | asc or desc |

### Insights
```
GET /api/v1/insights/dashboard           # Overall statistics
GET /api/v1/insights/salary_by_country   # Salary stats by country
GET /api/v1/insights/salary_by_job_title # Salary stats by job title
```

### Reference Data
```
GET /api/v1/job_titles       # All job titles
GET /api/v1/departments      # All departments
GET /api/v1/work_locations   # All work locations
```

## ✅ Backend Features
- MySQL database with optimized schema
- 10,000 employee seed script (< 2 seconds)
- Full CRUD API for employees
- Salary insights by country & job title
- Dashboard statistics endpoint
- Advanced filtering, search & pagination
- Salary history tracking
- Model validations and associations
- CORS configuration

## 📊 Performance
| Operation | Time |
|---|---|
| Seed 10,000 employees | ~1.04s |
| Employee list (50 records) | < 100ms |
| Insights by country | < 200ms |
| Employee detail | < 50ms |

## 🔧 Technical Decisions
1. **Bulk Insert**: `insert_all` with 1000-record batching for 10x faster seeding
2. **Strategic Indexing**: Composite indexes on frequently queried columns
3. **Soft Delete**: Terminated status instead of hard delete for audit trail
4. **Eager Loading**: Includes associations to avoid N+1 queries
5. **SQL Aggregations**: Database-level aggregations for insights

## 🗂️ Project Structure
```
salary-management-api/
├── app/
│   ├── controllers/api/v1/   # API Controllers
│   ├── models/               # ActiveRecord Models
├── config/
│   ├── database.yml          # MySQL configuration
│   └── routes.rb             # API routes
├── db/
│   ├── migrate/              # Database migrations
│   └── seeds/                # Seed scripts
│       ├── first_names.txt
│       ├── last_names.txt
│       ├── job_titles.rb
│       ├── departments.rb
│       ├── work_locations.rb
│       └── employees.rb
└── spec/                     # RSpec tests
```

## 🧪 Testing
```bash
cd salary-management-api
bundle exec rspec
```

## 🚢 Deployment (Heroku example)
```bash
heroku create salary-mgmt-api
heroku addons:create cleardb:ignite
git push heroku main
heroku run rails db:migrate db:seed
```

## 📝 Environment Variables
```
DATABASE_URL=mysql2://user:pass@host/db
RAILS_ENV=production
```
