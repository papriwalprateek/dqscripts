def commit_content(r)# r is a Hash(json) containing parent_query,property,content,author,url.
    if r['title']==nil
        r['title']='untitled'
        end
    err={}
    err['error']='not supported'
    err['has']='error'
    if(r.keys.include?('type')||r.keys.include?('addr'))
        err['error']='input not allowed'
        err['details']='not allowed to use type or addr as fields in input hash.'
        return err
    end
    get=get_entity(r['parent_query'])
    if(r['in_type']!='url' &&r['in_type']!='imm_content')
        err['details']=" in_type: \"   "+r['intype'].to_s+"   \" not supported, add support in commit_content."
        return err
    end
        
    if(get['has']=='error')
        return get
        else
        if(get['has']=='leaf')
            e=get[get['has']]
            if r['review_status']=='under_review'
                es,e=create_sourcenode('under_review',e,r['out_type'])
                else
                err['details']='not yet supported review_status other than under_review'
                return err
            end
            
            if(r['in_type']=='url')
                es['imm_content']=false
                r['content']=nil
                else
                if(r['in_type']=='imm_content')
                    es['imm_content']=true
                    else
                    err['details']=" in_type: \"   "+r['intype'].to_s+"   \" not supported, add support in commit_content."
                    puts err
                    return err
                end
            end
            r.each do |k,v|
                if(k!='content')
                    es[k]=v
                    else
                    if k=='content'
                        es['cache']=v
                    end
                end
            end
            es.save
            send={}
            send['has']='query'
            send['query']=es['addr']
            return send
            else
            return err
        end
    end
end
