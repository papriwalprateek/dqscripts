load "/home/papri/git_work/dqscripts/algoboot.rb"
@cats["Optimization algorithms"] = []

@doc = Nokogiri::HTML(open("http://en.wikipedia.org/wiki/List_of_algorithms"))
@node = @doc.css("span#Optimization_algorithms")[0].parent
@stop = @doc.css("span#Computational_science")[0].parent

while @node != @stop
	@node = @node.next
	begin
			@node.css("li").each do |l| 
			if !@cats["Optimization algorithms"].include?(l.css('a')[0]['title'])
				@cats["Optimization algorithms"] << l.css('a')[0]['title']
				puts l.css('a')[0]['title']
			end
			end
	rescue
	end
end

puts @cats
