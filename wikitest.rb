a="http://en.wikipedia.org/wiki/Gauss%E2%80%93Newton_algorithm"
out_details=[]   #same work as @arr but only for this code
@pseudocode=nil
@math=nil
@wiki_definition=nil
@algorithm=nil
@related_algorithm=nil
@cmplx=nil
if @arr==nil
    @arr=[]
    end
if a
        print "inside algorithm vm"
        require 'nokogiri'
        require 'open-uri'
        puts a
        @catch = false
        begin
            b = URI.encode(a)
            @doc = Nokogiri::HTML(open(a))
            rescue
            begin
                
                @doc = Nokogiri::HTML(open(b))
                print b
                print "rescue mein"
                rescue
                print "second rescue mein"
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
        print(1)
        x = @doc.css("table.ambox")
        x.remove
        x = @doc.css(".portal")
        x.remove
        infobox = @doc.css("table.infobox")
        infobox.remove
        x = @doc.css('table.vertical-navbox')
        x.remove
        x = @doc.css('div.thumbinner')
        x.remove
        # @wiki_definition << @doc.css("p")[0]
        @node = @doc.css("p")[0]
        @stop = @doc.css("div#toc")[0]
        begin
        @stop1 = @doc.css("h2 > span")[0].parent
        rescue
		@stop1 = nil
        end
        puts @stop1
        
        while @node!=@stop and @node!=@stop1
            @wiki_definition << @node
            @node = @node.next
        end
        if infobox
            @wiki_definition << @doc.css("table.infobox")
        end
        
        if @doc.css("table.infobox")
            @wiki_definition << @doc.css("table.infobox")
        end
        
        if @wiki_definition != []
            @arr<<"algo_description"
        end
        print(1)
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
            print(2)
            @node = @doc.css("h2 > span")[htag].parent
            print(3)
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
                out_details<<"math_analysis"
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
            print 4
            @node = @doc.css("h2 > span")[htag].parent
            @stop1 = @doc.css("h2 > span")[htag+1].parent
            print 5
            @stop = @doc.css("h2 > span")[htag+2].parent
            print 6
            
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
            begin
            @stop = @doc.css("h2 > span")[htag+2].parent
            rescue
            @stop=nil
            end
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
            puts 'heyyy ' + htag.to_s 
            
            @node = @doc.css("h2 > span")[htag].parent
            @stop1 = @doc.css("h2 > span")[htag+1].parent
            begin
				@stop = @doc.css("h2 > span")[htag+2].parent
            rescue
				@stop = nil
			end
            editsec = @doc.css("span.mw-editsection")
            editsec.remove
            
            @node = @node.next
            while @node!=@stop and @node!=@stop1
                @pseudocode << @node
                @node = @node.next
            end
        end
        
        if @pseudocode != [] && @pseudocode!=nil
            
            @arr<<"code"
        end
       puts "pkjkjkjkj" 
    end
