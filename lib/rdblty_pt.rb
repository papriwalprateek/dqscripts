## Sholud be called via eval and binding same as the extraction code to which it is linked, Article_array must be created in the calling code
## This code pushes in the already created articles_array the html_safe output of extracted article
if @articles_array==nil
    @articles_array=[]
end
@html_out = []
s=out.html_safe
begin
request_out<<[s,property_url,prank,property_title,property_img_url]
rescue
end
@html_out << s
@articles_array<<s
