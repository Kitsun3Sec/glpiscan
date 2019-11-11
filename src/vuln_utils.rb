def system_info(url)
	xml_response = do_request(url, '/glpi/config')
	address = get_element(xml_response, 'address')
	puts 'Server: '.red << address.split[0]
	puts 'SO: '.red << address.split[1]

	glpi_version = do_request(url, '/glpi/CHANGELOG.md')
	glpi_version = get_element(glpi_version, '//p').to_s.split("\n\n").grep(/unreleased$/).to_s.split[1]
	puts 'GLPI version: '.red << glpi_version
end

def dir_testing(url)
	xml_response = do_request(url, '/glpi/config')
	xml_response = get_element(xml_response, 'title')

	if (xml_response == "Index of /glpi/config")
		puts " [-] ".red.bold << "Directory List"
		puts "  [+] ".red << "Interesting folders"
		puts "   [+] ".red <<  "/glpi/files/_dumps > Database dump".yellow
		puts "   [+] ".red <<  "/glpi/files/_sessions".yellow
		puts "   [+] ".red <<  "/glpi/files/_uploads".yellow
	else
		puts "No directory Listing - [OK]".green
	end
end

def enumerate_users(url)
	puts "  [+]".red << " Username Enumeration".yellow
	file = do_request(url, '/glpi/files/_log/event.log')
	
	f = File.new("username_list", "w")
	f.puts file
	f.close
	
	system("cat username_list | grep log | cut -d ' ' -f 3 | sort | uniq > a")
	f = File.read("a")
	
	f.each_line {|user| print "    #{user}".yellow.bold}
	File.delete("a")
	File.delete("username_list")
end

def sensitive_files(url)
	response = Net::HTTP.get_response("#{url}", '/glpi/files/_log/event.log')
	if (response.code == "200")
		puts " [-]".red.bold  << " The file is available"
		enumerate_users(url)
		elsif (response.code == "401")
			puts "The file is not available! [ OK]"
	end
end
