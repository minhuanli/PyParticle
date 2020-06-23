dir1 = 'D:\liminhuan\s-s transition project\1105 data\stkcb\'
dir2 = 'D:\liminhuan\s-s transition project\aot_concentration_dynamic\stkcb\'
partlist = ['after1','after2','after3','after4','10mMd1','20mMd1','20mMd2','50mMd1',$
'50mMd2','70mMd1','70mMd2']
out1 = 'D:\liminhuan\s-s transition project\1105 data\boo\'
out2 = 'D:\liminhuan\s-s transition project\aot_concentration_dynamic\boo\'
for part = 6,10 do begin
  if part le 3 then begin 
    aa = [2,2,1.5]
    bb = [3.5,3.5,3]
    cc = [7,7,6]
    dd = [3.5,3.5,3]
    ratio = 0.203
    dir = dir1 
    out = out1
  endif else begin
    aa = [3,3,1.5]
    bb = [5,5,3]
    cc = [10,10,6]
    dd = [5,5,3]
    ratio = 0.13
    dir = dir2
    out = out2
  endelse
  
  f0 = file_search(dir+partlist(part)+'_t*',count=nb)
  for time = 0,nb-1 do begin
   print, partlist(part) + '  time' + string(time)
   f1=read_gdf(f0(time))
   b=bpass3d(f1,aa,bb)
   a1= feature3d(b,cc,sep=dd) 
   a1 = pix2um(a1,ratio,0.25)
   a1=scrcrowd(a1,1.2)
   t=replicate(time,1,n_elements(a1(1,*)))
   a1=[a1,t]
   print,'after scrcrowd particle number:' + string(n_elements(a1(1,*)))
   boo = bondvoi(a1,method=1)
   write_gdf,boo, out +'boo_'+partlist(part)+'_t'+string(time)+'.gdf'
  endfor
endfor
print,'after and aot concentration dynamic'

end