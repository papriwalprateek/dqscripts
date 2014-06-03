
require 'mechanize'

def redirect_url(l)
	agent = Mechanize.new
	page = agent.get(l)
	begin
	x = page.meta_refresh[0]
	red_url = x.uri.to_s	
	rescue
	red_url = page.uri.to_s
	end
	return red_url
end

