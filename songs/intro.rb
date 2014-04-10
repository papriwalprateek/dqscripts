require 'nokogiri'

@doc = Nokogiri::HTML(open('http://en.wikipedia.org/wiki/Let_It_Go_%28Disney_song%29'))

puts @doc

@wiki_definition = []

	x = @doc.css("table.ambox")
    x.remove
    x = @doc.css(".portal")
    x.remove
    x = @doc.css('table.vertical-navbox')
	x.remove


# @wiki_definition << @doc.css("p")[0]
  @node = @doc.css("p")[0]
  @stop = @doc.css("div#toc")[0]
  @stop1 = @doc.css("h2 > span")[0].parent
  
  while @node!=@stop and @node!=@stop1
      @wiki_definition << @node
      @node = @node.next 
  end 
  
  if @doc.css("table.infobox")
  @wiki_definition << @doc.css("table.infobox")
  end
