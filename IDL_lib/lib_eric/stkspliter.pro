pro stkspliter,fname,n_stk=n_stk,z_num=z_num
file=findfile(fname)
a1=readtiffstack(file)
n1=fname1+string(indgen(n_stk))+'.gdf'
for j=0,n_stk-1 do begin
write_gdf,a1(*,*,z_num*j:z_num*(j+1)-1),n1[j]
endfor
end