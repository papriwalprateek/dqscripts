def sort_p_list(corpus_domain,sorter)
	corpus_domain.each do |e|
		puts e.name
		e_p_list = e.p_list
		new_p_list = {}
		sorter.each do |s|
			if e_p_list[s] != nil
				new_p_list[s] = e_p_list[s]
			end
		end
		e.update_attributes('p_list'=>nil)
		e.update_attributes('p_list'=>new_p_list)
	end

end