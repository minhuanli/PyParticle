; this function aims to calculate local_number_density in z direction, (pay attention: it doesn't use vo cell)
; the final result: finalresult[i,j], i means time period,j means z ztack, finalresult[i,j] means the 
; local_number_density in number j z stack at i period
; there will be some -1 in the finalresult array, which means 缺省值
; if the local number density need smooth, one could smooth parameters. 
; tangshixiang 2015/11/21
function local_number_density,filename,z_length,smooth_array=smooth_array
 filename=file_search(filename)
 totalnumber=n_elements(filename)
 zmax=-9999.0
 zmin=9999.0
 for i=0,totalnumber-1 do begin
   bond=read_gdf(filename(i))
   zmax=max([Transpose(bond(2,*)),zmax])
   zmin=min([Transpose(bond(2,*)),zmin])
 endfor
 slides=round((zmax-zmin)/z_length)
 z_stack=(zmax-zmin)/double(slides) 
 finalresult=fltarr(totalnumber,slides)
 print,'zmin=',zmin,'   zmax=',zmax,'   z_stack=',z_stack,'   slides=',slides
 for i=0,totalnumber-1 do begin
   bond=read_gdf(filename(i))
   totalparticle=n_elements(bond(0,*))
   for j=0,slides-1 do begin
     z_begin=zmin+j*z_stack
     z_end=z_begin+z_stack
     w=where(bond(2,*) ge z_begin and bond(2,*) le z_end)
     finalresult(i,j)=(float(n_elements(w))/z_stack)/(totalparticle/(zmax-zmin))
   endfor 
 endfor
 if keyword_set(smooth_array) then finalresult=smooth(finalresult,smooth_array,/edge_truncate)
 return,finalresult
end