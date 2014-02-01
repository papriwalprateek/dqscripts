@corpus["Sequence sorting"].each do |k,v|
     v.each do |l|
       begin
       y = DQReadability::Document.new(l[1],:tags=>%w[div pre p h1 h2 h3 h4 td table tr b a img br li ul ol center br hr blockquote em strong sub sup],:attributes=>%w[href src align width  color]).content
       File.open("/home/papri/x1.html","w"){|file| file.write(y)}
	   y = Nokogiri::HTML(open("/home/papri/x1.html"))
	   
       l << y.css("img")[0]["src"]
       rescue
			puts "no img"
	   end
       puts l[2]
     end
   end
