load "/home/papri/Downloads/git_work/dqscripts/algoboot.rb"
@cats["Trees (data structure)"] = []

@doc = Nokogiri::HTML(open("http://en.wikipedia.org/wiki/List_of_data_structures"))
@node = @doc.css("span#Trees")[0].parent
@stop = @doc.css("span#Hashes")[0].parent

while @node != @stop
	@node = @node.next
	begin
		@node.css("li > a").each do |a| 
			if !@cats["Trees (data structure)"].include?(a["title"])
				@cats["Trees (data structure)"] << a["title"]
				puts a['title']
			end
		end
	end
end

puts @cats
