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
;--------------------------------------------------------------------------------
;---------------------------------------------------------------------------------
;------------------------------------------------------------
function nb_type,cpdata=cpdata,data=data,dr=dr,bondm=bondm
n=n_elements(cpdata(0,*))
list=conlist111(data,deltar=dr,bondmax=bondm)
result=fltarr(8,n+1)
id=findid(cpdata=cpdata,data=data)
class=classify(data)

  for i=1.,n do begin
     nb=list(id(i-1),1:list(id(i-1),0))
     nbtype=class(nb)
     for j=0,7 do begin
        w=where(nbtype eq j+1,nw)
        result(j,i)=nw
     endfor
  endfor
  
  for k=0,7 do begin
        result(k,0)=mean(result(k,1:n))
  endfor
  
return,result

end



