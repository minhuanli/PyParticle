pro stkcombine,fname,fname1,n_stk=n_stk,z_num=z_num,type=type
file=file_search(fname)
pic01=read_tiff(file[0])
s01=size(pic01)
px=s01[2]
py=s01[3]
stkname=fname1+string(indgen(n_stk))+'.gdf'
for j=0,n_stk-1 do begin
a1=indgen(px,py,z_num)
CASE type OF
    0: c=0 ;red
    1: c=1 ;green  
    2: c=2 ;blue
    ELSE:
  ENDCASE
  
for i=0L,z_num-1 do begin
a2=read_tiff(file[long(z_num)*long(j)+long(i)])
a1(*,*,i)=total(a2(c,*,*),1)
endfor
print,j
write_gdf,a1,stkname[j]
endfor
end