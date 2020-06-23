;x,y,z,tetra num,time
function tr33t,tr22,bond,dc=dc,ratio=ratio
   if keyword_set(dc) and keyword_set(ratio) then begin 
      print,'only one criteria, please stop!!'
      return,[-1]
   endif else begin
    if keyword_set(dc) then dc=dc    
    ncol=n_elements(bond(*,0))
    ncol1=n_elements(tr22(*,0))
    n=n_elements(tr22(0,*))
    tmax=max(bond(ncol-1,*))
    tmin=min(bond(ncol-1,*))
    nn=n_elements(bond(0,*))
    result=fltarr(5,nn)
    if keyword_set(ratio) then begin
       rank=sort(tr22(8,*))
       dc = tr22(8,rank(round(ratio*n)))
       print,dc
    endif
    k = 0L
    w=where(tr22(8,*) lt dc,nw)
    tr2=tr22(*,w) 
    for i = tmin, tmax do begin 
      ww=where(tr2(ncol1-1,*) eq i,nww)
      if nww eq 0 then tr2t=[0.] else tr2t=tr2(*,ww)
        www = where(bond(ncol-1,*) eq i,nwww)
        bondt=bond(*,www)
      for j = 0. ,nwww-1 do begin 
         wwww=where(tr2t(0:3,*) eq j,nwwww)
         result(0:2,k)=bondt(0:2,j)
         result(3,k)=nwwww
         result(4,k)=i
         k=k+1L
      endfor
    endfor
   return,result
   endelse
   
   end
 
      
      
      
