require 'open-uri'
require 'nokogiri'

class Company
  def initialize(name,url)
    @name = name
    @url = url
    file = open(url)
    page = file.read
    parse page
  end

  def parse(page)
    doc = Nokogiri::HTML(page)
    node = doc.css('meta[property="og:description"]').first
    if node
      @description = node['content']
    end
  end

  def to_csv
    "#{@name};#{@url};#{@description}"
  end
end