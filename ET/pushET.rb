def update_code(p,q)
    file = File.new(p, "r")
    s= ""
    while (line = file.gets)
        s<<line
    end
    puts(s)
    e=Entity.find_by(name_ref:q)
    e["code"]=s
    e.save
    file.close
end
update_code("/home/papri/git_work/dqscripts/wiki_dev.rb","dev_extraction for wikipedia")
