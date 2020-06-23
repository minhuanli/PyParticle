function findid,cpdata=cpdata,data=data,fail=fail
  ww=n_elements(cpdata(0,*))
  id=lonarr(ww)
  fail=[-1]
  for i=0.,ww-1 do begin
    w=where(data(0,*) gt cpdata(0,i)-0.005 and data(0,*) lt cpdata(0,i)+0.005 and data(1,*) gt cpdata(1,i)-0.005 and data(1,*) lt cpdata(1,i)+0.005, nw)  ;and data(2,*) eq cpdata(2,i)
    if nw ge 1 then begin
      id(i)=w(0)
    endif else begin
      print,'find no corresponding particle in the background particles'
      fail=[fail,i]
    endelse
  endfor
  
  return,id
  
  end

;=========================================

FUNCTION SetDifference, a, b  ; = a and (not b) = elements in A but not

mina = min(a, MAX=maxa)
minb = min(b, MAX=maxb)
if (minb gt maxa) or (maxb lt mina) then return, a ;No intersection...
r = where((histogram(a, MIN=mina, MAX=maxa) ne 0) and $
          (histogram(b, MIN=mina, MAX=maxa) eq 0), count)
if count eq 0 then return, -1 else return, r + mina
end
;=========================================================

function kickdata,data,kick 
    temp = data
    all = findgen(1,n_elements(temp(0,*)))
    outid = findid(cpdata=kick,data=temp)
    leftid = setdifference(all,outid)
    temp = temp(*,leftid)
return,temp
end

;=====draw a polygon to kickout the selected particles from data==============

function polykick,data,f1=f1,f2=f2,time=time,iso=iso

   if not(keyword_set(time)) then time = 1
   temp = data

   for i = 1,time do begin
     all = findgen(1,n_elements(temp(0,*)))
     if keyword_set(iso) then out = polycut(temp,f1=f1,f2=f2,/iso) else out = polycut(temp,f1=f1,f2=f2)
     outid = findid(cpdata=out,data=temp)
     leftid = setdifference(all,outid)
     temp = temp(*,leftid)
   endfor

return,temp

end
;=======================================================================
function polycut_multi,data,f1=f1,f2=f2,time=time,iso=iso,kick=kick
   if not(keyword_set(time)) then time = 1
   temp = data
   nc = n_elements(data(*,0))
   res=fltarr(nc,1)
   for i = 1,time do begin
     all = findgen(1,n_elements(temp(0,*)))
     if keyword_set(iso) then out = polycut(temp,f1=f1,f2=f2,/iso) else out = polycut(temp,f1=f1,f2=f2) 
     outid = findid(cpdata=out,data=temp)
     res = [[res],[temp(*,outid)]]
     leftid = setdifference(all,outid)
     temp = temp(*,leftid)
   endfor
if keyword_set(kick) then data = kickdata(data,res(*,1:n_elements(res(0,*))-1))
return,res(*,1:n_elements(res(0,*))-1)
end
   
   
   
   