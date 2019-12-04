require 'nokogiri'
require 'open-uri'
require 'openssl'
require 'uri'

class HttpUtils
    @response
    @xmlresponse
    @sensitive_files = 'event.log'
    @proxy

    def self.request(*args)
        case args.size
            when 1
                @response = open("#{args[0]}", {ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE})
            when 2
                begin
                    if args[1] =~ URI::regexp
                        @response = open("#{args[0]}", :proxy => args[1], ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE)
                    else
                        @response = open("#{args[0]+args[1]}")
                    end
                end
            when 3
                @response = open("#{args[0]+args[1]}", :proxy => args[2])
        end
        @xmlresponse = Nokogiri::HTML.parse(@response)
        @xmlresponse
    end

    def self.sensitive_files
        @sensitive_files
    end

    def self.check_element(*args)
        case args.size
        when 1
            !@xmlresponse.xpath("//#{args[0]}").nil?
        when 2
            !args[0].xpath("//#{args[1]}").nil?
        end
    end

    def self.get_element(*args)
        case args.size
        when 1
            @xmlresponse.xpath("//#{args[0]}").children.to_s if self.check_element(@xmlresponse, args[0])
        when 2
            args[0].xpath("//#{args[1]}").children.to_s if self.check_element(args[0], args[1])
        end
    end

    def self.response()
        @response
    end

    def self.xmlresponse()
        @xmlresponse
    end

    def self.statusCode()
        self.response().status[0]
    end

    def self.status()
        self.response().status[1]
    end
end

