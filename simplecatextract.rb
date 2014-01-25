load "~/dqscripts/algoboot.rb"
@cats["Graph algorithms"] = []

@doc = Nokogiri::HTML(open("http://en.wikipedia.org/wiki/List_of_algorithms"))
@node = @doc.css("span#Graph_algorithms")[0].parent
@stop = @doc.css("span#Sequence_algorithms")[0].parent

while @node != @stop
	@node = @node.next
	begin
		@node.css("li > a").each do |a| 
			if !@cats["Graph algorithms"].include?(a["title"])
				@cats["Graph algorithms"] << a["title"]
			end
		end
	end
end

puts @cats
