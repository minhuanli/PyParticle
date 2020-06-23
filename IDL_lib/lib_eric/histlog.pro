function histlog,data7,number=number,points=points,mictopix=mictopix
data8=data7/(mictopix^2)
n111=n_elements(data8)
data01=data8(0:number-1)
omg1=1./sqrt(abs(data01))
w12=where(omg1 lt 2000)
data=omg1(w12)
data2=abs(data)
data1=data2[sort(data2)]
n1=n_elements(data1)
omg001=min(data1)
omg002=max(data1)
delta=omg002/omg001
x1=findgen(points+1)
xa=alog10(omg002/omg001)/points
sa=findgen(points)
sb=findgen(points)
sc=findgen(points)
xb=omg001*10^(xa*x1)
for j=0,points-1 do begin
a001=xb(j)
a002=xb(j+1)
w=where(data1 ge a001 and data1 lt a002,count)
s001=count*1.0/(a002-a001)
sa[j]=s001
sb[j]=2.0*s001/(a001+a002)
sc[j]=4.0*s001/((a001+a002)^2)
endfor
n001=number*1.0/(n111*total(sa))
saa=sa*n001
sbb=sb*n001
scc=sc*n001
h001=findgen(4,points)
h001(0,*)=xb[0:points-1]
h001(1,*)=saa
h001(2,*)=sbb
h001(3,*)=scc
return,h001
end