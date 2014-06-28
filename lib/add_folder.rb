# r is hash in the following format 
# out_type = "text" by default
#
#   {
#	name:"My sort",
#	addr:"dq/algorithms",
#   init_property:"desription",
#	prop_content:"This is my sort. This is developed by me. This is sorting technique used by me. And this me is papri."
#	author:"Prateek Papriwal"
#	type:"text"
# 	}

# name,addr,init_property,prop_content,author


def add_entity(r)
	e = Entity.new
	l = r['name'].capitalize
	e.update_attributes("name"=>l)

	t = r['addr'].split('/')
	x = t[1].split('')
	x.pop()
	x = x.join
	l = '/' + t[0] + '/' + x
	e.update_attributes("type"=>l)

	l = r['addr']
	e.update_attributes("addr"=>l)
	l = true
	e.update_attributes("isleaf"=>l)
	l = r['addr'] + '/' + e['name']
	e.update_attributes("query"=>l)
	l = {r['init_property']=>1}
	e.update_attributes("p_list"=>l)

	d = Entity.new
	l = '/' + t[0] + 's/' + r['init_property']
	d.update_attributes("type"=>l)
	l = e['query'].downcase + '/' + r['init_property'] + '/' + d.id
	d.update_attributes("addr"=>l)
	l = d['addr']
	d.update_attributes("query"=>l)
	l = r['author']
	d.update_attributes("author"=>l)
	l = ''
	d.update_attributes("url"=>l)
	l = 'merged'
	d.update_attributes("review_status"=>l)
	l = r['prop_content']
	d.update_attributes("cache"=>l)
	l = 'text'
	d.update_attributes("out_type"=>l)

	puts d.id


	l = [d.id]
	e.update_attributes(r['init_property']=>l)
	

	d.save
	puts "duple saved"

	puts e.id
	e.save
	puts "entity saved"
end


# r is basically container which contains inputs from ui
# {
#	name:"Data mining",
#	addr:"dq/algorithms"
# }


def add_folder(r)
	e = Entity.new
	puts "new folder made, content to be added"
	l = r['name'].capitalize
	e.update_attributes("name"=>l)

	t = r['addr'].split('/')
	x = t[1].split('')
	x.pop()
	x = x.join
	l = '/' + t[0] + '/' + x + '/'
	e.update_attributes("type"=>l)

	l = r['addr']
	e.update_attributes("addr"=>l)

	l = r['addr'] + '/' + r['name'].capitalize
	e.update_attributes("query"=>l)
	e.save
	puts "folder saved"
end


# Paramenter id - ID of the entity to be deleted
# It will delete the entity itself and its child as well.
# Similar to file folder delete philosophy

def delete(id)
	e = Entity.find(id)
	r = Regexp.new(e.query.downcase,'i')
	collection = Entity.where(query:r)

	collection.each do |x|
		x.delete
	end 
end

# mapping to be done 

def entity_addition(entityjson,base_addr,author,merge)
	e = Entity.new
	l = entityjson[0].capitalize
	e.update_attributes("name"=>l)

	t = base_addr.split('/')
	x = t[1].split('')
	x.pop()
	x = x.join
	l = '/' + t[0] + '/' + x
	e.update_attributes("type"=>l)

	l = base_addr
	e.update_attributes("addr"=>l)
	l = true
	e.update_attributes("isleaf"=>l)
	l = base_addr + '/' + e['name']
	e.update_attributes("query"=>l)
	
	
	e_p_list = {}

	entityjson[1].each do |k,v|
		c = []
		e_p_list[k] = 0
		

		if mapping[k] == 'video'

			v.each do |x|

			d = Entity.new
			l = '/' + t[0] + 's/videopage'
			d.update_attributes("type"=>l)
			l = e['query'].downcase + '/' + k + '/' + d.id
			d.update_attributes("addr"=>l)
			l = d['addr']
			d.update_attributes("query"=>l)
			l = "video"
			d.update_attributes("out_type"=>l)
			l = 6
			d.update_attributes("prank"=>l)
			l = Entity.find('537c9a316c6f631767060000').id
			d.update_attributes("presentation"=>l)
			l = "http://www.youtube.com/embed/" + x
			d.update_attributes("url"=>l)



			c << d.id
			e_p_list[k] = e_p_list[k] + 1 
			
			end

		elsif mapping[k] == 'image'

			d = Entity.new
			l = '/' + t[0] + 's/imagepage'
			d.update_attributes("type"=>l)
			l = e['query'].downcase + '/' + k + '/' + d.id
			d.update_attributes("addr"=>l)
			l = d['addr']
			d.update_attributes("query"=>l)
			l = "image"
			d.update_attributes("out_type"=>l)
			l = 6
			d.update_attributes("prank"=>l)
			l = x
			d.update_attributes("url"=>l)

			c << d.id
			e_p_list[k] = e_p_list[k] + 1


		elsif mapping[k] == 'url'
			v.each do |x|

			d = Entity.new
			l = '/' + t[0] + 's/' + k
			d.update_attributes("type"=>l)
			l = e['query'].downcase + '/' + k + '/' + d.id
			d.update_attributes("addr"=>l)
			l = d['addr']
			d.update_attributes("query"=>l)
			l = x
			d.update_attributes("url"=>l)
			if merge == true
				l = r['author']
				d.update_attributes("author"=>l)
				l = 'merged'
				d.update_attributes("review_status"=>l)
			end
			l = "url"
			d.update_attributes("in_type"=>l)

			c << d.id
			e_p_list[k] = e_p_list[k] + 1 
			end
		else                  # this is for properties which would have out_type as text 

			v.each do |x|
		
			d = Entity.new
			l = '/' + t[0] + 's/' + k
			d.update_attributes("type"=>l)
			l = e['query'].downcase + '/' + k + '/' + d.id
			d.update_attributes("addr"=>l)
			l = d['addr']
			d.update_attributes("query"=>l)
			l = ''
			d.update_attributes("url"=>l)
			if merge == true
				l = r['author']
				d.update_attributes("author"=>l)
				l = 'merged'
				d.update_attributes("review_status"=>l)
			end
			l = x
			d.update_attributes("cache"=>l)
			l = 'text'
			d.update_attributes("out_type"=>l)
			c << d.id
			e_p_list[k] = e_p_list[k] + 1 

			end

		end
		e.update_attributes(k=>nil)
		e.update_attributes(k=>c)		

	end	
	e.update_attributes("p_list"=>e_p_list)
	e.update_attributes("p_list"=>e_p_list)

#	l = {r['init_property']=>1}
#	e.update_attributes("p_list"=>l)	

end