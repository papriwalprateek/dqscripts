load '/home/papri/git_work/dqscripts/oscorpus/oscorpus.rb'

def dia_extract
	@oscorpus.each do |k,v|
		v.each do |t|
			@resources = []
			Google::Search::Image.new(:query=>t[0]).each do |w|
				@resources << w.uri
				if @resources.length > 9
					break
				end
			end
			puts t[0]
			puts @resources
			
			@oscorpus[k][t[0]]['daiagrams'] = @resources
		end
	end
end
