gkernel=[[1,8,15,8,1],[8,63,127,63,8],[15,127,255,127,15],[8,63,127,63,8],[1,8,15,8,1]]
ff1=fltarr(1024,1024,46)

for i=0,45 do begin 
ff1(*,*,i)=convol(f1(*,*,i),gkernel,invalid=255,missing=0,/normalize,/edge_zero)
endfor

end