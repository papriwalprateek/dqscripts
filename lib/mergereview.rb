def merge_review(id,property = "resources")
	
	ur = Entity.find(id)
	regex = /#{Regexp.escape(ur.parent_query)}/i
	parent_entity = Entity.find_by(query:regex)
	
	puts "updating under_review entity"
	
	ur.type = '/dqs/'+property
	
	ur.addr = parent_entity.query.downcase + '/' + property + '/' + ur.addr.split('/')[-1]
	ur['addr_downcased'] = true
	
	ur['query'] = ur.addr
	ur.review_status = 'merged'
	
	if ur.imm_content == true
		ur.out_type = 'text'
	end
	
	ur['cache_timestamp'] = Time.now.getutc

	ur.save
	puts "updated and saved"


	puts "updated parent_entity"
	
	if parent_entity[property] == nil
		parent_entity[property] = []
		parent_entity.p_list[property] = 0

	end
	
	e_property=parent_entity[property]
	e_property << ur.id
	e_property=e_property.uniq
	parent_entity.update_attributes(property=>nil)
    parent_entity.update_attributes(property=>e_property)

	
	puts parent_entity[property]
	
	parent_entity.p_list[property] = parent_entity[property].length
	parent_entity.p_list['under_review'] = parent_entity['under_review'].length
	
	
	e_ur = parent_entity['under_review']
	e_ur.delete(ur.id)
	parent_entity.update_attributes(under_review:nil)
	parent_entity.update_attributes(under_review:e_ur)
	
	
	parent_entity.save
	puts "updated and saved"
end
