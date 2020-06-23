;=====================================================================================================
;----------------------------------------------------------------------------------------------------
function conlist22,a2,deltar=deltar,bondmax=bondmax,distance=distance
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
   ;distance[j,0]=bondmax11
   distance[j,1:bondmax11]=bx1[0:(bondmax11-1)]
  endif else begin
   list[j,0]=nc
   list[j,1:nc]=b1[0:(nc-1)]
   ;distance[j,0]=nc
   distance[j,1:nc]=bx1[0:(nc-1)]
  endelse   
 endfor
 endtime=systime(/second)
 print,'conlist running time',endtime-start
 return,list
end
;--------------------------------------------------------------------------------
;-----------------------------------------------------------------
FUNCTION SetIntersection, a, b
minab = min(a, MAX=maxa) > min(b, MAX=maxb) ;Only need intersection of

maxab = maxa < maxb
 
  ;If either set is empty, or their ranges don't intersect: result =

if maxab lt minab or maxab lt 0 then return, -1
r = where((histogram(a, MIN=minab, MAX=maxab) ne 0) and (histogram(b, MIN=minab, MAX=maxab) ne 0), count)
if count eq 0 then return, -1 else return, r + minab
end

;------------------------------------------------------------------
;--------------------------------------------------------------------------------
function cal_angle,v1,v2
if norm(v1-v2) le 0.00001 then begin
a=0L 
endif else begin
x1=v1(0,*)
y1=v1(1,*)
z1=v1(2,*)
x2=v2(0,*)
y2=v2(1,*)
z2=v2(2,*)
r1=sqrt(x1*x1+y1*y1+z1*z1)
r2=sqrt(x2*x2+y2*y2+z2*z2)
cs=(x1*x2+y1*y2+z1*z2)/((r1*r2)+0.0000001)
a=acos(cs)
endelse 
return,a
end
;====================================================================================
;------------------------------------------------------------------------------------
;--------deltar is the first gr minimal to judge the bond relation-----------------------
;--------dc should be sqrt(2)*dr, and dr is the first gr peak. dc is a cutoff for the 'long' bond.--------
;--------cnnb, cnrl are both output------------------
;--------list and dist can be set if the adjacent list and corresponding distance list are calculated-----------
FUNCTION octaqhull,trb,deltar=deltar,bondmax=bondmax,dc=dc,cnnb=cnnb,cnrl=cnrl,list=list,dist=dist
  if (keyword_set(list)) and (keyword_set(dist)) then begin
     syslist=list
     sysdist=dist
  endif else begin
     syslist=conlist22(trb(0:2,*),deltar=deltar,bondmax=bondmax,distance=sysdist)
  endelse
  ;-------------------------find the long bonds----------------------------------  
start1=systime(/second)
     www=where(sysdist gt dc,nwww)
if nwww eq 0 then begin
     print,'no long bonds! please check input!'
     result=[-1]
endif else begin
     linenb=n_elements(syslist(*,0))
     cnnb=[-1]
     cnrl=[-1]
     result=[-1,-1,-1,-1,-1,-1,-1]
     for i=0l,nwww-1 do begin
    ;------------find the two particles aa & bb which form the bond-------------
        aa=www(i) mod long(linenb)
        bbindex=fix(www(i) / long(linenb))
        bb=syslist(aa,bbindex)
    ;----------------prevent the same bond being calculated twice-----------
        qqq=where(result(2,*) eq aa and result(1,*) eq bb, nqqq)
        if nqqq ne 0 then continue    
    ;------------find the common neighbor of aa & bb-------------------    
        listaa=syslist(aa,1:syslist(aa,0))
        listbb=syslist(bb,1:syslist(bb,0))
        ww=setintersection(listaa,listbb) ;ww is the common neighbor list
        nww=n_elements(ww)
        cnnb=[[cnnb],[nww]]
        if nww ne 4 then continue
    ;------------------examine the relation between the four common neighbors cc,dd,ee,ff-------------------
        listcc=syslist(ww(0),1:syslist(ww(0),0))
        listdd=syslist(ww(1),1:syslist(ww(1),0))
        listee=syslist(ww(2),1:syslist(ww(2),0))
        listff=syslist(ww(3),1:syslist(ww(3),0))
        nbcc=n_elements(setintersection(listcc,ww))
        nbdd=n_elements(setintersection(listdd,ww))
        nbee=n_elements(setintersection(listee,ww))
        nbff=n_elements(setintersection(listff,ww))
        tcnrl=1000*nbcc+100*nbdd+10*nbee+nbff
        cnrl=[[cnrl],[tcnrl]]
    ;-----------------sort the cc,dd,ee&ff by clockwise or anti-clockwise----------------------------
        ccdd=trb(0:2,ww(1))-trb(0:2,ww(0))
        ccee=trb(0:2,ww(2))-trb(0:2,ww(0))
        ccff=trb(0:2,ww(3))-trb(0:2,ww(0))
        cp1=crossp(ccdd,ccee)
        cp2=crossp(ccdd,ccff)
        judge1=total(cp1*cp2)
        if judge1 le 0 then begin
          ;-------------then the 4 line is ccee,eedd,ddff, ffcc-------------------
          ll0=[total(ccee*ccee),total((trb(0:2,ww(1))-trb(0:2,ww(2)))^2),total((trb(0:2,ww(3))-trb(0:2,ww(1)))^2),total(ccff*ccff)]
        endif else begin
          cita1=cal_angle(ccdd,ccee)
          cita2=cal_angle(ccdd,ccff)
            if cita1 le cita2 then begin 
               ;-----------the 4 line is ccdd,ddee,eeff,ffcc---------
                ll0=[total(ccdd*ccdd),total((trb(0:2,ww(1))-trb(0:2,ww(2)))^2),total((trb(0:2,ww(3))-trb(0:2,ww(2)))^2),total(ccff*ccff)]
            endif else begin
               ;----------the 4 line is ccdd,ddff,ffee,eecc----------
                ll0=[total(ccdd*ccdd),total((trb(0:2,ww(3))-trb(0:2,ww(1)))^2),total((trb(0:2,ww(3))-trb(0:2,ww(2)))^2),total(ccee*ccee)] 
            endelse
        endelse
    ;------------------calculate the octacity(regularity) of the octahedron, stddev of the 12 lines-------------------------------------   
        ll1=(trb(0,aa)-trb(0,ww))^2+(trb(1,aa)-trb(1,ww))^2+(trb(2,aa)-trb(2,ww))^2
        ll2=(trb(0,bb)-trb(0,ww))^2+(trb(1,bb)-trb(1,ww))^2+(trb(2,bb)-trb(2,ww))^2
        ll=[transpose(ll0),ll1,ll2]
        ocity=stddev(ll)/mean(ll)
        tempr=[ocity,aa,bb,ww]
        result=[[result],[tempr]]
     endfor
endelse
 fnn=n_elements(result(0,*))
 result=result(*,1:fnn-1)
endtime1=systime(/second)
print,'oct running time',endtime1-start1
     return,result  
end
        
  
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     