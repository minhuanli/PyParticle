;rotate Euler angle
;f1 is y, f2 is z
function rotate1, odata,angle=angle,f1=f1,f2=f2
ndata=odata
ndata(f1,*)=cos(angle)*odata(f1,*)+sin(angle)*odata(f2,*)
ndata(f2,*)=-sin(angle)*odata(f1,*)+cos(angle)*odata(f2,*)

return,ndata

end