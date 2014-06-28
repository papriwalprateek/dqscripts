# This meythod is used when a URL is to be converted into html/text through some extraction technique

def entity_cache_update(id)
	e = Entity.find(id)
	property_url = e.url
	dq_bind=binding()
	extract=Entity.find(e['extraction_tech_id'])
    present=Entity.find(extract['presentation'])
    eval(extract['code'],dq_bind)
    eval(present['code'],dq_bind)
	begin    
	e.update_attributes("in_type"=>nil)
	l = "text"
	e.update_attributes("out_type"=>l)
    e['cache'] = @html_out[0]
    e['cache_timestamp'] = Time.now
    e['cached'] = true
	rescue
	e['cached'] = false
	end
	puts e['cached']
    e.save
end


# For URL to youtubevideo

def cache_update_u2v(id)
	e = Entity.find(id)
	t = e['addr'].split('/')
	l = '/' + t[0] + 's/videopage'
	e.update_attributes("type"=>l)
	l = "video"
	e.update_attributes("out_type"=>l)
	l = 6
	e.update_attributes("prank"=>l)
	l = Entity.find('537c9a316c6f631767060000').id
	e.update_attributes("presentation"=>l)	
	l = e.url.gsub(/watch/,"embed")
	e.update_attributes("url"=>l)
	e.update_attributes("in_type"=>nil)
	e.save
end