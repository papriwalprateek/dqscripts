require 'google-search'

load "/home/papri/git_work/dqscripts/songboot.rb"

i = 0

@list = {}

@toplist.each do |t|
	
	q = t[1] + ' ' + t[2] + ' ' + 'lyricsnmusic.com'
	
	@gpages = []
	
	Google::Search::Web.new(:query => q).each do |w|
			@gpages << w.uri
			if @gpages.length > 20
				break
			end
	end
	
	
	temp = []
	@gpages.each do |g|
		if g.include?('lyricsnmusic') and g.split('/').length == 6
			temp << g
		end
	end
	
	@list[t[1]] = temp[0]
	
	puts temp[0]
	i = i + 1
	puts i
end
