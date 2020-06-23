;计算f(q)*q^2 
pro vecprj5,evc,pos,tr,lo,qtr,qlo,bins=bins
n1=n_elements(evc)/2
evc01=reform(evc,2,n1)
grid1=griddata(pos(0,*),pos(1,*),evc01(0,*),dimension=[bins+1,bins+1])
grid2=griddata(pos(0,*),pos(1,*),evc01(1,*),dimension=[bins+1,bins+1])
x001=[min(pos(0,*)),max(pos(0,*))]
y001=[min(pos(1,*)),max(pos(1,*))]
x01=interpol(x001,bins+1)
y01=interpol(y001,bins+1)
theta=findgen(bins+1,bins+1)
for i=0,bins do begin
for j=0,bins do begin
theta(i,j)=atan(y01(i)-y01(0),x01(j)-x01(0))
endfor
endfor
differ=grid1*cos(theta)+grid2*sin(theta)
curl=grid1*sin(theta)-grid2*cos(theta)
tr1=(abs(fft(differ,1)))^2
lo1=(abs(fft(curl,1)))^2
s1=bins/2
s2=bins
x1=tr1(0:s1,0:s1)
x2=tr1(0:s1,s1+1:s2)
x3=tr1(s1+1:s2,0:s1)
x4=tr1(s1+1:s2,s1+1:s2)
tr2=findgen(s2+1,s2+1)
tr2(0:s1-1,0:s1-1)=x4
tr2(s1:s2,s1:s2)=x1
tr2(0:s1-1,s1:s2)=x3
tr2(s1:s2,0:s1-1)=x2
y1=lo1(0:s1,0:s1)
y2=lo1(0:s1,s1+1:s2)
y3=lo1(s1+1:s2,0:s1)
y4=lo1(s1+1:s2,s1+1:s2)
lo2=findgen(s2+1,s2+1)
lo2(0:s1-1,0:s1-1)=y4
lo2(s1:s2,s1:s2)=y1
lo2(0:s1-1,s1:s2)=y3
lo2(s1:s2,0:s1-1)=y2
x001=[-512,512]
y001=[-512,512]
ra=findgen(bins+1,bins+1)
q01=3.14*(bins)/x001
q02=3.14*(bins)/y001 
q001=interpol(q01,bins+1)
q002=interpol(q02,bins+1)
for k=0,bins do begin
for l=0,bins do begin
tr2(k,l)=tr2(k,l)*((q001[k])^2+(q002[l])^2)
lo2(k,l)=lo2(k,l)*((q001[k])^2+(q002[l])^2)
ra(k,l)=sqrt((q001[k])^2+(q002[l])^2)
endfor
endfor
n22=n_elements(tr2)
tr001=reform(tr2,1,n22)
lo001=reform(lo2,1,n22)
ra001=reform(ra,1,n22)
av01=avgbin(ra001(0,*),tr001(0,*),binsize=(max(q001)-min(q001))/(s2))
av02=avgbin(ra001(0,*),lo001(0,*),binsize=(max(q001)-min(q001))/(s2))
ava1=av01([0,4],*)
ava2=av02([0,4],*)
tr=lo2
lo=tr2
qtr=ava2
qlo=ava1
end





