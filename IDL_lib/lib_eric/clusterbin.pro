;transform bond order files with cluster size (16,*),gyration radius(17,*), distance to center of cluster (18,*).
function clusterbin,boo,deltar=deltar
ta=max(boo(15,*))-min(boo(15,*))+1
tb=min(boo(15,*))+findgen(ta)
n1=n_elements(boo(0,*))
id1=fltarr(3,n1)
for j=0,ta-1 do begin
print,j
w=where(boo(15,*) eq tb[j])
b01=boo(*,w)
id01=id1(*,w)
w1=where(b01(3,*) ge 7.0,na)
if na gt 0 then begin
b02=b01(*,w1)
id02=id01(*,w1)
idcluster,b02,ba,deltar=deltar,list=list1
nb=n_elements(list1(0,*))
for i=0,nb-1 do begin
w2=where(ba(*,i) eq 1)
id02(0,w2)=list1(0,i)
id02(1,w2)=list1(1,i)
id02(2,w2)=sqrt((b02(0,w2)-mean(b02(0,w2)))^2+(b02(1,w2)-mean(b02(1,w2)))^2+(b02(2,w2)-mean(b02(2,w2)))^2)
endfor
id01(*,w1)=id02
endif
w1=where(b01(3,*) lt 7.0 and b01(5,*) gt 0.27,na)
if na gt 0 then begin
b02=b01(*,w1)
id02=id01(*,w1)
idcluster,b02,ba,deltar=deltar,list=list1
nb=n_elements(list1(0,*))
for i=0,nb-1 do begin
w2=where(ba(*,i) eq 1)
id02(0,w2)=list1(0,i)
id02(1,w2)=list1(1,i)
id02(2,w2)=sqrt((b02(0,w2)-mean(b02(0,w2)))^2+(b02(1,w2)-mean(b02(1,w2)))^2+(b02(2,w2)-mean(b02(2,w2)))^2)
endfor
id01(*,w1)=id02
endif
id1(*,w)=id01
endfor
boo01=[boo,id1]
return,boo01
end

