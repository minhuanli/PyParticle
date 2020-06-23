;rotate cita and pesai
function rot_citapesai, odata,cita=cita,pesai=pesai,fx=fx,fy=fy,fz=fz
ndata=odata
ndata(fx,*)=cos(pesai)*odata(fx,*)-sin(pesai)*odata(fy,*)
ndata(fy,*)=sin(pesai)*cos(cita)*odata(fx,*)+cos(pesai)*cos(cita)*odata(fy,*)-sin(cita)*odata(fz,*) 
ndata(fz,*)=sin(pesai)*sin(cita)*odata(fx,*)+cos(pesai)*sin(cita)*odata(fy,*)+cos(cita)*odata(fz,*)

return,ndata

end
