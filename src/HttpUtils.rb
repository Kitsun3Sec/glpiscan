require 'nokogiri'
require 'open-uri'

class HttpUtils
    @response
    @sensitive_files = 'event.log'

    def self.request(url)
        @response = open("#{url+path}")
        Nokogiri::HTML.parse(@response)
    end

    def self.request(url)
        @response = open("#{url}")
        Nokogiri::HTML.parse(@response)
    end

    def self.sensitive_files
        @sensitive_files
    end

    def self.check_element(xmlresponse, name)
        !xmlresponse.xpath("//#{name}").nil?
    end

    def self.get_element(xmlresponse, name)
        xmlresponse.xpath("//#{name}").children.to_s if self.check_element(xmlresponse, name)
    end

    def self.response()
        @response
    end

    def self.getResponseCode()
        self.response().status[0]
    end
end

