# Salary Management System - Seed Data
# This file loads all seed data for the application
# Run with: rails db:seed
#
# For a fresh start: rails db:drop db:create db:migrate db:seed

require 'benchmark'

puts "\n"
puts "=" * 60
puts "  SALARY MANAGEMENT SYSTEM - SEEDING DATABASE"
puts "=" * 60

total_time = Benchmark.realtime do
  # Clear existing data (development only)
  if Rails.env.development?
    puts "\n⚠️  Clearing existing data..."
    SalaryHistory.delete_all
    Employee.delete_all
    JobTitle.delete_all
    Department.delete_all
    WorkLocation.delete_all
    puts "✓ Database cleared"
  end

  # Seed in order due to foreign key dependencies
  ActiveRecord::Base.transaction do
    # 1. Reference tables (no dependencies)
    load Rails.root.join('db/seeds/job_titles.rb')
    load Rails.root.join('db/seeds/departments.rb')
    load Rails.root.join('db/seeds/work_locations.rb')

    # 2. Employees (depends on reference tables)
    load Rails.root.join('db/seeds/employees.rb')
  end
end

puts "\n"
puts "=" * 60
puts "  SEEDING COMPLETE!"
puts "=" * 60
puts "Total execution time: #{total_time.round(2)} seconds"
puts "\nDatabase Summary:"
puts "  - Job Titles: #{JobTitle.count}"
puts "  - Departments: #{Department.count}"
puts "  - Work Locations: #{WorkLocation.count}"
puts "  - Employees: #{Employee.count}"
puts "  - Countries: #{WorkLocation.distinct.count(:country_code)}"
puts "=" * 60
puts "\n"
