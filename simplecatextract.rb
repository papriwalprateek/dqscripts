load "algoboot.rb"
@cats["Graph algorithms"] = []

@node = @doc.css("span#Graph_algorithms")[0].parent
@stop = @doc.css("span#Sequence_algorithms")[0].parent

while @node != @stop
	@node = @node.next
	begin
		@node.css("li > a").map {|a| @cats["Graph algorithms"] << a["title"]}
	end
end

puts @cats
