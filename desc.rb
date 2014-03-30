load '/home/papri/git_work/dqscripts/combcorpus.rb'



def nist_extract(url)
	@doc = Nokogiri::HTML(open(url))
	carrier = @doc.css('p')
	
	desc = ''
	carrier.each do |c|
		if c.text.include?('Definition')
			x = c.css('strong')
			x.remove
			desc = c.text
			break
		end
	end
	return desc
end

def wolfram_extract(url)
	@doc = Nokogiri::HTML(open(url))
	carrier = @doc.css('p')
	desc = ''
	carrier.each do |c|
		if desc.length < 200
			desc = desc + c.text
		else
			break
		end
	end
	return desc
end



@sortcorpus = @corpus['Combinatorial algorithms']

@sortdesc = {}

@sortcorpus.each do |a,v|
	@sortdesc[a] = {}
	puts a
	v.each do |t|
		if t[1].include?('xlinux.nist.gov')
			@sortdesc[a]['xlinux.nist.gov'] = nist_extract(t[1])
			puts t[1]
		elsif t[1].include?('wolfram')
			@sortdesc[a]['wolfram'] = wolfram_extract(t[1])
			puts t[1]
		end 
	end
end
