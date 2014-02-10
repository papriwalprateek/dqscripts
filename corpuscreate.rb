require 'google-search'
#load "/home/papri/dqscripts/algoboot.rb"
load '/home/papri/Downloads/git_work/dqscripts/svm/svm_predict.rb'

@cats ={"Graph algorithm"=>["Prim's algorithm"]}


@corpus = {}
@cats.each do |k,v|

	@corpus[k] = {}
	puts @corpus

	v.each do |t|
		puts t
		@gpages = []

		Google::Search::Web.new(:query => t).each do |w|
			@gpages << [w.title,w.uri]
		end 


	whiteregex = /en.wikipedia|youtube|rosetta|geeksforgeeks|cprogramming.com|personal.kent|nist|algolist|wikiversity|wolfram|programmingsimplified/
	blackregex = /wikimedia|.pdf|.doc|.txt|.ppt|itunes|khanacademy|.gif|.pps|nanamic|freevbcode|scratched|download|reddit|interactivepython.org|google|yahoo|prezi|amazon|cyclopaedia|reference|researchgate|quitebasic|download|animated|compiledreams|facebook|sciencedirect|barnesandnoble|opensourcescripts|slideshare|sriptol|scribd|sourcecode|teachingtree|yahoo/


	@resources = []
	@uniquelinks = []

	@gpages.each do |t,l|
		if l =~ whiteregex
			puts l
			@resources << [t,l]
			@uniquelinks << l
		end
	end

#	10.times do |j|
#		if !(@gpages[j][1] =~ whiteregex) and !(@gpages[j][1] =~ blackregex)
#			if svm_predict(@gpages[j][1]) == 1.0
#				puts @gpages[j][1]
#				@resources << @gpages[j]
#				@uniquelinks << @gpages[j][1]
#			end
#		end
#	end

# Duckduckgo results extraction

	@doc = Nokogiri::HTML(open(URI.encode("https://api.duckduckgo.com/html?q="+t.gsub(/ |_/,"+"))))
	x = @doc.css(".web-result-sponsored")
	x.remove
	@carrier = @doc.css("div.web-result a.large")
	@carrier.each do |c|
		pred = svm_predict(c["href"])
		puts pred
		if !@uniquelinks.join.include?(c["href"].gsub(/https:\/\/|http:\/\//,"")) and !(c["href"] =~ blackregex) and pred == 1.0
	  		puts c["href"]
			@resources << [c.text,c["href"]]			
			@uniquelinks << c["href"]
		end
	end


#saving the whitelist resources


	@corpus[k][t] = @resources

end
end

