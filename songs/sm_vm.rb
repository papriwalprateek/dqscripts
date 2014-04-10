require 'nokogiri'

@doc = Nokogiri::HTML(open('http://songmeanings.com/songs/view/3530822107859458530/'))

x = @doc.css('div.sign')
x.remove

x = @doc.css('ul.answers')
x.remove

@sm = @doc.css('div.text')
