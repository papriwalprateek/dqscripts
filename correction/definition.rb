x = Wikialgo.all.to_a

x.each do |t|

	File.open('/home/papri/git_work/dqscripts/correction/defpage.html','a'){|f| f.puts "<h2>"+t.title+"</h2>\n"}
	t.descriptions.each do |d|
			File.open('/home/papri/git_work/dqscripts/correction/defpage.html','a'){|f| f.puts "<p>"+d.content+"</p>\n"}
	end
end
