# db/seeds/employees.rb
require 'benchmark'

puts "\nSeeding 10,000 Employees..."
puts "=" * 50

elapsed = Benchmark.realtime do
  # Load names from files
  first_names = File.readlines(Rails.root.join('db/seeds/first_names.txt'))
                    .map(&:strip).reject(&:empty?)
  last_names = File.readlines(Rails.root.join('db/seeds/last_names.txt'))
                   .map(&:strip).reject(&:empty?)

  puts "✓ Loaded #{first_names.length} first names and #{last_names.length} last names"

  # Pre-load reference IDs
  job_title_ids = JobTitle.pluck(:id)
  department_ids = Department.pluck(:id)
  location_ids = WorkLocation.pluck(:id)

  puts "✓ Loaded reference data (#{job_title_ids.length} job titles, #{department_ids.length} departments, #{location_ids.length} locations)"

  # Deterministic random for reproducibility
  random = Random.new(42)

  # Salary ranges by level
  salary_ranges = {
    'IC1' => [45_000, 75_000],
    'IC2' => [70_000, 110_000],
    'IC3' => [100_000, 150_000],
    'IC4' => [140_000, 190_000],
    'IC5' => [180_000, 240_000],
    'IC6' => [220_000, 300_000],
    'M1' => [120_000, 160_000],
    'M2' => [150_000, 200_000],
    'M3' => [180_000, 250_000],
    'M4' => [220_000, 320_000],
    'Executive' => [280_000, 500_000]
  }

  # Helper methods
  def generate_phone(random)
    area = random.rand(200..999)
    prefix = random.rand(200..999)
    line = random.rand(1000..9999)
    "#{area}-#{prefix}-#{line}"
  end

  def random_date(start_year, end_year, random)
    year = random.rand(start_year..end_year)
    month = random.rand(1..12)
    day = random.rand(1..28)
    Date.new(year, month, day)
  end

  def weighted_status(random)
    roll = random.rand(100)
    if roll < 85
      'active'
    elsif roll < 93
      'on_leave'
    else
      'terminated'
    end
  end

  def weighted_employment_type(random)
    roll = random.rand(100)
    if roll < 75
      'full_time'
    elsif roll < 90
      'part_time'
    elsif roll < 97
      'contract'
    else
      'intern'
    end
  end

  # Pre-fetch job title levels for salary calculation
  job_title_levels = JobTitle.pluck(:id, :level).to_h

  # Generate 10,000 employee records
  puts "Generating employee data..."
  employees = 10_000.times.map do |i|
    first_name = first_names.sample(random: random)
    last_name = last_names.sample(random: random)
    job_title_id = job_title_ids.sample(random: random)
    level = job_title_levels[job_title_id]
    salary_range = salary_ranges[level] || [50_000, 100_000]
    hire_date = random_date(2015, 2025, random)
    status = weighted_status(random)

    {
      employee_id: "EMP-#{(i + 1).to_s.rjust(5, '0')}",
      first_name: first_name,
      last_name: last_name,
      email: "#{first_name.downcase}.#{last_name.downcase}#{i}@company.com",
      phone: generate_phone(random),
      date_of_birth: random_date(1970, 2000, random),
      hire_date: hire_date,
      termination_date: (status == 'terminated' ? hire_date + random.rand(90..1800).days : nil),
      status: status,
      job_title_id: job_title_id,
      department_id: department_ids.sample(random: random),
      employment_type: weighted_employment_type(random),
      work_location_id: location_ids.sample(random: random),
      salary: random.rand(salary_range[0]..salary_range[1]).round(-2), # Round to nearest 100
      currency: 'USD',
      salary_effective_date: hire_date,
      created_at: Time.now,
      updated_at: Time.now
    }
  end

  puts "✓ Generated 10,000 employee records"

  # Bulk insert in batches of 1000 for optimal performance
  puts "Inserting employees into database..."
  employees.each_slice(1000) do |batch|
    Employee.insert_all(batch)
  end
  puts "✓ Inserted 10,000 employees"

  # Assign managers to ~60% of employees
  puts "Assigning managers..."
  manager_job_titles = JobTitle.where("level LIKE 'M%' OR level = 'Executive'").pluck(:id)
  manager_ids = Employee.where(job_title_id: manager_job_titles).pluck(:id)

  if manager_ids.any?
    non_manager_ids = Employee.where.not(job_title_id: manager_job_titles).pluck(:id)
    employees_to_assign = non_manager_ids.sample((non_manager_ids.length * 0.6).to_i, random: random)

    # Batch update managers
    employees_to_assign.each_slice(1000) do |batch|
      Employee.where(id: batch).update_all("manager_id = FLOOR(RAND() * #{manager_ids.length}) + #{manager_ids.min}")
    end

    puts "✓ Assigned managers to #{employees_to_assign.length} employees"
  end

  puts "✓ Seed complete!"
end

puts "=" * 50
puts "Total time: #{elapsed.round(2)} seconds"
puts "Employees: #{Employee.count}"
puts "  - Active: #{Employee.where(status: 'active').count}"
puts "  - On Leave: #{Employee.where(status: 'on_leave').count}"
puts "  - Terminated: #{Employee.where(status: 'terminated').count}"
puts "  - With Managers: #{Employee.where.not(manager_id: nil).count}"
puts "=" * 50
