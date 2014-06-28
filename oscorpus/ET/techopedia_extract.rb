a = property_url
#a = "http://www.techopedia.com/definition/3410/pipe"
whitenodes = [['div.techopedia_intellitxt',0]]
doc = Nokogiri::HTML(open(a))
@carrier = []

whitenodes.each do |w|
		if w[1] == -1
			temp = doc.css(w[0])
			temp.each do |t|
				@carrier << t
			end
		else
			temp = doc.css(w[0])[w[1]]
			@carrier << temp
		end
end

