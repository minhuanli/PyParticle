; 返回的是第一层粒子的坐标,file中只有坐标3列和时间1列
function surface_select,filename,bondmax=bondmax
totalnumber=float(n_elements(filename)) ; the number of stack
for i=0.0,totalnumber-1 do begin
 trb0=read_gdf(filename(i))
 s=size(trb0) 
 totalparticle=n_elements(trb0(0,*)) ; the number of particle
 gr=ericgr3d(trb0,rmin =1, rmax =10, deltar =0.1)
 firstfloor=firstfloor_search(gr)
 print,firstfloor
 trb=[trb0(0:2,*),transpose(indgen(totalparticle)),transpose(indgen(totalparticle))]
 nearest=search_nearest_new(trb,bondmax=bondmax)
  for j=0,totalparticle-1 do begin
  if j mod 1000 eq 0 then  print,j
  trb1=trb[*,nearest(j,*)]
    for k=1,bondmax-2 do begin 
     for l=k+1,bondmax-1 do begin  
     if (one_side(0,k,l,trb1,extra=extra,deltar=firstfloor) eq 1) then begin
     if trb1(3,0) ne -1 then begin
     trb(3,trb1(3,0))=-1
     endif 
     if trb1(3,k) ne -1 then begin
     trb(3,trb1(3,k))=-1
     endif
     if trb1(3,l) ne -1 then begin
     trb(3,trb1(3,l))=-1
     endif
     endif
   endfor
  endfor
 endfor
endfor
w=where(trb(3,*) eq -1)
return,trb(*,w)

end