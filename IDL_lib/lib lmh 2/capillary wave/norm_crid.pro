;designed for pick grainboundary in 1026gbdy, the feature is identifying         |-----|----|
;corresponding grains with position, rather than the gbid.                       |  2 /     |
;just for 1026gbdy data, 3 grains, left up, left down right huge                 |----|  1  |
;failt means the unsuitble time state                                            | 3  |     |
; output: 0-2:normed crid  3,time       ##2017/11/1                              |----/-----|  illustration for this sample
function norm_crid, boo=boo, crid=crid , failt =failt
res = [-1,-1,-1,-1]
tempf = [-1,-1,-1,-1]
for t =0,483 do begin
  ww = where(failt eq t,nww)
  if nww gt 0 then continue 
  bct = edgecut(eclip(boo,[17,t,t])) 
  idt = eclip(crid,[1,t,t])
  
  xt = fltarr(3)
  yt = fltarr(3)
  xt(0) =  mean(bct(0,where(idt(0,*) eq 1)))
  xt(1) =  mean(bct(0,where(idt(0,*) eq 2)))
  xt(2) =  mean(bct(0,where(idt(0,*) eq 3)))
  yt(0) =  mean(bct(1,where(idt(0,*) eq 1)))
  yt(1) =  mean(bct(1,where(idt(0,*) eq 2)))
  yt(2) =  mean(bct(1,where(idt(0,*) eq 3)))
  
  test = max(xt,id1)
  test = max(yt,id2)
  
  id1=id1+1
  id2=id2+1
  id3 = subset([1,2,3],[id1,id2])
  res = [[res],[id1,id2,id3,t]]
endfor

return,res

end
  