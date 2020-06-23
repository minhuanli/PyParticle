;designed for pick grainboundary in 1026gbdy, the feature is identifying         |-----|----|
;corresponding grains with position, rather than the gbid.                       |  2 /     |
;just for 1026gbdy data, 3 grains, left up, left down right huge                 |----|  1  |
;failt means the unsuitble time state                                            | 3  |     |
; output: 0,gbid  1:3,particle pos 4,time      ##2017/11/1                       |----/-----|  illustration for this sample
function pick_gb,boo=boo,crid=crid,idseq=idseq,failt=failt
res = [-1,-1,-1,-1,-1]
for t = 0,483 do begin
   ww = where(failt eq t,nww)
   if nww gt 0 then continue 
   btc = edgecut(eclip(boo,[17,t,t]))
   idt = eclip(crid,[1,t,t])
   idseqt = eclip(idseq,[3,t,t])
   gbidt = gb_conid(btc,idt(0,*),deltar=2.8,grlist=grlistt)
   
   ; gb 121
   w=where(gbidt(0,*) eq 2 and gbidt(1,*) eq min([idseqt(0),idseqt(1)]) and gbidt(2,*) eq max([idseqt(0),idseqt(1)]) and idt(0,*) eq idseqt(0),nw)
   tempf = fltarr(5,nw)
   tempf(0,*) = 121
   tempf(1:3,*) = btc(0:2,w)
   tempf(4,*) = t 
   res = [[res],[tempf]]
   
   ; gb 122
   w=where(gbidt(0,*) eq 2 and gbidt(1,*) eq min([idseqt(0),idseqt(1)]) and gbidt(2,*) eq max([idseqt(0),idseqt(1)]) and idt(0,*) eq idseqt(1),nw)
   tempf = fltarr(5,nw)
   tempf(0,*) = 122
   tempf(1:3,*) = btc(0:2,w)
   tempf(4,*) = t 
   res = [[res],[tempf]]
   
   ; gb 131
   w=where(gbidt(0,*) eq 2 and gbidt(1,*) eq min([idseqt(0),idseqt(2)]) and gbidt(2,*) eq max([idseqt(0),idseqt(2)]) and idt(0,*) eq idseqt(0),nw)
   tempf = fltarr(5,nw)
   tempf(0,*) = 131
   tempf(1:3,*) = btc(0:2,w)
   tempf(4,*) = t 
   res = [[res],[tempf]]
   
   ; gb 133
   w=where(gbidt(0,*) eq 2 and gbidt(1,*) eq min([idseqt(0),idseqt(2)]) and gbidt(2,*) eq max([idseqt(0),idseqt(2)]) and idt(0,*) eq idseqt(2),nw)
   tempf = fltarr(5,nw)
   tempf(0,*) = 133
   tempf(1:3,*) = btc(0:2,w)
   tempf(4,*) = t 
   res = [[res],[tempf]]
   
   ; gb 232
   w=where(gbidt(0,*) eq 2 and gbidt(1,*) eq min([idseqt(1),idseqt(2)]) and gbidt(2,*) eq max([idseqt(1),idseqt(2)]) and idt(0,*) eq idseqt(1),nw)
   tempf = fltarr(5,nw)
   tempf(0,*) = 232
   tempf(1:3,*) = btc(0:2,w)
   tempf(4,*) = t 
   res = [[res],[tempf]]
   
   ; gb 233
   w=where(gbidt(0,*) eq 2 and gbidt(1,*) eq min([idseqt(1),idseqt(2)]) and gbidt(2,*) eq max([idseqt(1),idseqt(2)]) and idt(0,*) eq idseqt(2),nw)
   tempf = fltarr(5,nw)
   tempf(0,*) = 233
   tempf(1:3,*) = btc(0:2,w)
   tempf(4,*) = t 
   res = [[res],[tempf]]
   
endfor

return,res

end