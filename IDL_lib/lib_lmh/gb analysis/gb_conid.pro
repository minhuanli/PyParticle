
function freq2,data,list
   w=sort(data)
   data=data(*,w)
   listr=list(*,w)
   temp=data( uniq(data) )
   nn=n_elements(temp(*))
   result=fltarr(2,nn)
   tlist=listr(*,uniq(data))
   for i=0,nn-1 do begin
      result(0,i)=temp(i)
      w=where(data eq temp(i),nw)
      result(1,i)=nw
   endfor
   result=[result,tlist]
   result=result(*,reverse(sort(result(1,*))))
   return,result
end
;-------------------------------------------------
function digi1,figu
   result=[-1]
   if figu lt 10. then result=100.
   if figu ge 10. and figu lt 100. then result=1000.
   return,result
end 

; 0; cluster number , 1:nc,cluster id
;--------------------------------------------------------------------
function gb_conid,bond,class,conl=conl,deltar=deltar,grlist=grlist
 if (keyword_set(conl)) then conl=conl else conl=conlist(bond,deltar=deltar,bondmax=20)
 npar=n_elements(bond[0,*])
 result=fltarr(8,npar)
 clunm=max(class)
 grlist=dblarr(1,npar)
 for i=0.,npar-1 do begin
  otherclass=0
  for j=1,conl[i,0] do begin
   if (class[i] ne class[conl[i,j]]) and (class[i] ne 0) and (class[conl[i,j]] ne 0) then otherclass++
  endfor
   if (float(otherclass)/conl[i,0]) gt 0.3 then result(0,i)=1
 endfor

 w=where(result(0,*) ne 0,nw)
 print,nw
 for i=0.,nw-1 do begin
    nbclass=[ [ class[conl[w(i),1:conl[w(i),0]]] ],[class(w(i))] ]
    nbclass=nbclass(sort(nbclass) ) 
    cluid=long(nbclass( uniq( nbclass ) ))
    nc=n_elements(cluid)
    ;if w(i) eq 29120 then print,cluid
    if cluid(0) eq 0 then cluid=cluid(1:nc-1)
    ;if w(i) eq 29120 then print,cluid
    nc=n_elements(cluid)
    result(0,w(i))=nc
    result(1:nc,w(i))=cluid
    grlist(w(i))=cluid(nc-1)
    tt=1.
      for j=1,nc-1 do begin
        tt=tt*digi1(cluid(nc-j)) 
        grlist(w(i))= grlist(w(i))+tt*cluid(nc-j-1)
      endfor
 endfor 
 grlist=freq2(grlist,result)
 return,result
end