load '/home/papri/git_work/dqscripts/oscorpus/oscorpus.rb'
load '/home/papri/git_work/dqscripts/oscorpus/corpus.rb'

def corpus_init(cat)
	@oscorpus[cat] = {}
	@corpus[cat].each do |t|
		@oscorpus[cat][t[0]] = {}		
	end
	desccorpus(cat)
	techopedia(cat)
end

def desccorpus(cat)

	@corpus[cat].each do |t|
		puts t[0]
		@oscorpus[cat][t[0]]['desc'] = []
		puts t[0]
		t[1].each do |u|
			if u[1].include?('webopedia')
				@oscorpus[cat][t[0]]['desc'] << u[1]
				puts u[1]
				break
			end
		puts "hello"
		end
	end
	File.open('/home/papri/git_work/dqscripts/oscorpus/oscorpus.rb','w'){|file| file.write("# encoding: UTF-8" + "\n\n@oscorpus = " + @oscorpus.to_s)}
end

def techopedia(cat)
	load '/home/papri/git_work/dqscripts/oscorpus/oscorpus.rb'
	@corpus[cat].each do |t|
		Google::Search::Web.new(:query => t[0] + "techopedia").each do |w|
			if w.uri.include?('techopedia')
				@oscorpus[cat][t[0]]['desc'] << w.uri
				puts w.uri
				break
			end
		end
	end
end
