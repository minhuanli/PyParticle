pro write_nuclei_and_boundary,bond,class,boundary_thin=boundary_thin,boundary_thick=boundary_thick,name=name,gdf=gdf,txt=txt,dat=dat
 classnum=max(class)
 if not keyword_set(name) then begin
  print,'no name'
  return
 endif
 if (not keyword_set(gdf)) and (not keyword_set(txt)) and (not keyword_set(dat)) then begin
  print,'file format not set'
  return
 endif
 for i=1.,classnum do begin
  w=where(class eq i)
  if keyword_set(gdf) then write_gdf,bond[*,w],name+'crys'+string(i)+'.gdf'
  if keyword_set(txt) then write_text,bond[*,w],name+'crys'+string(i)+'.txt'
 endfor
 if keyword_set(boundary_thin) then begin
  if keyword_set(gdf) then write_gdf,boundary_thin,name+'thinboundary'+'.gdf'
  if keyword_set(txt) then write_text,boundary_thin,name+'thinboundary'+'.txt'  
 endif
 if keyword_set(boundary_thick) then begin
  if keyword_set(gdf) then write_gdf,boundary_thick,name+'thickboundary'+'.gdf'
  if keyword_set(txt) then write_text,boundary_thick,name+'thickboundary'+'.txt'  
 endif 
end