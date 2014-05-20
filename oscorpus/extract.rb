require 'google-search'
load '/home/papri/git_work/dqscripts/svm/svm_predict.rb'
load '/home/papri/git_work/dqscripts/oscorpus/osboot.rb'


def lectures
	@corpus = {}

	@entities.each do |k,v|

	@corpus[k] = {}
	puts @corpus

	v.each do |t|
		puts t
		@gpages = []

		Google::Search::Web.new(:query => t + "lecture").each do |w|
			@gpages << [w.title,w.uri]
		end
	
	@resources = []
	
	10.times do |j|
		puts @gpages[j][1]
		@resources << @gpages[j]
	end
	
	@corpus[k][t] = @resources

	end
	end
	
end
