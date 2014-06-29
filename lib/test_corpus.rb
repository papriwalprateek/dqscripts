def check_nil_source_nodes
	x = Entity.where(isleaf:true)

	#temp = Entity.find_by(name:/heapsort/i)

	x.each do |temp|
	puts temp.name
	temp.p_list.each do |l,v|
		puts l
		t = []
		flag = 0
		if temp[l] != nil
		temp[l].each do |c|
			if Entity.find(c) == nil
				puts c
				flag = 1
			else
				t << c
			end
		end
		end
		if flag == 1
		temp.update_attributes(l=>t)
		e_p_list = temp['p_list']
		e_p_list[l] = t.length
		puts e_p_list	
		temp.update_attributes("p_list"=>e_p_list)
		end
	end

	end

end

def update_p_list
	x = Entity.where(isleaf:true)
	x.each do |temp|
		e_p_list = temp['p_list']
		puts temp.name
		e_p_list.each do |l,v|
			if temp[l] != nil
				if v!=temp[l].length
					puts l.to_s + " " + e_p_list[l].to_s
					e_p_list[l] = temp[l].length
					temp.update_attributes("p_list"=>nil)
					temp.update_attributes("p_list"=>e_p_list)
					puts e_p_list[l]
				end
			else
				if v != 0
					puts l.to_s + " " + e_p_list[l].to_s
					e_p_list[l] = 0
					temp.update_attributes("p_list"=>nil)
					temp.update_attributes("p_list"=>e_p_list)
					puts e_p_list[l]
				end
			end
		end

	end
end


def check_nil_article
	x = Entity.where("addr"=>/\/article\//i).where("cache"=>nil)
	l = DBUpdate::ItemCache.new
	y = EntityLib::DeleteTree.new
	
	x.each do |t|
		begin
			l.url2html(t.id)
		rescue
			y.delete_source_entity(t.id)
		end
	end
end