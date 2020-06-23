  
 
function calbccstk,boo,deltar=deltar,per=per,pos0=pos0,num=num,siz=siz,ic=ic,is=is,w1=w1,w8=w8,w3=w3,w4=w4,nw1=nw1,nw8=nw8,nw3=nw3,nw4=nw4
  
  gb_cr,boo,gb,cr
  n1=n_elements(cr(0,*))
  per=fltarr(9)
  num=fltarr(9)
  siz=fltarr(9)

  
  if (n1 lt 2000) then begin 
  print,'no big enough size cluster'
  nw1=0
  nw3=0
  nw8=0
  nw4=0
  endif else begin
  
  idnuclei2,cr,c01,list=s01,deltar=deltar,type=4 
  w=where(s01(0,*) gt 100, nw)  
  if (nw le 0) then begin
   print,'no big enough size cluster'
   nw1=0
  nw3=0
  nw8=0
  nw4=0
  endif else begin
  print,s01(0,w)
  
  
  c1=selecluster2(cr,c01=c01,nb=w(0))
  sz1=n_elements(c1(0,*))
  
  if (sz1 gt 4000) then c1=c1(*,0:4000) else c1=c1 
  pos=patch_center(cr=c1(*,*),data=boo,sr=5,rmax=deltar+0.1,nmax=15,dr=0.2,np=14)
 
  for j=1,nw-1 do begin
    ctemp=selecluster2(cr,c01=c01,nb=w(j))
    sz=n_elements(ctemp(0,*))
    if (sz gt 4000) then ctemp=ctemp(*,0:4000) else ctemp=ctemp 
    ptemp=patch_center(cr=ctemp(*,*),data=boo,sr=5,rmax=deltar,nmax=15,dr=0.2,np=14)
    pos=[[pos],[ptemp]]
  endfor 
  

  
  if (keyword_set(pos0)) then refpos=pos0 else refpos=pos(0:2,0:13)
  
  calbcc_xy,pos10=pos(0:2,0:13),pos20=refpos,atemp
  angle=atemp
  for k=1,nw-1 do begin
     ;for m=k+1,nw-1  do begin
     calbcc_xy,pos10=pos(0:2,(14*k):(14*(k+1)-1)),pos20=refpos,atemp
     angle=[angle,atemp]
  endfor

angle=[[transpose(s01(0,w))],[angle]]

n=total(angle(*,0))
;0-5
w1=where(angle(*,1) ge 0L and angle(*,1) le 5L,nw1)
if nw1 gt 0 then n1=total(angle(w1,0)) else n1=0L
print,w1
;5-15
w2=where(angle(*,1) gt 5L and angle(*,1) le 15L,nw2)
if nw2 gt 0 then n2=total(angle(w2,0)) else n2=0L
print,w2
;15-25
w3=where(angle(*,1) gt 15L and angle(*,1) le 25L,nw3)
if nw3 gt 0 then n3=total(angle(w3,0)) else n3=0L
print,w3
;25-35
w4=where(angle(*,1) gt 25L and angle(*,1) le 35L,nw4)
if nw4 gt 0 then n4=total(angle(w4,0)) else n4=0L
print,w4
;35-45
w5=where(angle(*,1) gt 35L and angle(*,1) le 45L,nw5)
if nw5 gt 0 then n5=total(angle(w5,0)) else n5=0L
print,w5
;45-55
w6=where(angle(*,1) gt 45L and angle(*,1) le 55L,nw6)
if nw6 gt 0 then n6=total(angle(w6,0)) else n6=0L
print,w6
;55-65
w7=where(angle(*,1) gt 55L and angle(*,1) le 65L,nw7)
if nw7 gt 0 then n7=total(angle(w7,0)) else n7=0L
print,w7
;65-75
w8=where(angle(*,1) gt 65L and angle(*,1) le 75L,nw8)
if nw8 gt 0 then n8=total(angle(w8,0)) else n8=0L
print,w8
;75-85
w9=where(angle(*,1) ge 75L and angle(*,1) le 85L,nw9)
if nw9 gt 0 then n9=total(angle(w9,0)) else n9=0L
print,w9

per(0)=float(n1)/float(n)
per(1)=float(n2)/float(n)
per(2)=float(n3)/float(n)
per(3)=float(n4)/float(n)
per(4)=float(n5)/float(n)
per(5)=float(n6)/float(n)
per(6)=float(n7)/float(n)
per(7)=float(n8)/float(n)
per(8)=float(n9)/float(n)

num(0)=nw1
num(1)=nw2
num(2)=nw3
num(3)=nw4
num(4)=nw5
num(5)=nw6
num(6)=nw7
num(7)=nw8
num(8)=nw9

siz(0)=n1
siz(1)=n2
siz(2)=n3
siz(3)=n4
siz(4)=n5
siz(5)=n6
siz(6)=n7
siz(7)=n8
siz(8)=n9
ic=c01
is=s01
return,angle 


endelse
endelse
end
