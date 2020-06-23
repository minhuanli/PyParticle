;find the centre of a patch, in the form of unit vector
function idcenter,data
n=n_elements(data(1,*))
xsum=0.
ysum=0.
zsum=0.
ave=fltarr(3,1)

for i=0.,n-1 do begin
   xsum=xsum+data(0,i)
   ysum=ysum+data(1,i)
   zsum=zsum+data(2,i)
endfor

ave(0,0)=float(xsum)/float(n)
ave(1,0)=float(ysum)/float(n)
ave(2,0)=float(zsum)/float(n)
r2=ave(0,0)*ave(0,0)+ave(1,0)*ave(1,0)+ave(2,0)*ave(2,0)
ratio=sqrt(r2)
ave(0,0)=ave(0,0)*5/ratio
ave(1,0)=ave(1,0)*5/ratio
ave(2,0)=ave(2,0)*5/ratio

return,ave

end