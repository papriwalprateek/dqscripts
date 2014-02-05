
@svm_vector = []
@glinks.each do |g|
	begin
	y = DQReadability::Document.new(g,:tags=>%w[div pre p h1 h2 h3 h4 td table tr b a img br li ul ol center br hr blockquote em strong sup sub],:attributes=>%w[href src align width color]).content
	File.open('/home/papri/x2.html','w'){|file| file.write(y)}
	y = Nokogiri::HTML(open('/home/papri/x2.html'))
	
	termregex = /algorithm|element|value|\>|\<|\=|\-|code|complexity|graph|psuedo|program/
	tc = 0
	@terms = y.text.split(/ |,|\?/)
	@terms.each do |t|
		if t =~ termregex
			tc = tc + 1
		end
	end
	# svm vector 8 features
	# features [no_of_words,no_of_links,no_of_paras,no_of_imgs,no_of_htags,no_of_codeblocks,linkdensity,term_count]
	@svm_vector << [y.text.split.length,y.css('a').length,y.css('p').length,y.css('img').length,y.css('h3').length,y.css('pre').length, y.css('a').length*1.0/(y.text.split.length+1),tc]
	rescue
		@svm_vector <<  [0,0,0,0,0,0,0,0,0]
	end
	puts g
end
