@arr = []

def algorithm_wiki(a)
  if a
    puts "inside algorithm vm"
    require 'media_wiki'
    require 'nokogiri'
    require 'open-uri'
    require 'wikicloth'
   puts a
    @catch = false
    begin
  b = URI.encode(a)
   @doc = Nokogiri::HTML(open(a))
    rescue 
    begin
   
   @doc = Nokogiri::HTML(open(b))
   puts b
     puts "rescue mein"
    rescue 
     puts "second rescue mein"
    @catch = true
    end
    end

    @wiki_definition = []

    redirect = @doc.css('li').children.text.split(' ')
    redirect = redirect[0]
    if redirect.include?'REDIRECT'
    print "This is redirect case"
    a = a.to_s.gsub ' ', '_'
    @doc = Nokogiri::HTML(open("http://en.wikipedia.org/wiki/"+a))
    end
    
    x = @doc.css("table.ambox")
    x.remove
      x = @doc.css(".portal")
    x.remove
     infobox = @doc.css("table.infobox")
    infobox.remove
	x = @doc.css('table.vertical-navbox')
	x.remove

  @node = @doc.css("p")[0]
  @stop = @doc.css("div#toc")[0]
  @stop1 = @doc.css("h2 > span")[0].parent
  
  while @node!=@stop and @node!=@stop1
      @wiki_definition << @node
      @node = @node.next 
    end 
     if infobox
    @wiki_definition << @doc.css("table.infobox")
  end
  puts @wiki_definition
#  if @doc.css("a.image")[0]
#  @wiki_definition << @doc.css("a.image")[0]
#  x = @doc.css("a.image")[0]
#  x.remove
#  end

  if @doc.css("table.infobox")
  @wiki_definition << @doc.css("table.infobox")
  end

  if @wiki_definition != []
       @arr<<"algo_description"
  end

# Mathematical Insights

  j = 0
  htag = -1
  
  @math_tags = ["solving","combinatorics","math","proof","relation","formulas","correctness"]  # This is tag array which empowers the math method
  
  while j < @doc.css("h2 > span").length
      @math_tags.each do |x|
      if @doc.css("h2 > span")[j].text.downcase.include?(x) 
        htag = j
      end
      end
      if htag >= 0
        j = @doc.css("h2 > span").length
      end
      j = j + 1
  end
  
  if htag >= 0
    @math = []
    @node = @doc.css("h2 > span")[htag].parent
    @stop = @doc.css("h2 > span")[htag+2].parent
    
    editsec = @doc.css("span.mw-editsection")
    editsec.remove
    
    @node = @node.next
    while @node!=@stop
      @math << @node
      @node = @node.next 
    end
    if @math != []
       @arr<<"math_analysis"
    end

  end

# Algo Complexity 
    
  j = 0
  htag = -1
  @cmplx_tags = ["efficiency","complexity","time","analysis","best","worst","average"]  # This is array of semantic tags which tags content related to algorithm complexity 
  
  while j < @doc.css("h2 > span").length
      @cmplx_tags.each do |x|
      if @doc.css("h2 > span")[j].text.downcase.include?(x)
        htag = j
      end
      end
      if htag >= 0
        j = @doc.css("h2 > span").length
      end
      j = j + 1
  end
  @cmplx = []
  if htag >= 0
    @node = @doc.css("h2 > span")[htag].parent
    @stop1 = @doc.css("h2 > span")[htag+1].parent
    @stop = @doc.css("h2 > span")[htag+2].parent
    
    editsec = @doc.css("span.mw-editsection")
    editsec.remove
    
    @node = @node.next
    while @node!=@stop and @node!=@stop1
      @cmplx << @node
      @node = @node.next 
    end
  end



# Algorithm

  j = 0
  htag = -1
  
  @algo_tags = ["algorithm","definition","description","encoding","overview","operation"]
  
  while j < @doc.css("h2 > span").length
      @algo_tags.each do |x|
      if @doc.css("h2 > span")[j].text.downcase.include?(x) 
        htag = j
      end
      end
      
      if htag >= 0
        j = @doc.css("h2 > span").length
      end
      j = j + 1
  end
  @algorithm = []
  if htag >= 0

    @node = @doc.css("h2 > span")[htag].parent
    @stop1 = @doc.css("h2 > span")[htag+1].parent
    @stop = @doc.css("h2 > span")[htag+2].parent
    
    editsec = @doc.css("span.mw-editsection")
    editsec.remove
    
    @node = @node.next
    while @node!=@stop and @node!=@stop1
      @algorithm << @node
      @node = @node.next 
    end
  end
  
  if @algorithm != [] or @cmplx != []
      @arr<<"algo_examples" 
  end


# Pseudocode

  j = 0
  htag = -1
  
  @pseudocode_tags = ["pseudocode","implementation"]
  
  while j < @doc.css("h2 > span").length
      @pseudocode_tags.each do |x|
      if @doc.css("h2 > span")[j].text.downcase.include?(x) 
        htag = j
      end
      end
      
      if htag >= 0
        j = @doc.css("h2 > span").length
      end
      j = j + 1
  end
  if htag >= 0
    @pseudocode = []
    @node = @doc.css("h2 > span")[htag].parent
    @stop1 = @doc.css("h2 > span")[htag+1].parent
    @stop = @doc.css("h2 > span")[htag+2].parent
    
    editsec = @doc.css("span.mw-editsection")
    editsec.remove
    
    @node = @node.next
    while @node!=@stop and @node!=@stop1
      @pseudocode << @node
      @node = @node.next 
    end
  end
  
  if @psuedocode != [] && @pseudocode!=nil
    
       @arr<<"code"
  end


# Related algorithms

  j = 0
  htag = -1
  
  @related_algo_tags = ["see also"]  # This is tag array which empowers the related algorithms method
  
  while j < @doc.css("h2 > span").length
      @related_algo_tags.each do |x|
      if @doc.css("h2 > span")[j].text.downcase.include?(x) 
        htag = j
      end
      end
      if htag >= 0
        j = @doc.css("h2 > span").length
      end
      j = j + 1
  end
  
  @related_algorithm = []
  if htag >= 0

    @node = @doc.css("h2 > span")[htag].parent
    @stop = @doc.css("h2 > span")[htag+2].parent
    @stop1= @doc.css("h2 > span")[htag+1].parent
    
    editsec = @doc.css("span.mw-editsection")
    editsec.remove
    
    @node = @node.next
    while @node!=@stop and @node!=@stop1
      begin 
      @node.css('a').each do |c|
      c.attributes["href"].value = "/search?search=" + c.attributes["title"].value
      end
      rescue
      end
      @related_algorithm << @node
      @node = @node.next 
    end
  end
  
  if @related_algorithm != []
      @arr<<"algo_related"
  end
  
  end
  end
  
  algorithm_wiki('http://en.wikipedia.org/wiki/Bloom_filter')
