#a = "http://en.wikipedia.org/wiki/Pr%C3%BCfer_sequence"
a=property_url

@carrier = []

def show_content(content)
	content.each do |c|
		puts c.text
	end
end


if a
    print "inside algorithm vm"
    require 'nokogiri'
    require 'open-uri'
    puts a
    catch = false
    begin
        b = URI.encode(a)
        doc = Nokogiri::HTML(open(a))
        rescue
        begin
            
            doc = Nokogiri::HTML(open(b))
            print b
            print "rescue mein"
            rescue
            print "second rescue mein"
            catch = true
        end
    end
    
    
    redirect = doc.css('li').children.text.split(' ')
    redirect = redirect[0]
    if redirect.include?'REDIRECT'
        print "This is redirect case"
        a = a.to_s.gsub ' ', '_'
        doc = Nokogiri::HTML(open("http://en.wikipedia.org/wiki/"+a))
    end
    
    rem_nodes = ['table.ambox','.portal','table.infobox','table.vertical-navbox','div.thumbinner','span.mw-editsection','div#toc','table.navbox','table.metadata','//comment()','sup.reference','div.relarticle']
    rem_nodes.each do |r|
        x = doc.css(r)
        x.remove
    end
    
    uri = URI.parse(a)
    base = "#{uri.scheme}://#{uri.host}"
    doc.css('a').each do |l|
        if l['href']
			if l['href'][0] == "#"
			l['href'] = a + l['href']
			l['target'] = '_blank'
            elsif l['href'][0] == '/'
			l['href'] = base + l['href']
			l['target'] = '_blank'
			end
        end
    end
    
    # wiki_definition
    
    node = doc.css("p")[0]
    begin
        stop = doc.css("h2 > span")[0].parent
        rescue
        stop = nil
    end
    while node!=stop
        @carrier << node
        node = node.next
    end
    
    if @carrier != []
        show_content(@carrier)
    end
end