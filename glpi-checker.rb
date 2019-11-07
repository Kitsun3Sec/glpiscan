#!/usr/bin/ruby

require 'colorize'
require_relative 'src/http_utils.rb'
require_relative 'src/utils.rb'
require_relative 'src/vuln_utils.rb'

url = ARGV[0]
splash()

if ARGV[0].nil?
	usage
	exit 0
end

puts "[+] System info".green
system_info(url)

puts "\n[+] Testing directory listing ".green
dir_testing(url)

puts "\n[+] Searching for sensitive files ".green
sensitive_files(url)
