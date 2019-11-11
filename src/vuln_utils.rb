def get_glpi_version(url)
	glpi_version = do_request(url, '/glpi/CHANGELOG.md')
	glpi_version = get_element(glpi_version, '//p').to_s.split("\n\n").grep(/unreleased$/).to_s.split[1]

end

def system_info(url)
	xml_response = do_request(url, '/glpi/config')
	address = get_element(xml_response, 'address')
	puts 'Server: '.red << address.split[0]
	puts 'SO: '.red << address.split[1]
	glpi_version = get_glpi_version(url)
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

@known_vulnerabilities = {
	"9.4.4" => "No public vuln yet",
	"0.83.3" => "[ CVE-2012-4003 ] \nMultiple cross-site scripting (XSS) vulnerabilities in GLPI-PROJECT GLPI before 0.83.3 allow remote attackers to inject arbitrary web script or HTML via unknown vectors.
",
	"0.80.2" => "[ CVE-2011-2720 ] \nThe autocompletion functionality in GLPI before 0.80.2 does not blacklist certain username and password fields, which allows remote attackers to obtain sensitive information via a crafted POST request."
}

def search_cve(url)
	glpi_version = get_glpi_version(url)
	glpi_version = glpi_version.tr('[]', '')
	puts @known_vulnerabilities.fetch("#{glpi_version}")
end
