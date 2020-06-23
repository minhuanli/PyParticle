;rotate the oblique crystal faces to vertical ones
;angle parament here is the angle between the crystal face and the coordinate plane f1, users should  measure it by hand
;the angle here is radian
;2015.10.22 original vision  by lmh
pro rotate,odata,ndata,f1=f1,f2=f2,angle=angle 
ndata=odata
ndata(f1,*)=odata(f1,*)*cos(angle)+odata(f2,*)*sin(angle)
ndata(f2,*)=odata(f2,*)*cos(angle)-odata(f1,*)*sin(angle)

end