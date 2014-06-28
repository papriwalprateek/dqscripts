load '/home/papri/git_work/dqscripts/dbscripts/cache_update_new.rb'

def url_to_ET(url,type)
	et_list = nil
	et_list = {"webopedia.com"=>"extraction for webopedia","techopedia.com"=>"extraction for techopedia","nist.gov"=>"extraction for nist","mathworld.wolfram"=>"extraction for wolfram","rosettacode.org"=>"extraction for rosettacodes","wikipedia.org"=>"extraction for wikipedia"}
	
	if type == "/dqs/webpage"
		return "dq-readability"
	else
		flag = 0
		et = nil
		et_list.each do |k,v|
			if url.include?(k)
				et = v
				flag = 1
				break
			end
		end
		if flag == 0
			et = "no ET available"
		end
		
		return et
	end
end

#corpus_domain is the part of the whole corpus in which this script is to be run

def add_et_in_entities(corpus_domain)
	i = 0
	corpus_domain.each do |c|
		et_name = url_to_ET(c.url,c.type)
		l = Entity.find_by(name_ref:et_name).id
		c.update_attributes("extraction_tech_id"=>l)
		entity_cache_update(c.id)
		i = i + 1
		puts i
	end
end