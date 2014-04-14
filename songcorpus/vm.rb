def songfacts_extract(url)
	@doc = Nokogiri::HTML(open(url))
	@sf = @doc.css('div.boxcontent')	
end
