load "/home/papri/git_work/dqscripts/algoboot.rb"
@cats["Machine learning algorithms"] = []

@doc = Nokogiri::HTML(open("http://en.wikipedia.org/wiki/List_of_algorithms"))
@node = @doc.css("span#Machine_learning_and_statistical_classification")[0].parent
@stop = @doc.css("span#Programming_language_theory")[0].parent

while @node != @stop
	@node = @node.next
	begin
			@node.css("li").each do |l| 
			if !@cats["Machine learning algorithms"].include?(l.css('a')[0]['title'])
				@cats["Machine learning algorithms"] << l.css('a')[0]['title']
				puts l.css('a')[0]['title']
			end
			end
	rescue
	end
end

puts @cats
