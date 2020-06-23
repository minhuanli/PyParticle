function surf_rough1,trb=trb,rmax=rmax
pi=3.1415926
list=conlist111(trb,deltar=rmax,bondmax=15)
n=n_elements(trb(0,*))
result=fltarr(1,n)
for i=0,n-1 do begin
  cp=trb(0:2,i)
  nn=list(i,0)
  if nn lt 3 then continue
  nb=trb(0:2,list(i,1:nn))
  nb=nb(*,polyseq(nb))
  nb=[[nb],[nb(*,0)]]
  result(i)=0.
  for j=0,nn-1 do begin
    vec1=nb(*,j)-cp
    vec2=nb(*,j+1)-cp
    temp=cal_angle(vec1,vec2)
    result(i)=result(i)+temp
  endfor
endfor
result(*)=abs(result-2*pi)/(2*pi)
return,result

end
