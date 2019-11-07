#!/usr/bin/ruby

require 'colorize'
require_relative 'src/http_utils.rb'
require_relative 'src/utils.rb'

url = ARGV[0]
splash()

g = HttpUtils.new

if ARGV[0].nil?
	usage
	exit 0
end

puts "[+] Testing directory listing ".green
xml_response = g.do_request(url, '/glpi/config')
puts g.get_element(xml_response, 'title').red

puts "[+] Searching for sensitive files ".green
#xml_response = do_request(url, '/glpi/files/_log/event.log')
response = Net::HTTP.get_response("#{url}", '/glpi/files/_log/event.log')
puts "The file is available".red if (response.code == "200")

puts "[+] Testing server version and SO".green
puts g.get_element(xml_response, 'address').red
