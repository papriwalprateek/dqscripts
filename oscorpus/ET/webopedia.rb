def webopedia_extract(url)
	@doc = Nokogiri::HTML(open(url))
	@carrier = []
	@carrier << @doc.css('h1')
	start = @doc.css('div.article_related_items')[0]
	stop = @doc.css('div#olal-container')	
	node = start

	while node != stop[0]
		node = node.next
		@carrier << node
	end
	
	return @carrier

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
