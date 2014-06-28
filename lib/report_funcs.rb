# Rules of Report managemnet system
# status:unchecked --> Report about an entity has been lodged
# status:checked --> report has been seen by maintainer
# count --> If the report has been lodged again for the same entity, iys count will be increased



def add_report(id,user,msg)
	r = Report.where(user_id:user).find_by(entity_id:id)
	if r == nil
		r = Report.new
		r.entity = Entity.find(id)
		r['status'] = 'unchecked'
		r['reason'] = msg
		r.user = user
		r.save
		puts "Your report has been submitted successfully."
	else
		r['status'] = 'unchecked'
		r['reason'] = msg
		r.user = user
		r.save
		puts "Your report has been submitted successfully."
	end

end


# Below code needs to be seen again

def view_report(entity_id, action)
	r = Report.find(entity_id)
	if action == true
		r['status'] = 'checked'
	end
end