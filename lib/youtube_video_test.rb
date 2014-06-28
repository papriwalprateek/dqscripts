x = Entity.where(type:'/dqs/videopage')

x.each do |l|
	puts l.url
	if l.url.include?('embed')
	elsif l.url.include?('watch')
		t = l.url.gsub(/watch/,'embed')
		puts "changed to embed from watch"
	else
		y = EntityLib::DeleteTree.new
		y.delete_source_entity(l.id)
		puts "deleted source entity"
	end
end