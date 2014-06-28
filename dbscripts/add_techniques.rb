def add_pt(path_to_code,name)
	e = Entity.new
	file = File.new(path_to_code,'r')
	s = ''
	while (line=file.gets)
		s<<line
	end
	puts s
	e.update_attributes("name_ref"=>name)
	e.update_attributes("code"=>s)
	l = "/dqp"
	e.update_attributes("type"=>l)
	e.save
end

def add_et(path_to_code,name,pt)
	e = Entity.new
	file = File.new(path_to_code,'r')
	s = ''
	while (line=file.gets)
		s<<line
	end
	puts s
	e.update_attributes("name_ref"=>name)
	e.update_attributes("code"=>s)
	l = "/dqe"
	e.update_attributes("type"=>l)
	e.update_attributes("presentation"=>pt.id)
	e.save
end



def update_code(path_to_code,name)
	e = Entity.find_by(name_ref:name)
	file = File.new(path_to_code,'r')
	s = ''
	while (line=file.gets)
		s<<line
	end
	puts s
	e.update_attributes("code"=>s)
	e.save
end