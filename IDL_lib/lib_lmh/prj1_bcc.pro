;project bcc's crystal particle's neighbours to the sphere
;keep the distance ratio unchanged
function prj1_bcc, sr1=sr1, data1=data1 , cp1=cp1 , rm1=rm1, nm1=nm1 

nb1=selectnearest(data1,cp=cp1,rmax=rm1, nmax=nm1)
n=n_elements(nb1(0,*))
x0=nb1(1,0)
y0=nb1(2,0)
z0=nb1(3,0)
w=reverse(sort(nb1(0,*)))
rr=nb1(0,w(0))
ratio=float(sr1)/float(sqrt(rr))
prj=fltarr(3,n-1)
for i=1.,(n-1) do begin
  x=nb1(1,i)
  y=nb1(2,i)
  z=nb1(3,i)
  prj(0,(i-1))=ratio*(x-x0)
  prj(1,(i-1))=ratio*(y-y0)
  prj(2,(i-1))=ratio*(z-z0)
endfor
 
return,prj  
end 