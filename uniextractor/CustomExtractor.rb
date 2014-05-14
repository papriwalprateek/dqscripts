require 'nokogiri'

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
