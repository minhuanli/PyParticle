;cluster analyze of 2d, data2 (*,j) contain the eigen 
;vectors of the cluster size in list(0,j), list(1,j) is the 
;gyration radius of jth cluster
function conmatrix2d,a2,deltar=deltar
triangulate,a2(0,*),a2(1,*),tr,connectivity=c1
n1=n_elements(a2(0,*))
m1=fltarr(n1,n1)
for j=0.,n1-1 do begin
b1=c1[c1[j]:c1[j+1]-1]
bx1=(a2(0,j)-a2(0,b1))^2+(a2(1,j)-a2(1,b1))^2
w=where(bx1 lt deltar^2,nc)
if nc gt 0 then begin
m1(j,b1[w])=-1
m1(j,j)=nc
endif
;print,j
endfor
return,m1
end

;find the connected shell of id1 in dm1
function idshell2d,dm1,id1
n1=n_elements(id1)
id2=id1
for j=0,n1-1 do begin
c1=dm1(id2[j],*)
w=where(c1 eq -1,nc)
if nc gt 0 then begin
id2=[id2,w]
endif
endfor
id2=id2[uniq(id2,sort(id2))]
return,id2
end

;find the full cluster id1 connected in dm1 
function idloop2d,dm1,id1
id2=id1
repeat begin
ida=idshell2d(dm1,id2)
na=n_elements(ida)
nb=n_elements(id2)
id2=ida
endrep until na eq nb
id3=id2
return,id2
end

;cluster analyze, data2 (*,j) contain the eigen 
;vectors of the cluster size in list(0,j), list(1,j) is the 
;gyration radius of jth cluster
pro idcluster2d,data,data2,deltar=deltar,list=list
n1=n_elements(data(0,*))
dm1=conmatrix2d(data,deltar=deltar)
idd=fltarr(n1)
data1=fltarr(n1)
list1=0
repeat begin
id0=fltarr(n1)
w=where(idd eq 0,na)
if na gt 0 then begin
ida=idloop(dm1,w[0])
idd[ida]=1
id0[ida]=1
data1=[[data1],[id0]]
ndd=n_elements(ida)
list1=[list1,ndd]
endif
endrep until na eq 0
nb=n_elements(data1(0,*))
data2=data1(*,1:nb-1)
lista=list1(1:nb-1)
list=fltarr(2,nb-1)
list(0,*)=lista
gy01=fltarr(nb-1)
for j=0,nb-2 do begin
w=where(data2(*,j) eq 1,ns)
x0=mean(data(0,w))
y0=mean(data(1,w))
;z0=mean(data(2,w))
r1=sqrt(mean((data(0,w)-x0)^2+(data(1,w)-y0)^2))
gy01[j]=r1
endfor
list(1,*)=gy01
end





