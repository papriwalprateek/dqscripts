updateothers=false
count=0
puts 'hi'
property_a=['description','algorithm','complexity','math_analysis','pseudocode']
property_b=['article','wiki','code','video','description']
ext_wiki=Entity.find_by(name_ref:'dev_extraction for wikipedia')
id_gen=Entity.find_by(name_ref:'extraction for webpages')['_id']
Entity.where(type:'/dq/algorithm').where(cached_wiki:false).each do |e|
#A8.each do |e|
    puts ' '
    print(count.to_s+' '+e['name'])
    count=count+1
    if true
        e['cached_wiki']=false
        e.save
        begin
            if( e['p_list']==nil || e['p_list'].class!=Hash)
                e['p_list']={}
            end
            @arr=[]
            e_wiki=Entity.find(e['wiki'][0])
            prank=e_wiki['prank']
            property_url=e_wiki['url']
            property_title=e_wiki['title']
            property_img_url=e_wiki['img_url']
            dq_bind=binding()
            eval(ext_wiki['code'],dq_bind)
            property_a.each do |property|
                print property
                request_out=[]
                dq_bind=binding()
                present=Entity.find(ext_wiki['presentation'])
                eval(present['code'],dq_bind)
                print 1
                if(e[property]==nil)
                    e[property]=[]
                end
                if request_out[0][0] !=''
                    print('hi')
                    temp=nil
                    print 2
                    Entity.find(e[property]).each do |ep|
                        if(ep['url']==e_wiki['url'])
                            temp = ep
                            break
                        end
                    end
                    if(temp==nil)
                        temp=Entity.new
                    end
                    temp["url"]=e_wiki["url"]
                    temp["title"]=e_wiki["title"]
                    temp["img_url"]=e_wiki["img_url"]
                    temp["prank"]=e_wiki["prank"]
                    temp.type="/dqs/"+property
                    temp["extraction_tech_id"]=ext_wiki['_id']
                    temp["cache"]=request_out[0][0]
                    temp["cache_timestamp"]=Time.now
                    temp.save
                    temp['addr']=e['addr'].downcase+'/'+e['name'].downcase+'/'+property+'/'+temp['_id'].to_s.downcase
                    print (property+temp['_id'].to_s)
                    temp.save
                    e_property=e[property]
                    e_property<<temp['_id']
                    e_property=e_property.uniq
                    e.update_attributes(property=>nil)
                    e.update_attributes(property=>e_property)
                    else
                    print ('insite else'+property)
                    e_property=e[property]
                    Entity.find(e[property]).each do |ep|
                        if(ep['url']==e_wiki['url'])
                            e_property.delete(ep['_id'])
                            ep.destroy
                        end
                    end
                    e_property=e_property.uniq
                    e.update_attributes(property=>nil)
                    e.update_attributes(property=>e_property)
                end
                
                e['p_list'][property]=e[property].length
            end
            property_b.each do |property|
                e['p_list'][property]=e[property].length
                if(e[property].length>0 && property !='video' && property !='description' && updateothers )
                    if(property=='wiki')
                        ew=Entity.find(e['wiki']).first
                        ew['extraction_tech_id']=id_gen
                        ew.save
                    end
                    e[property].each do |property_source_id|
                        request_out=[]
                        @arr=[]
                        e1=Entity.find(property_source_id)
                        prank=e1['prank']
                        property_url=e1['url']
                        property_title=e1['title']
                        property_img_url=e1['img_url']
                        print(property_url)
                        extract=Entity.find(e1['extraction_tech_id'])
                        present=Entity.find(extract['presentation'])
                        dq_bind2=binding()
                        eval(extract['code'],dq_bind2)
                        eval(present['code'],dq_bind2)
                        e1['cache']=request_out[0][0]
                        e1["cache_timestamp"]=Time.now
                        e1.save
                    end
                end
            end
            e_p_list=e['p_list']
            e.update_attributes(p_list:nil)
            e.update_attributes(p_list:e_p_list)
            e['cached_wiki']=true
            e.save
            rescue
            File.open('/home/papri/mylog.log', 'a') {|f| f.write( Time.now.to_s+e['name']+"update_wikicache.rb\n") }
            end
    end
end
