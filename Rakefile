# frozen_string_literal: true

require 'time'
require 'fileutils'

task default: :help

desc 'Show available rake tasks'
task :help do
  puts "Available tasks:"
  puts "  rake photo_draft[path/to/image.jpg]  - Create a draft post from a JPEG image with EXIF data"
  puts ""
  puts "Example:"
  puts "  rake photo_draft[assets/images/my-photo.jpg]"
  puts ""
  puts "The script will extract EXIF data (Title, Description, Subject, DateTimeOriginal)"
  puts "and create a draft post in _drafts/ with the appropriate frontmatter."
  puts ""
  puts "Requirements:"
  puts "  - exiftool must be installed (sudo apt-get install libimage-exiftool-perl)"
end

desc 'Create a draft post from a JPEG image with EXIF data'
task :photo_draft, [:image_path] do |_t, args|
  image_path = args[:image_path]

  if image_path.nil? || image_path.empty?
    abort "Usage: rake photo_draft[path/to/image.jpg]"
  end

  unless File.exist?(image_path)
    abort "Error: Image file not found: #{image_path}"
  end

  unless image_path.downcase.end_with?('.jpg', '.jpeg')
    abort "Error: File must be a JPEG image (.jpg or .jpeg)"
  end

  # Check if exiftool is available
  unless system('which exiftool > /dev/null 2>&1')
    abort "Error: exiftool is not installed. Install it with: sudo apt-get install libimage-exiftool-perl"
  end

  # Read EXIF data using exiftool
  exif_data = read_exif(image_path)

  title = exif_data['Title'] || 'Untitled'
  description = exif_data['Description'] || ''
  location = exif_data['Subject'] || ''
  date_original = exif_data['DateTimeOriginal'] || exif_data['CreateDate']

  if date_original.nil? || date_original.empty?
    abort "Error: No DateTimeOriginal or CreateDate found in EXIF data"
  end

  # Parse EXIF date format (YYYY:MM:DD HH:MM:SS)
  photo_date = parse_exif_date(date_original)
  
  # Current timestamp for last_modified_at and published_at
  now = Time.now
  timestamp = now.strftime('%Y-%m-%d %H:%M %z')

  # Generate slug from title
  slug = slugify(title)
  
  # Generate filename
  date_prefix = photo_date.strftime('%Y-%m-%d')
  filename = "_drafts/#{date_prefix}-#{slug}.md"

  # Ensure _drafts directory exists
  FileUtils.mkdir_p('_drafts')

  # Check if file already exists
  if File.exist?(filename)
    abort "Error: Draft already exists: #{filename}"
  end

  # Generate frontmatter
  content = <<~FRONTMATTER
    ---
    title: #{title}
    description: #{description}
    location: #{location}
    last_modified_at: #{timestamp}
    published_at: #{timestamp}
    category: Photos
    tags: []
    image: #{image_path}
    ---
  FRONTMATTER

  # Write the draft file
  File.write(filename, content)

  puts "Created draft: #{filename}"
  puts "  Title: #{title}"
  puts "  Description: #{description}"
  puts "  Location: #{location}"
  puts "  Photo Date: #{photo_date.strftime('%Y-%m-%d %H:%M')}"
end

# Read EXIF data using exiftool and return as a hash
def read_exif(image_path)
  output = `exiftool -Title -Description -Subject -DateTimeOriginal -CreateDate "#{image_path}" 2>/dev/null`
  
  exif = {}
  output.each_line do |line|
    line = line.strip
    next if line.empty?
    
    # Split on first colon
    parts = line.split(':', 2)
    next unless parts.length == 2
    
    key = parts[0].strip.gsub(/[\s\/]+/, '')
    value = parts[1].strip
    exif[key] = value
  end
  
  exif
end

# Parse EXIF date format (YYYY:MM:DD HH:MM:SS) to Time object
def parse_exif_date(date_string)
  # EXIF date format: 2019:02:14 14:10:19
  if date_string =~ /^(\d{4}):(\d{2}):(\d{2})\s+(\d{2}):(\d{2}):(\d{2})$/
    Time.new($1.to_i, $2.to_i, $3.to_i, $4.to_i, $5.to_i, $6.to_i)
  else
    abort "Error: Could not parse date: #{date_string}"
  end
end

# Convert title to URL-friendly slug
def slugify(title)
  title
    .downcase
    .gsub(/[^a-z0-9\s-]/, '')  # Remove non-alphanumeric characters
    .gsub(/\s+/, '-')          # Replace spaces with hyphens
    .gsub(/-+/, '-')           # Replace multiple hyphens with single hyphen
    .gsub(/^-|-$/, '')         # Remove leading/trailing hyphens
end
