dir1 = 'D:\liminhuan\s-s transition project\0801 data\boo\mf1\'
dir2 = 'D:\liminhuan\s-s transition project\0801 data\boo\mf2\'
file = ['boom1-cell0801-mf1-p','0801mf2bondm1_p']
reso = fltarr(5,40)
for i = 1,4 do begin
data1 = file_search(dir1+file(0)+string(i)+'*')
data2 = file_search(dir2+file(1)+string(i)+'*')
filein = [data1,data2]

nb = n_elements(filein)
  
  for t = 0,nb-1 do begin 
    temp = edgecut(read_gdf(filein(t)))
    w1 = where(temp(5,*) gt 0.33 and temp(8,*) lt 0,nw1)
    w2 = where(temp(5,*) lt 0.33,nw2)
    w3 = where(temp(5,*) gt 0.33 and temp(8,*) gt 0,nw3) 
    nw0 = n_elements(temp(0,*))
    reso(0,t) = reso(0,t) + nw0
    reso(1,t) = reso(1,t) + nw1
    reso(2,t) = reso(2,t) + nw2
    reso(3,t) = reso(3,t) + nw3
  endfor
endfor

res = reso
res(1,*) = res(1,*) / res(0,*)
res(2,*) = res(2,*) / res(0,*)
res(3,*) = res(3,*) / res(0,*)

end
    