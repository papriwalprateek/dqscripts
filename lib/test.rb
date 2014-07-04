x = Entity.where(addr:/osconcepts/i).where(type:/webpage/i).where(url:/en.wikipedia/i)

x.each do |w|
	begin
	l = '/dqs/wikipage'
	w.update_attributes('type'=>l)
	l = w.addr.gsub(/article/,'wiki')
	w.update_attributes('addr'=>l)
	w.update_attributes('query'=>l)
	t = w.query.split('/')
	t.delete_at(-1)
	t.delete_at(-1)
	parent_query = t.join('/')
	r = /#{Regexp.escape(parent_query)}$/i
	parent_entity = Entity.find_by(query:r)
	article_array = parent_entity['article']
	article_array.delete(w.id)
	parent_entity.update_attributes('article'=>nil)
	parent_entity.update_attributes('article'=>article_array)
	wiki_article = [w.id]
	parent_entity.update_attributes('wiki'=>nil)
	parent_entity.update_attributes('wiki'=>wiki_article)
	e_p_list = parent_entity['p_list']
	e_p_list['article'] = parent_entity['article'].length
	parent_entity.update_attributes('p_list'=>nil)
	parent_entity.update_attributes('p_list'=>e_p_list)
	puts w.url
	rescue
	puts "failed"
	end
end