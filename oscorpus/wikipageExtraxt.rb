load '/home/papri/git_work/dqscripts/oscorpus/oscorpus.rb'
load '/home/papri/git_work/dqscripts/oscorpus/corpus.rb'

def wikipage_extract
	@oscorpus.each do |k,v|
		v.each do |t|
			@corpus[k][t[0]].each do |u|
				if u[1].include?('wikipedia')
					@oscorpus[k][t[0]]['wikipage'] = u[1]
					break
				end
			end
		end
	end
end
