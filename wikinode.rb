#		j = 0
#        htag = -1
#        
#        @math_tags = ["solving","combinatorics","math","proof","relation","formulas","correctness"]  # This is tag array which empowers the math method
#        
#        while j < @doc.css("h2 > span").length
#            @math_tags.each do |x|
#                if @doc.css("h2 > span")[j].text.downcase.include?(x)
#                    htag = j
#                end
#            end
#            if htag >= 0
#                j = @doc.css("h2 > span").length
#            end
#            j = j + 1
#       end
        
#        if htag >= 0
#         @math = []

# The doc passed through this function has no editsection h2's
		node = doc.css('h2 > span')[htag].parent
		stop = doc.css('h2 > span')[htag+1].parent

         
	def nodesextract(doc,node,stop)
		@content = []
		node = node.next
		while node!=stop
			@content << node
			node = node.next
		end
	end
