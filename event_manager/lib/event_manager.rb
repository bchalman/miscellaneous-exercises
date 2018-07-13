require 'csv'
require 'google/apis/civicinfo_v2'
require 'erb'

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5,"0")[0..4]
end

def legislators_by_zipcode(zip)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

  begin
    civic_info.representative_info_by_address(
      address: zip,
      levels: 'country',
      roles: ['legislatorUpperBody', 'legislatorLowerBody']
    ).officials
  rescue
    "You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials"
  end
end

def save_thank_you_letters(id,form_letter)
  Dir.mkdir("output") unless Dir.exists?("output")

  filename = "output/thanks_#{id}.html"

  File.open(filename,'w') do |file|
    file.puts form_letter
  end
end

puts "EventManager initialized."

contents = CSV.open 'event_attendees.csv', headers: true, header_converters: :symbol

template_letter = File.read "form_letter.erb"
erb_template = ERB.new template_letter

hour_registrations = Hash.new(0)
day_registrations = Hash.new(0)
contents.each do |row|
  id = row[0]
  name = row[:first_name]
  zipcode = clean_zipcode(row[:zipcode])
  registration_time = DateTime.strptime(row[:regdate], "%m/%d/%y %H:%M")
  hour_registrations[registration_time.hour] += 1
  day_registrations[registration_time.strftime("%A")] += 1
  legislators = legislators_by_zipcode(zipcode)

  puts "#{name.ljust(10)} #{zipcode.ljust(6)} #{registration_time}"

  # form_letter = erb_template.result(binding)
  # save_thank_you_letters(id,form_letter)
end
puts hour_registrations.inspect
puts day_registrations.inspect
