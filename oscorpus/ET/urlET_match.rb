def url_to_ET(url,property)
	et_list = nil
	et_list = {"webopedia.com"=>"webopedia definition extraction","techopedia.com"=>"techopedia definition extraction","nist.gov"=>"nist definition extraction","mathworld.wolfram"=>"wolfram definition extraction","rosettacode.org"=>"rosetta code extraction","wikipedia.org"=>"extraction for wikipedia"}
	
	if property == "article"
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
