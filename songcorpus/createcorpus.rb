load '/home/papri/git_work/dqscripts/songcorpus/base.rb'
#load '/home/papri/git_work/dqscripts/songcorpus/lastfmcorpus.rb'

#@base = {}

#@toptracks.each do |t|
#	@base[t['name']] = {}
#	
#	@base[t['name']]['artist'] = t['artist']['name']
#	@base[t['name']]['lfm_url'] = t['url']
#	
#	if t['image'] != nil
#		@base[t['name']]['imgs'] = [t['image'][0]['content'],t['image'][1]['content']]
#	end
#	
#end



def extract(lfm_url)
	@doc = Nokogiri::HTML(open(lfm_url))
	begin
	yt = @doc.css('.wrapper')[0].attributes['data-youtube-player-id'].value
	rescue
	yt = nil
	end
	begin
	lyr = @doc.css('p.lyrics-snippet')[0].next.next.attributes['href'].value
	rescue
	lyr = nil
	end
	return [yt,lyr]

end

def main_extract
	@base.each do |b|
	ext = extract(b[1]['lfm_url'])
	b[1]['off_vid'] = ext[0]
	b[1]['lyrics'] = ext[1]
	puts ext 
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
	
	for i in 212..999
		x = @base.keys[i]
		b = @base[x]
		q = x + " by " + b['artist']
		ext = soundcloud(q)
		b['audio'] = ext
		puts ext
		puts q
		i = i + 1
		puts i
	end
end
