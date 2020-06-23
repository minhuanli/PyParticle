;this CNP function can be used to calculate common neighbor parameter(CNP, combined with CSP & CNA)
;the cnp can only calculate one time stack 
;trb is the origin data, containing x,y,z
;----------------------------------------------------------------------------------------------------------------------
function conlist111,a2,deltar=deltar,bondmax=bondmax,distance=distance
 start=systime(/second)
 if (keyword_set(bondmax)) then bondmax=bondmax else bondmax=20
 qhull,a2(0:2,*),tr,connectivity=c1,/delaunay
 n1=n_elements(a2(0,*))
 list=make_array(n1,bondmax+1,/nozero,/long,value=-1)
 distance=make_array(n1,bondmax+1,/nozero,/float,value=-1)
 for j=0.,n1-1 do begin
  b1=c1[c1[j]:c1[j+1]-1]
  nn=n_elements(b1(*))
  bondmax11=min([nn,bondmax])
  bx1=(a2(0,j)-a2(0,b1))^2+(a2(1,j)-a2(1,b1))^2+(a2(2,j)-a2(2,b1))^2
  w1=sort(bx1) ;sort by distance
  bx1=bx1(w1)
  b1=b1(w1)
  w2=where(bx1 lt deltar^2,nc)
  bx1=sqrt(bx1)
  if nc le 0 then continue  
  if nc ge bondmax11 then begin
   list[j,0]=bondmax11
   list[j,1:bondmax11]=b1[0:(bondmax11-1)]
   distance[j,0]=bondmax11
   distance[j,1:bondmax11]=bx1[0:(bondmax11-1)]
  endif else begin
   list[j,0]=nc
   list[j,1:nc]=b1[0:(nc-1)]
   distance[j,0]=nc
   distance[j,1:nc]=bx1[0:(nc-1)]
  endelse   
 endfor
 endtime=systime(/second)
 print,'conlist running time',endtime-start
 return,list
end

;---------------------------------------------------------------------------------------------------
;---------------------------------------------------------------------------------------------------

FUNCTION SetIntersection, a, b
minab = min(a, MAX=maxa) > min(b, MAX=maxb) ;Only need intersection of

maxab = maxa < maxb
 
  ;If either set is empty, or their ranges don't intersect: result =

if maxab lt minab or maxab lt 0 then return, -1
r = where((histogram(a, MIN=minab, MAX=maxab) ne 0) and (histogram(b, MIN=minab, MAX=maxab) ne 0), count)
if count eq 0 then return, -1 else return, r + minab
end

;------------------------------------------------------------------
;------------------------------------------------------------------

function cnp_test,trb,dr=dr,bondm=bondm
  start1=systime(/second)
  list=conlist111(trb(0:2,*),deltar=dr,bondmax=bondm)
  n=n_elements(trb(0,*))
  result=fltarr(1,n)
  for i=0l,n-1 do begin
     nn=list(i,0)
     if nn le 1 then continue
     list1=list(i,1:nn)
     sum=0.
    ;sum through the neighbor
      for j=0,nn-1 do begin
         nbii=list1(j)
         nnn=list(nbii,0)
         if nnn le 1 then continue
         list2=list(nbii,1:nnn)
         www=setintersection(list1,list2)
         if www[0] eq -1 then continue
         nwww=n_elements(www)
         sum1=[0.,0.,0.]
        ; sum through the common neighbor
           for k=0,nwww-1 do begin
             rik=trb(0:2,www(k))-trb(0:2,i)
             rjk=trb(0:2,www(k))-trb(0:2,nbii)
             temps=rik+rjk
             sum1=sum1+temps
           endfor
         sum1=total(sum1*sum1)
         sum=sum+sum1
      endfor
     result(i)=float(sum)/float(nn)
  endfor
  endtime1=systime(/second)
  print,'cnp running time',endtime1-start1
  return,result
end
 