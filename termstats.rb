@termfreq = {}
@glinks.each do |l|
   puts l
   y = DQReadability::Document.new(l,:tags=>%w[div pre p h1 h2 h3 h4 td table tr b a img br li ul ol strong sup sup center br hr blockquote em strong sup sub],:attributes=>%w[href src align width color]).content
   File.open("/home/papri/x2.html","w"){|file| file.write(y)}
   @doc = Nokogiri::HTML(open("/home/papri/x2.html"))
   @terms = @doc.text.split(/ |,|\?/)
   @terms.each do |t|
       if !(@x.include?(t))
          if @termfreq[t] == nil
             @termfreq[t] = 0
          end
        @termfreq[t] = @termfreq[t] + 1
       end
    end
    puts @termfreq
 end
