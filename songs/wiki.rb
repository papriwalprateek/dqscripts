require 'google-search'

load "/home/papri/git_work/dqscripts/songboot.rb"

i = 0

@wikilist = []

@toplist.each do |t|
	
	q = t[1] + ' ' + t[2] + ' ' + 'wikipedia'
	
	@gpages = []
	
	Google::Search::Web.new(:query => q).each do |w|
			@gpages << w.uri
			if @gpages.length > 2
				break
			end
	end
	
	temp = []
	@gpages.each do |g|
		if g.include?('wikipedia')
			temp << g
		end
	end
	
	@wikilist << temp[0]
	
	puts temp[0]
	i = i + 1
	puts i

end
