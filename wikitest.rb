a=property_url

out_details=[]   #same work as @arr but only for this code
@pseudocode=[]
@math=[]
@wiki_definition=[]
@algorithm=[]
@related_algorithm=[]
@cmplx=[]
if @arr==nil
    @arr=[]
end

def nodesextract(doc,node,stop)
		content = []
		node = node.next
		while node!=stop
			content << node
			node = node.next
		end
		return content
end

def show_content(content)
	content.each do |c|
		puts c.text
	end
end

def find_htag(doc,taglist)

        j = 0
        htag = -1        
        while j < doc.css("h2 > span").length
            taglist.each do |x|
                if doc.css("h2 > span")[j].text.downcase.include?(x)
                    htag = j
                end
            end
            if htag >= 0
                j = doc.css("h2 > span").length
            end
            j = j + 1
        end
        
        return htag
end


if a
        print "inside algorithm vm"
        require 'nokogiri'
        require 'open-uri'
        puts a
        catch = false
        begin
            b = URI.encode(a)
            doc = Nokogiri::HTML(open(a))
            rescue
            begin
                
                doc = Nokogiri::HTML(open(b))
                print b
                print "rescue mein"
                rescue
                print "second rescue mein"
                catch = true
            end
        end
        
        
        redirect = doc.css('li').children.text.split(' ')
        redirect = redirect[0]
        if redirect.include?'REDIRECT'
            print "This is redirect case"
            a = a.to_s.gsub ' ', '_'
            doc = Nokogiri::HTML(open("http://en.wikipedia.org/wiki/"+a))
        end

        rem_nodes = ['table.ambox','.portal','table.infobox','table.vertical-navbox','div.thumbinner','span.mw-editsection','div#toc','table.navbox','table.metadata','//comment()','sup.reference']
        rem_nodes.each do |r|
			x = doc.css(r)
			x.remove
        end
        
        uri = URI.parse(a)
        base = "#{uri.scheme}://#{uri.host}"
        doc.css('a').each do |l|
			if l['href']
			if l['href'][0] == "#"
				l['href'] = a + l['href']
			elsif l['href'][0] == '/'
				l['href'] = base + l['href']
			end
			end
        end
        
        # wiki_definition
        
        node = doc.css("p")[0]
        begin
			stop = doc.css("h2 > span")[0].parent
        rescue
			stop = nil
        end
        while node!=stop
			@wiki_definition << node
			node = node.next
		end
		
        if @wiki_definition != []
            @arr<<"algo_description"
            show_content(@wiki_definition)
        end
		
		store_htags = [] # This stores the unique htags to avoid any repetitive content. This problem is present in LIS algorithm
		
        # Algorithm
                
        algo_tags = ["algorithm","definition","description","encoding","overview","operation","description","example"]
        htag = find_htag(doc,algo_tags)
        
        if htag >= 0 and !store_htags.include?(htag)
			store_htags << htag
            node = doc.css("h2 > span")[htag].parent
            begin
            stop = doc.css("h2 > span")[htag+1].parent
            rescue
            stop=nil
            end
            @algorithm = nodesextract(doc,node,stop)
        end
                
        # Algo Complexity
        
		cmplx_tags = ["efficiency","complexity","time","analysis","best","worst","average"]  # This is array of semantic tags which tags content related to algorithm complexity

		htag = find_htag(doc,cmplx_tags)

        if htag >= 0 and !store_htags.include?(htag)
			store_htags << htag
            node = doc.css("h2 > span")[htag].parent
            stop = doc.css("h2 > span")[htag+1].parent
            @cmplx = nodesextract(doc,node,stop)
        end    
        
        if @algorithm != [] or @cmplx != []
            @arr<<"algo_examples"
            puts "algorithm"
            show_content(@algorithm)
            puts "complexity"
            show_content(@cmplx)
        end

        # Pseudocode
        
        pseudocode_tags = ["pseudocode","implementation"]
		htag = find_htag(doc,pseudocode_tags)

        if htag >= 0 and !store_htags.include?(htag)
			store_htags << htag
            node = doc.css("h2 > span")[htag].parent
            begin
				stop = doc.css("h2 > span")[htag+1].parent
            rescue
				stop = nil
			end
			@pseudocode = nodesextract(doc,node,stop)
        end
        
        if @pseudocode != []
            @arr<<"code"
            puts "pseudocode"
            show_content(@pseudocode)
        end
		# Mathematical Insights
        
		math_tags = ["solving","combinatorics","math","proof","relation","formulas","correctness"]  # This is tag array which empowers the math method
		
		htag = find_htag(doc,math_tags)
        
        if htag >= 0 and !store_htags.include?(htag)
			store_htags << htag
            node = doc.css("h2 > span")[htag].parent
            stop = doc.css("h2 > span")[htag+1].parent			
            @math = nodesextract(doc,node,stop)            
        end
        
        if @math != []
            @arr<<"math_analysis"
            out_details<<"math_analysis"
            puts "math"
            show_content(@math)
        end
		puts "Code ends here" 
		puts @arr
		@doc = doc
end
