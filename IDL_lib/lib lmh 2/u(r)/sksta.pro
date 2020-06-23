function sksta,sk1,delta

ww=where(sk1(4,*) lt 200)
sk=sk1(*,ww)
max1=max(sk(0,*))
min1=min(sk(0,*))
n=round( (max1-min1)/delta )
result=[-1,-1]

for i=0,n do begin
  w=where(sk(0,*) ge min1+i*delta and sk(0,*) lt min1+(i+1)*delta,nw)
  if nw eq 0 then continue
  temp=[min1+i*delta,mean(sk(4,w))]
  result=[[result],[temp]]
endfor

return,result
end