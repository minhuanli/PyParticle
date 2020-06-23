;f1=file_search('E:\temp1\20160513\p1 boo\0513 b*')
;f2=file_search('E:\temp1\20160513\p5 boo\0513p5 b*')
f3=file_search('E:\temp1\20160603\p1\0603p1 b*')

boo3=read_gdf(f3(0))
gb_cr,boo3,gb,cr
ori=fccboo3dnew_revised(boo3)
gbp=fccboo3dnew_revised(gb)
all=[ori,gbp]

for i=1,28 do begin
boo3=read_gdf(f3(i))
gb_cr,boo3,gb,cr
temp1=fccboo3dnew_revised(boo3)
gbp=fccboo3dnew_revised(gb)
temp=[temp1,gbp]
all=[[all],[temp]]
endfor
print,'1,bcc,2,fcc+hcp,3,fcc,4,hcp,5,mrco,6,bcc mrco,7,fcc mrco,8 hcpmrco,9 solid percentage,10 pure liquid'
write_text,all,'0603p1.txt'

end