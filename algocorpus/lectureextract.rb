# encoding: UTF-8

require 'google-search'
load '/home/papri/git_work/dqscripts/algocorpus/mongoentities.rb'

def lectures
	@corpus = {}
	t = 0
	@mongoties.each do |k|
	@corpus[k] = []
	t = t + 1
	puts t.to_s + " " + k
	@gpages = []
	Google::Search::Web.new(:query => k.gsub('â€“','-')).each do |w|
			@gpages << [w.title,w.uri]
	end
		
	@resources = []
	@uniquedocs = []
	formatregex = /.pdf|.ppt/
	puts @gpages.length
	if @gpages.length != 0
	n = 10
	if @gpages.length < 10
		n = @gpages.length
	end
	n.times do |j|
		if @gpages[j][1] =~ formatregex and @resources.length < 4
			if !@uniquedocs.include?(@gpages[j][1])
				@uniquedocs << @gpages[j][1]
				@resources << @gpages[j]
			end
		end
	end
	else
		@resources = []
	end
	puts @resources
	@corpus[k] = @resources

	end
	
end
