# name --> Name of the repo to be created 
# Conditions --> name should end with 's'
# json --> the corpus

# 
# r = 
#{
#	addr:"dq/osconcepts"
#	author:""
#	merge:false
#	mapping:["video"=>"video","diagram"=>"image","description"=>"url","lectures"=>"url"]
#}

def repocreate(corpus, r)
	i = 0
	corpus.each do |k|
		puts "entity creation started"
		entity_addition(k,r["addr"],r["author"],r["merge"],r["mapping"])
		puts k[0] + " entity saved"
		i = i + 1
		puts i.to_s + " entities saved ........"
		if i == 10
			break
		end
	end		

end

# entityjson format
# ["Operating System", {"video"=>["MaA0vFKt-ew", "55FeqGGzE5Q"]


def entity_addition(entityjson,base_addr,author,merge,mapping)
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
			d.save
			end

		elsif mapping[k] == 'image'

			v.each do |x|
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
			d.save

			end

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
			
			d.save
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

			d.save
			end

		end
		e.update_attributes(k=>nil)
		e.update_attributes(k=>c)		

		puts "attributes saved"
	end	
	e.update_attributes("p_list"=>e_p_list)
	e.update_attributes("p_list"=>e_p_list)
	e.save

#	l = {r['init_property']=>1}
#	e.update_attributes("p_list"=>l)	

end