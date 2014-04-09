require 'google-search'

load "/home/papri/git_work/dqscripts/songboot.rb"

temp = []
i = 0
@toplist.each do |t|
	
	q = t[1] + ' ' + t[2] + ' ' + 'soundcloud'
	
	@gpages = []
	
	Google::Search::Web.new(:query => q).each do |w|
			@gpages << w.uri
			if @gpages.length > 2
				break
			end
	end
	
	temp = []
	@gpages.each do |g|
		if g.include?('soundcloud') and g.split('/').length == 5
			temp << g
		end
	end

	t << [temp[0]]
	
	puts t[1] + ' ' + t[2]
	i = i + 1
	puts i

end
