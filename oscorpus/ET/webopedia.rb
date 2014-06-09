def webopedia_extract(url)
	doc = Nokogiri::HTML(open(url))
	carrier = []
	x = doc.css('//comment()')
	x.remove
#	carrier << doc.css('h1')
	start = doc.css('div.article_related_items')[0]
	stop = doc.css('div#olal-container')	
	node = start.next

	while node != stop[0]
		carrier << node
		node = node.next
	end
	
	return carrier

end


def Extract(url, whitenodes)

# format of whitenodes = [['div.suggestEdit',-1],['div.ac_adbox_inner',0]]
# url 'http://www.wisegeek.org/what-is-a-dual-core-processor.htm'

@doc = Nokogiri::HTML(open(url))

@content = []

whitenodes.each do |w|
		if w[1] == -1
			temp = @doc.css(w[0])
			temp.each do |t|
				@content << t
			end
		else
			temp = @doc.css(w[0])[w[1]]
			@content << temp
		end
end

end




def technopedia_extract(url)
	Extract(url,[['div.techopedia_intellitxt',0]])
	return @content
end


def techtarget_extract(url)
	doc = Nokogiri::HTML(open(url))
	carrier = []
#	carrier << doc.css('h1')
	x = doc.css('//comment()')
	x.remove
	start = doc.css('div#articleBody p')[0]
	stop = doc.css('div#relatedGlossaryTerms')[0].parent
	node = start

	while node != stop
		carrier << node
		puts node.text
		node = node.next
	end
	
	return carrier

end
