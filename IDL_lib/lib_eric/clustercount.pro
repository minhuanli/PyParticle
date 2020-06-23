pro clustercount,boo,deltar=deltar,solid=solid,bcc=bcc,fcchcp=fcchcp,mrco=mrco
ta=min(boo(15,*))+findgen(max(boo(15,*))-min(boo(15,*))+1)
nta=max(boo(15,*))-min(boo(15,*))+1
list01=0
list02=0
list03=0
list04=0
gy01=0.
gy02=0.
gy03=0.
gy04=0.
t01=0
t02=0
t03=0
t04=0
for j=0,nta-1 do begin
w=where(boo(15,*) eq ta[j])
b01=boo(*,w)
w1=where(b01(3,*) ge 7.0,nc1)
if nc1 gt 0 then begin
w2=where(b01(3,*) ge 7.0 and b01(14,*) lt 13,nc2)
if nc2 gt 0 then begin
w3=where(b01(3,*) ge 7.0 and b01(14,*) gt 13,nc3)
if nc3 gt 0 then begin
w4=where(b01(3,*) lt 7.0 and b01(5,*) gt 0.27)
idcluster,b01(*,w1),deltar=deltar,list=lista1
list1=transpose(lista1(0,*))
gy1=transpose(lista1(1,*))
gy01=[gy01,gy1]
list01=[list01,list1]
n1=n_elements(list1)
t1=fltarr(n1)+ta[j]
t01=[t01,t1]
idcluster,b01(*,w2),deltar=deltar,list=lista2
list2=transpose(lista2(0,*))
gy2=transpose(lista2(1,*))
gy02=[gy02,gy2]
list02=[list02,list2]
n2=n_elements(list2)
t2=fltarr(n2)+ta[j]
t02=[t02,t2]
idcluster,b01(*,w3),deltar=deltar,list=lista3
list3=transpose(lista3(0,*))
gy3=transpose(lista3(1,*))
gy03=[gy03,gy3]
list03=[list03,list3]
n3=n_elements(list3)
t3=fltarr(n3)+ta[j]
t03=[t03,t3]
idcluster,b01(*,w4),deltar=deltar,list=lista4
list4=transpose(lista4(0,*))
gy4=transpose(lista4(1,*))
gy04=[gy04,gy4]
list04=[list04,list4]
n4=n_elements(list4)
t4=fltarr(n4)+ta[j]
t04=[t04,t4]
print,j
endif
endif
endif
endfor
n11=n_elements(list01)
c01=fltarr(3,n11-1)
c01(0,*)=transpose(list01(1:n11-1))
c01(1,*)=transpose(gy01(1:n11-1))
c01(2,*)=transpose(t01(1:n11-1))
n22=n_elements(list02)
c02=fltarr(3,n22-1)
c02(0,*)=transpose(list02(1:n22-1))
c02(1,*)=transpose(gy02(1:n22-1))
c02(2,*)=transpose(t02(1:n22-1))
n33=n_elements(list03)
c03=fltarr(3,n33-1)
c03(0,*)=transpose(list03(1:n33-1))
c03(1,*)=transpose(gy03(1:n33-1))
c03(2,*)=transpose(t03(1:n33-1))
n44=n_elements(list04)
c04=fltarr(3,n44-1)
c04(0,*)=transpose(list04(1:n44-1))
c04(1,*)=transpose(gy04(1:n44-1))
c04(2,*)=transpose(t04(1:n44-1))
solid=c01
bcc=c03
fcchcp=c02
mrco=c04
end



