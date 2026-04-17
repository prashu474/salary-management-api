# db/seeds/work_locations.rb
puts "Seeding Work Locations..."

work_locations_data = [
  # United States
  { country_code: 'US', country_name: 'United States', city: 'San Francisco', office_name: 'HQ', timezone: 'America/Los_Angeles' },
  { country_code: 'US', country_name: 'United States', city: 'New York', office_name: 'East Coast Office', timezone: 'America/New_York' },
  { country_code: 'US', country_name: 'United States', city: 'Austin', office_name: 'Texas Office', timezone: 'America/Chicago' },
  { country_code: 'US', country_name: 'United States', city: 'Seattle', office_name: 'Pacific Northwest', timezone: 'America/Los_Angeles' },
  { country_code: 'US', country_name: 'United States', city: 'Boston', office_name: 'Boston Office', timezone: 'America/New_York' },

  # Canada
  { country_code: 'CA', country_name: 'Canada', city: 'Toronto', office_name: 'Canada HQ', timezone: 'America/Toronto' },
  { country_code: 'CA', country_name: 'Canada', city: 'Vancouver', office_name: 'West Coast Office', timezone: 'America/Vancouver' },

  # United Kingdom
  { country_code: 'GB', country_name: 'United Kingdom', city: 'London', office_name: 'UK HQ', timezone: 'Europe/London' },
  { country_code: 'GB', country_name: 'United Kingdom', city: 'Manchester', office_name: 'Northern Office', timezone: 'Europe/London' },

  # Germany
  { country_code: 'DE', country_name: 'Germany', city: 'Berlin', office_name: 'EMEA HQ', timezone: 'Europe/Berlin' },
  { country_code: 'DE', country_name: 'Germany', city: 'Munich', office_name: 'Munich Office', timezone: 'Europe/Berlin' },

  # India
  { country_code: 'IN', country_name: 'India', city: 'Bangalore', office_name: 'India HQ', timezone: 'Asia/Kolkata' },
  { country_code: 'IN', country_name: 'India', city: 'Hyderabad', office_name: 'South India Office', timezone: 'Asia/Kolkata' },
  { country_code: 'IN', country_name: 'India', city: 'Mumbai', office_name: 'West India Office', timezone: 'Asia/Kolkata' },

  # Singapore
  { country_code: 'SG', country_name: 'Singapore', city: 'Singapore', office_name: 'APAC HQ', timezone: 'Asia/Singapore' },

  # Australia
  { country_code: 'AU', country_name: 'Australia', city: 'Sydney', office_name: 'Australia HQ', timezone: 'Australia/Sydney' },
  { country_code: 'AU', country_name: 'Australia', city: 'Melbourne', office_name: 'Melbourne Office', timezone: 'Australia/Melbourne' },

  # France
  { country_code: 'FR', country_name: 'France', city: 'Paris', office_name: 'France Office', timezone: 'Europe/Paris' },

  # Netherlands
  { country_code: 'NL', country_name: 'Netherlands', city: 'Amsterdam', office_name: 'Benelux Office', timezone: 'Europe/Amsterdam' },

  # Japan
  { country_code: 'JP', country_name: 'Japan', city: 'Tokyo', office_name: 'Japan Office', timezone: 'Asia/Tokyo' },

  # Brazil
  { country_code: 'BR', country_name: 'Brazil', city: 'São Paulo', office_name: 'Latin America HQ', timezone: 'America/Sao_Paulo' },

  # Mexico
  { country_code: 'MX', country_name: 'Mexico', city: 'Mexico City', office_name: 'Mexico Office', timezone: 'America/Mexico_City' }
]

WorkLocation.insert_all(work_locations_data)
puts "✓ Created #{WorkLocation.count} work locations"
