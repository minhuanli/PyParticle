function pix2um,data,xyratio,zratio,reverse=reverse,plust=plust
  
   if not(keyword_set(reverse)) then law=1. else law = -1.
   res = data
   res(0,*) = data(0,*) * xyratio^law
   res(1,*) = data(1,*) * xyratio^law
   res(2,*) = data(2,*) * zratio^law
   if keyword_set(plust) then begin
    t =fltarr(1,n_elements(res(0,*)))
    res = [res,t]
   endif
   return,res
   
end