pro split3,a,blow,bmid,bup
  zmax=max(a(2,*))
  zmin=min(a(2,*))
  dz=(zmax-zmin)/3
              
  blow  = a(*,where(a(2,*) ge zmin and a(2,*) le zmin+dz+5))
  bmid = a(*,where(a(2,*) ge zmin+dz-5 and a(2,*) le zmin+2*dz+5))
  bup  = a(*,where(a(2,*) ge zmin+2*dz-5 and a(2,*) le zmax))
  
end