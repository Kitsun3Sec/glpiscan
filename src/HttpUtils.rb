require 'nokogiri'
require 'open-uri'
require 'uri'

class HttpUtils
    @response
    @sensitive_files = 'event.log'
    @proxy

    def self.request(*args)
        case args.size
            when 1
                @response = open("#{args[0]}")
            when 2
                begin
                    if args[1] =~ URI::regexp
                        @response = open("#{args[0]}", :proxy => args[1])
                    else
                        @response = open("#{args[0]+args[1]}")
                    end
                end
            when 3
                @response = open("#{args[0]+args[1]}", :proxy => args[2])
        end
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

