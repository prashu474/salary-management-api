# db/seeds/job_titles.rb
puts "Seeding Job Titles..."

job_titles_data = [
  # Engineering
  { title: 'Junior Software Engineer', level: 'IC1', category: 'Engineering' },
  { title: 'Software Engineer', level: 'IC2', category: 'Engineering' },
  { title: 'Senior Software Engineer', level: 'IC3', category: 'Engineering' },
  { title: 'Staff Software Engineer', level: 'IC4', category: 'Engineering' },
  { title: 'Principal Software Engineer', level: 'IC5', category: 'Engineering' },
  { title: 'Distinguished Engineer', level: 'IC6', category: 'Engineering' },
  { title: 'Engineering Manager', level: 'M1', category: 'Engineering' },
  { title: 'Senior Engineering Manager', level: 'M2', category: 'Engineering' },
  { title: 'Director of Engineering', level: 'M3', category: 'Engineering' },
  { title: 'VP of Engineering', level: 'M4', category: 'Engineering' },
  { title: 'QA Engineer', level: 'IC2', category: 'Engineering' },
  { title: 'Senior QA Engineer', level: 'IC3', category: 'Engineering' },
  { title: 'DevOps Engineer', level: 'IC2', category: 'Engineering' },
  { title: 'Senior DevOps Engineer', level: 'IC3', category: 'Engineering' },
  { title: 'Data Engineer', level: 'IC2', category: 'Engineering' },
  { title: 'Senior Data Engineer', level: 'IC3', category: 'Engineering' },

  # Product
  { title: 'Associate Product Manager', level: 'IC1', category: 'Product' },
  { title: 'Product Manager', level: 'IC2', category: 'Product' },
  { title: 'Senior Product Manager', level: 'IC3', category: 'Product' },
  { title: 'Staff Product Manager', level: 'IC4', category: 'Product' },
  { title: 'Director of Product', level: 'M3', category: 'Product' },
  { title: 'VP of Product', level: 'M4', category: 'Product' },
  { title: 'Product Designer', level: 'IC2', category: 'Product' },
  { title: 'Senior Product Designer', level: 'IC3', category: 'Product' },

  # Sales
  { title: 'Sales Development Rep', level: 'IC1', category: 'Sales' },
  { title: 'Account Executive', level: 'IC2', category: 'Sales' },
  { title: 'Senior Account Executive', level: 'IC3', category: 'Sales' },
  { title: 'Enterprise Account Executive', level: 'IC4', category: 'Sales' },
  { title: 'Sales Manager', level: 'M1', category: 'Sales' },
  { title: 'Regional Sales Director', level: 'M2', category: 'Sales' },
  { title: 'VP of Sales', level: 'M4', category: 'Sales' },

  # Marketing
  { title: 'Marketing Coordinator', level: 'IC1', category: 'Marketing' },
  { title: 'Marketing Manager', level: 'IC2', category: 'Marketing' },
  { title: 'Senior Marketing Manager', level: 'IC3', category: 'Marketing' },
  { title: 'Content Marketing Manager', level: 'IC2', category: 'Marketing' },
  { title: 'Growth Marketing Manager', level: 'IC2', category: 'Marketing' },
  { title: 'Director of Marketing', level: 'M3', category: 'Marketing' },
  { title: 'VP of Marketing', level: 'M4', category: 'Marketing' },

  # Customer Success
  { title: 'Customer Success Associate', level: 'IC1', category: 'Customer Success' },
  { title: 'Customer Success Manager', level: 'IC2', category: 'Customer Success' },
  { title: 'Senior Customer Success Manager', level: 'IC3', category: 'Customer Success' },
  { title: 'Customer Success Director', level: 'M2', category: 'Customer Success' },
  { title: 'VP of Customer Success', level: 'M4', category: 'Customer Success' },

  # Finance
  { title: 'Financial Analyst', level: 'IC1', category: 'Finance' },
  { title: 'Senior Financial Analyst', level: 'IC2', category: 'Finance' },
  { title: 'Accountant', level: 'IC2', category: 'Finance' },
  { title: 'Senior Accountant', level: 'IC3', category: 'Finance' },
  { title: 'Finance Manager', level: 'M1', category: 'Finance' },
  { title: 'Controller', level: 'M2', category: 'Finance' },
  { title: 'VP of Finance', level: 'M4', category: 'Finance' },
  { title: 'CFO', level: 'Executive', category: 'Finance' },

  # HR
  { title: 'HR Coordinator', level: 'IC1', category: 'HR' },
  { title: 'HR Generalist', level: 'IC2', category: 'HR' },
  { title: 'Senior HR Generalist', level: 'IC3', category: 'HR' },
  { title: 'Recruiter', level: 'IC2', category: 'HR' },
  { title: 'Senior Recruiter', level: 'IC3', category: 'HR' },
  { title: 'HR Manager', level: 'M1', category: 'HR' },
  { title: 'Director of HR', level: 'M3', category: 'HR' },
  { title: 'VP of People', level: 'M4', category: 'HR' },

  # Legal
  { title: 'Legal Counsel', level: 'IC3', category: 'Legal' },
  { title: 'Senior Legal Counsel', level: 'IC4', category: 'Legal' },
  { title: 'General Counsel', level: 'M4', category: 'Legal' },

  # Operations
  { title: 'Operations Analyst', level: 'IC1', category: 'Operations' },
  { title: 'Operations Manager', level: 'IC2', category: 'Operations' },
  { title: 'Senior Operations Manager', level: 'IC3', category: 'Operations' },
  { title: 'Director of Operations', level: 'M3', category: 'Operations' },
  { title: 'COO', level: 'Executive', category: 'Operations' },

  # Executive
  { title: 'CEO', level: 'Executive', category: 'Executive' },
  { title: 'CTO', level: 'Executive', category: 'Executive' },
  { title: 'CPO', level: 'Executive', category: 'Executive' },
  { title: 'CMO', level: 'Executive', category: 'Executive' }
]

JobTitle.insert_all(job_titles_data)
puts "✓ Created #{JobTitle.count} job titles"
