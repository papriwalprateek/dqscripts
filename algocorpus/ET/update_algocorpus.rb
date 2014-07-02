dbu = DBUpdate::ItemCache.new
desc_et = Entity.find_by(name_ref:/definition extraction/)
para_et = Entity.find_by(name_ref:/paras extraction/)

x = Entity.where(cached_new:false)

#x = Entity.find_by(name:'Prufer sequence')

x.each do |l|

	begin
	puts l.name
	puts "description"
	l['description'].each do |id|
		temp = Entity.find(id)
		if temp.url.include?('wikipedia.org')
			temp.update_attributes("extraction_tech_id"=>desc_et.id)
			dbu.url2html(temp.id)
		end
	end


	puts "algorithm"
	l['algorithm'].each do |id|
		temp = Entity.find(id)
		if temp.url.include?('wikipedia.org')
			temp.update_attributes("extraction_tech_id"=>para_et.id)
			dbu.url2html(temp.id)
		end
	end

	puts "complexity"
	l['complexity'].each do |id|
		temp = Entity.find(id)
		if temp.url.include?('wikipedia.org')
			temp.update_attributes("extraction_tech_id"=>para_et.id)
			dbu.url2html(temp.id)
		end
	end

	puts "math_analysis"
	l['math_analysis'].each do |id|
		temp = Entity.find(id)
		if temp.url.include?('wikipedia.org')
			temp.update_attributes("extraction_tech_id"=>para_et.id)
			dbu.url2html(temp.id)
		end
	end

	puts "pseudocode"
	l['pseudocode'].each do |id|
		temp = Entity.find(id)
		if temp.url.include?('wikipedia.org')
			temp.update_attributes("extraction_tech_id"=>para_et.id)
			dbu.url2html(temp.id)
		end
	end

	puts "true"
	l.update_attributes("cached_new"=>true)
	rescue
	puts "false"
	l.update_attributes("cached_new"=>false)
	end
end