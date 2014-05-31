load '/home/papri/git_work/dqscripts/oscorpus/oscorpus.rb'
load '/home/papri/git_work/dqscripts/oscorpus/corpus.rb'

def desccorpus
	@corpus['Basic Concepts'].each do |t|
		puts t[0]
		@oscorpus['Basic Concepts'][t[0]]['desc'] = []
		puts t[0]
		t[1].each do |u|
			if u[1].include?('webopedia')
				@oscorpus['Basic Concepts'][t[0]]['desc'] << u[1]
				puts u[1]
				break
			end
		puts "hello"
		end
	end
end

def techopedia
	load '/home/papri/git_work/dqscripts/oscorpus/oscorpus.rb'
	@corpus['Basic Concepts'].each do |t|
		Google::Search::Web.new(:query => t[0] + "techopedia").each do |w|
			if w.uri.include?('techopedia')
				@oscorpus['Basic Concepts'][t[0]]['desc'] << w.uri
				puts w.uri
				break
			end
		end
	end
end

