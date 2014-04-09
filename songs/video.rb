require 'google-search'

load "/home/papri/git_work/dqscripts/songboot.rb"

temp = []

@toplist.each do |t|
	
	q = t[1] + ' ' + t[2] + ' ' + 'official'
	
	@gpages = []
	
	Google::Search::Web.new(:query => q).each do |w|
			@gpages << [w.title,w.uri]
			if @gpages.length > 2
				break
			end
	end
	
	temp = []
	@gpages.each do |g|
		if g[1].include?('youtube') or g.include?('vevo')
			temp << g
		end
	end

	t << temp
	
	puts temp
	

end
