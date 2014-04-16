load '/home/papri/git_work/dqscripts/songcorpus/bollycorpus.rb'

def basic
@doc = Nokogiri::HTML(open('http://gaana.com/mostpopular/hindi/tracks'))

sna = @doc.css('div.sngandalbum')

sna.each do |t|
	@bollycorpus[t.css('a')[0].text] = {}
	@bollycorpus[t.css('a')[0].text]['album'] = t.css('a')[1].text
end
end

def gaanasearch
	@bollycorpus.each do |b|
		file = open('http://api.gaana.com/index.php?type=search&subtype=search_song&key='+URI.encode(b[0]))
		json = file.read
		parsed = JSON.parse(json)
		b[1]['gaana_id'] = parsed.first[1][0]['track_id']
		b[1]['imgs'] = [parsed.first[1][0]['artwork'],parsed.first[1][0]['artwork_large']]
		puts b[0]
	end
end

def youtube
	i = 0
	@list = {}
	for i in 0..39
	x = @bollycorpus.keys[i]
	t = @bollycorpus[x]
	
	q = x + ' ' + t['album'] + ' ' + 'official youtube'
	
	@gpages = []
	
	Google::Search::Web.new(:query => q).each do |w|
			@gpages << w.uri
			if @gpages.length > 10
				break
			end
	end
	
	
	temp = []
	@gpages.each do |g|
		if g.include?('youtube')
			temp << g.split('http://www.youtube.com/watch?v=')[1]
		end
	end
	
	@list[x] = temp
	
	puts temp
	i = i + 1
	puts i
	
	end
end


def soundcloud(query)
	client = Soundcloud.new(:client_id => 'a2728d49c18b6d9e1af6e92311bec46a')
	tracks = client.get('/tracks', :q => query, :limit=>5, :order => 'hotness')
	trks = []
	for i in 0..4
		begin
			trks[i] = tracks[i].uri.split('/')[4]
		rescue
			break
		end
	end
	
	return trks
end

def audio_extract 
	
	for i in 0..39
		x = @bollycorpus.keys[i]
		b = @bollycorpus[x]
		q = x + " " + b['album']
		ext = soundcloud(q)
		b['audio_sc'] = ext
		puts ext
		puts q
		i = i + 1
		puts i
	end
end


def lyrics
	i = 0
	@list = {}
	for i in 0..39
	x = @bollycorpus.keys[i]
	t = @bollycorpus[x]
	
	q = x + ' ' + t['album'] + ' '+ 'lyrics'
	
	@doc = Nokogiri::HTML(open('http://www.lyricsmint.com/search?q=' + q.gsub(' ','+')))
	tempurls = []
	
	@doc.css('div.post-title a').each do |a|
		tempurls << a['href']
	end
	
	tempurls.each do |t|
		@doc = Nokogiri::HTML(open(t))
		
		if @doc.css('div#lyric')[0] != nil
			@list[x] = t
			break
		end
	end
	
	puts x
	puts @list[x]
	
	end
end
