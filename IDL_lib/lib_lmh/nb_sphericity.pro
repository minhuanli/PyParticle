
;--------------------------------------------------------------------------------
;----------------------------------------------------------------------------------
function findid,cpdata=cpdata,data=data,fail=fail
  ww=n_elements(cpdata(0,*))
  id=lonarr(ww)
  fail=[-1]
  for i=0.,ww-1 do begin
    w=where(data(0,*) eq cpdata(0,i) and data(1,*) eq cpdata(1,i) and data(2,*) eq cpdata(2,i), nw)
    if nw ge 1 then begin
      id(i)=w(0)
    endif else begin
      print,'find no corresponding particle in the background particles'
      fail=[fail,i]
    endelse
  endfor
  
  return,id
  
  end
;----------------------------------------------------------------------------------
;================================================================================== 
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
; outcome a standard deviation of bond lengths
; set the neighbor number as nb
; still use a conlist funciton to produce a neighbor list
; output : standard deviation/mean bond length, mean bond length
function nb_sphericity,cpdata=cpdata,data=data,dr=dr,nmax=nmax
  list=conlist111(data,deltar=dr,bondmax=nmax,distance=distance)
  start1=systime(/second)
  if keyword_set(idd) then cpid=idd else cpid=findid(cpdata=cpdata,data=data)
  nn=n_elements(cpid) 
  result=[-1.,-1.,-1.]
  for j=0l,nn-1 do begin
    tempj = [0.,0.,0.]
    nnn=list(cpid(j),0)
    if nnn le 0 then continue
    tempj(1)= mean(distance(cpid(j),1:nnn)) 
    tempj(0)= stddev(distance(cpid(j),1:nnn)) / mean(distance(cpid(j),1:nnn)) 
    tempj(2)= nnn
    result=[[result],[tempj]]
  endfor
  n=n_elements(result(0,*))
  endtime1=systime(/second)
  print,'running time',endtime1-start1
  return,result(*,1:n-1)
  
end



















