def songfacts_extract(url)
	@doc = Nokogiri::HTML(open(url))
	@sf = @doc.css('div.boxcontent')	
end


def usatoday(url)
	@news = []
	@doc = Nokogiri::HTML(open(url))
	results = @doc.css('li.search-result-item')
	labels = ['TV', 'Music', 'Theatre']
	
	results.each do |r|
	if labels.include?(r.css('span.parent-label').text)
	begin
	newsurl = "http://www.usatoday.com"+r.css('a')[0]['href']
	rescue
	newsurl = nil
	end
	begin
	img = r.css('figure > img')[0]['src']
	rescue
	img = nil
	end
	begin
	headline = r.css('div.back > h3').text
	rescue
	headline = nil
	end
	begin
	desc = r.css('div.back > p.text').text
	rescue
	desc = nil
	end
	begin
	date = r.css('span.date-created')[0].text
	rescue
	date = nil
	end
	@news << [newsurl,img,headline,desc,date]
	end
	end
end


def faroomusic(url)
	@doc = Nokogiri::HTML(open(url))
	results = @doc.css('result')
	
end

def lyricsmint(url)
	@doc = Nokogiri::HTML(open(url))
	@lyrics = @doc.css('div#lyric')
	x = @lyrics.css('h2')
	x.remove
	return @lyrics
end
