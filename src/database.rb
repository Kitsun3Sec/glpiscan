module Vulnerabilities
    known_vulnerabilities = {
      "9.4.4" => "No public vuln for 9.4.4 yet",
      "0.83.3" => "[ CVE-2012-4003 ] \nMultiple cross-site scripting (XSS) vulnerabilities in GLPI-PROJECT GLPI before 0.83.3 allow remote attackers to inject arbitrary web script or HTML via unknown vectors.",
      "0.80.2" => "[ CVE-2011-2720 ] \nThe autocompletion functionality in GLPI before 0.80.2 does not blacklist certain username and password fields, which allows remote attackers to obtain sensitive information via a crafted POST request."
    }

    def self.check(version_number)
        known_vulnerabilities.has_key? version_number
    end

    def self.lookFor(version_number)
        known_vulnerabilities[version_number] if check(version_number)
    end
end

