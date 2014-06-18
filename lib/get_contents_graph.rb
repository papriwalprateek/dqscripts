  def get_contents(a)                  ### gives children or htmloutput in case of type /dqs/...
      a=a.downcase
      a_split= a.split('/')
      k=0
      p=''
      a_split.each do
          p<<a_split[k]
          k=k+1
          if k>a_split.length - 2
              break
          end
          p<<'/'
      end
      puts('p: '+p)
      if a_split.length>1
          q=a_split.last
          a=p+'/'+q
          else
          a=p
          q=''
      end
      err={}
      if (Entity.where(addr:a).count==0 && Entity.where(addr:p).where(name:/^#{Regexp.escape(q)}$/i).count==0 && Repo.where(addr:a).count==0)
          err['error']='not found'
          err['details']='addr: '+a+" \n Entity.where(addr:a).count="+Entity.where(addr:a).count.to_s+" \n count addr p name q "+Entity.where(addr:p).where(name:/^#{Regexp.escape(q)}$/i).count.to_s+" \n repo count"+Repo.where(addr:a).count.to_s
          puts err['details']
          err['has']='error'
          return err
      else
      
      r=Hash.new
      if a_split.length==1
          r['has']='repos'
          r['repos'] = []
          Repo.where(addr:a).each do |repo|
              r1=Hash.new
              r1['name']=repo['name']
              r1['type']='notleaf'
              r1['query'] = repo['addr']+'/'+repo['name']
              r['repos']<<r1
          end
      
      else
      
      if Entity.where(addr:a).where(type:/dqs/i).count > 0 #### seeking contents of a source
          r['has']='source'
          r['source']=[]
          #Entity.find_by(addr:a)['cache']
          r1=Hash.new
          r1["type"]='content'
          r1["node"]=Entity.find_by(addr:a)
          r1["title"]=r1['node']['title']
          if(r1['node']['type']=='/dqs/videopage')
              r1['out_type']='video'
              else
              r1['out_type']='text'
          end
          r1["out_html"]=r1['node']['cache']
          r1["url"]=r1['node']['url']
          r['source']<<r1
      else
          if a_split.length == 2
              r['has']='list'
              r['list']=[]
              Entity.where(addr:a).each do |e1|
                  r1=Hash.new
                  if e1['isleaf']
                      r1["type"]='leaf'
                  else
                      r1["type"] ='notleaf'
                  end
                  r1['name']=e1['name']
                  r1['query']=e1['addr']+'/'+e1['name']
                  r['list']<<r1
              end
           else
                e=Entity.where(addr:p).find_by(name:/^#{Regexp.escape(q)}$/i)
                if e['isleaf']
                    r['has']='tiles'
                    r['tiles']=[]
                    e['p_list'].each do |p,n|
                        if n>0
                            puts p
                            r1=Hash.new
                            r1["tile_title"]=p
                            r1["tile_nodes"]=[]
                            e[p].each do |id|
                                r2=Hash.new
                                r2['query']=e['addr']+'/'+e['name']+'/'+p+'/'+id.to_s
                                r2['node']=Entity.find(id)
                                if p=='video'
                                    r2['node']['out_type']='video'
                                    else
                                    r2['node']['out_type']='text'
                                end
                                r1['tile_nodes']<<r2
                            end
                            r['tiles']<<r1
                        end
                    end
                    else
                    r['has']='list'
                    r['list']=[]
                    puts (e['name']+e['isleaf'].to_s+e.type)
                    puts Entity.where(addr:a).count
                    Entity.where(addr:a).each do |e1|
                        r1=Hash.new
                        if e1['isleaf']
                            r1["type"]='leaf'
                            else
                            r1["type"] ='notleaf'
                        end
                        r1['name']=e1['name']
                        r1['query']=e1['addr']+'/'+e1['name']
                        r['list']<<r1
                    end
                end
            end
        end
    end
          return r
          end
      end
