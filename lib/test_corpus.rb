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