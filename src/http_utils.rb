#!/bin/usr/ruby

require 'nokogiri'
require 'open-uri'
require 'net/http'

def do_request(url, path)
    Nokogiri::HTML.parse(open("http://#{url+path}"))
end

def sensitive_files
	event_log = 'event.log'
end

def check_element(response, name)
	!response.xpath("//#{name}").nil?
end

def get_element(response, name)
	response.xpath("//#{name}").children.to_s if check_element(response, name)
end
