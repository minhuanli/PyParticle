;cluster analyze, data2 (*,j) contain the eigen 
;vectors of the cluster size in list(0,j), list(1,j) is the 
;gyration radius of jth cluster
pro idcluster,data,data2,deltar=deltar,list=list,conm=conm
n1=n_elements(data(0,*))
dm1=conmatrix(data,deltar=deltar)
if (keyword_set(conm)) then dm1=conm
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
z0=mean(data(2,w))
r1=sqrt(mean((data(0,w)-x0)^2+(data(1,w)-y0)^2+(data(2,w)-z0)^2))
gy01[j]=r1
endfor
list(1,*)=gy01
end


