;0)meanx,1,meany,2,meanz,3,x fluctuation,4,yfluctuation,5,zfluctuation,6,x+y+z,7,mean bond,8,bond fluctuation,9,mean q4,10,q4 fluctuation
;11,mean q6,12,q6 fluctuation,13,mean w6,14,w6 fluctuation,15,particle id
function mobility3d,trb
dim1=n_elements(trb(*,0))
n1=max(trb(dim1-1,*))
t1=max(trb(dim1-2,*))
ma=findgen(16,n1+1)
for j=0,n1 do begin
w=where(trb(dim1-1,*) eq j)
pos1=trb(*,w)
m01=mean(pos1(0,*))
m02=mean(pos1(1,*))
m03=mean(pos1(2,*))
pos1(0,*)=pos1(0,*)-m01
pos1(1,*)=pos1(1,*)-m02
pos1(2,*)=pos1(2,*)-m03
m1=mean(pos1(0,*)^2)
m2=mean(pos1(1,*)^2)
m3=mean(pos1(2,*)^2)
m4=m1+m2+m3
m5=mean(pos1(3,*))
m6=mean(pos1(3,*)^2)-(mean(pos1(3,*)))^2
m7=mean(pos1(4,*))
m8=mean(pos1(4,*)^2)-(mean(pos1(4,*)))^2
m9=mean(pos1(5,*))
m10=mean(pos1(5,*)^2)-(mean(pos1(5,*)))^2
m11=mean(pos1(6,*))
m12=mean(pos1(6,*)^2)-(mean(pos1(6,*)))^2
ma(0,j)=m01
ma(1,j)=m02
ma(2,j)=m03
ma(3,j)=m1
ma(4,j)=m2
ma(5,j)=m3
ma(6,j)=m4
ma(7,j)=m5
ma(8,j)=m6
ma(9,j)=m7
ma(10,j)=m8
ma(11,j)=m9
ma(12,j)=m10
ma(13,j)=m11
ma(14,j)=m12
ma(15,j)=j
print,j
endfor
mol=ma
return,mol
end