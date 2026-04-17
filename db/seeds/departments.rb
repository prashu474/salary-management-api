# db/seeds/departments.rb
puts "Seeding Departments..."

departments_data = [
  { name: 'Engineering', code: 'ENG', parent_department_id: nil },
  { name: 'Product', code: 'PROD', parent_department_id: nil },
  { name: 'Sales', code: 'SALES', parent_department_id: nil },
  { name: 'Marketing', code: 'MKT', parent_department_id: nil },
  { name: 'Customer Success', code: 'CS', parent_department_id: nil },
  { name: 'Finance', code: 'FIN', parent_department_id: nil },
  { name: 'HR', code: 'HR', parent_department_id: nil },
  { name: 'Legal', code: 'LEGAL', parent_department_id: nil },
  { name: 'Operations', code: 'OPS', parent_department_id: nil },
  { name: 'Executive', code: 'EXEC', parent_department_id: nil }
]

Department.insert_all(departments_data)

# Create sub-departments
engineering = Department.find_by(code: 'ENG')
sub_departments = [
  { name: 'Backend Engineering', code: 'ENG-BE', parent_department_id: engineering.id },
  { name: 'Frontend Engineering', code: 'ENG-FE', parent_department_id: engineering.id },
  { name: 'Mobile Engineering', code: 'ENG-MOB', parent_department_id: engineering.id },
  { name: 'DevOps', code: 'ENG-DEVOPS', parent_department_id: engineering.id },
  { name: 'Data Engineering', code: 'ENG-DATA', parent_department_id: engineering.id },
  { name: 'QA', code: 'ENG-QA', parent_department_id: engineering.id }
]

Department.insert_all(sub_departments)
puts "✓ Created #{Department.count} departments"
