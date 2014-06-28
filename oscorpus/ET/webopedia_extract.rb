	a = property_url
#	a = "http://www.webopedia.com/TERM/P/polling.html"
	doc = Nokogiri::HTML(open(a))
	@carrier = []
	x = doc.css('comment()')
	x.remove
	
	start = doc.css('div.article_related_items')[0]
	stop = doc.css('div#olal-container')	
	node = start.next

	while node != stop[0]
		node.css('img').each do |x|
		if x['src'][0] == '/'
		x['src'] = "http://www.webopedia.com" + x['src']
		end
		end
		node.css('a').each do |x|
		if x['href'][0] == '/'
		x['href'] = "http://www.webopedia.com" + x['href']
		end
		end
		@carrier << node
		node = node.next
	end
	