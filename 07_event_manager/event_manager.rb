template_letter = File.read('form_letter.html')
require 'csv'
require 'google/apis/civicinfo_v2'


def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5, '0')[0..4]
end 

def legislators_by_zipcode(zipcode)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

  begin
    legislators = civic_info.representative_info_by_address(
      address: zipcode,
      levels: 'country',
      roles: ['legislatorUpperBody', 'legislatorLowerBody']
    )  
    legislators = legislators.officials
    legislator_names = legislators.map(&:name)
    legislators_string = legislator_names.join(", ")
  rescue
    'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
  end
end

puts 'EventManager initialized'

contents = CSV.open(
    'event_attendees.csv', 
    headers: true,
    header_converters: :symbol
    )

contents.each do |row|
    name = row[:first_name]

    zipcode = clean_zipcode(row[:zipcode])

    legislators = legislators_by_zipcode(zipcode)
  
    puts "#{name} #{zipcode} #{legislators}"
end


#TO BE CONTINUED: Iteration 4