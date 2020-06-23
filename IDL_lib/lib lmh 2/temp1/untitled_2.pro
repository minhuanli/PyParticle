print,'pos1'
file0 = file_search('D:\liminhuan\s-s transition project\0809 data\boo\0809-boo-mf1\0809-boo-mf1-p       5-t*')
file1 = file_search('D:\liminhuan\s-s transition project\0809 data\boo\0809-boo-mf2\0809-boo-mf2-p       5-t*')
file = [file0,file1]
outfile = fltarr(14,40)
for i = 0,39 do begin
  
  boo = read_gdf(file(i))
  boo = edgecut(boo)
  
  zmax = max(boo(2,*))
  zmin = min(boo(2,*))
  dz=(zmax-zmin)/4
  b1  = boo(*,where(boo(2,*) ge zmin and boo(2,*) le zmin+dz))
  b2 = boo(*,where(boo(2,*) ge zmin+dz and boo(2,*) le zmin+2*dz))
  b3  = boo(*,where(boo(2,*) ge zmin+2*dz and boo(2,*) le zmin+3*dz))
  b4 = boo(*,where(boo(2,*) ge zmin+3*dz and boo(2,*) le zmin+4*dz))
  
;  slice1 = eclip(boo,[2,75,95])
;  slice2 = eclip(boo,[2,40,60])
;  slice3 = eclip(boo,[2,70,90])
  
  outfile(0,i) = 2
  outfile(1,i) = i
  
  n = n_elements(b1(0,*))
  w = where(b1(5,*) gt 0.35 and b1(8,*) lt -0.007,nw) ;rhcp
  ww = where(b1(5,*) gt 0.35 and b1(8,*) gt -0.007 and b1(8,*) lt 0,nww) ; precursor1
  www = where(b1(5,*) gt 0.35 and b1(8,*) gt 0.0,nwww) ;bcc
  wwww = where(b1(5,*) lt 0.35,nwwww) ; liquid
  outfile(2,i) = float(nwwww)/float(n)
  outfile(3,i) = float(nwww)/float(n)
  outfile(4,i) = float(nww)/float(n)
  
  n = n_elements(b2(0,*))
  w = where(b2(5,*) gt 0.35 and b2(8,*) lt -0.007,nw) ;rhcp
  ww = where(b2(5,*) gt 0.35 and b2(8,*) gt -0.007 and b2(8,*) lt 0,nww) ; precursor1
  www = where(b2(5,*) gt 0.35 and b2(8,*) gt 0.0,nwww) ;bcc
  wwww = where(b2(5,*) lt 0.35,nwwww) ; liquid
  outfile(5,i) = float(nwwww)/float(n)
  outfile(6,i) = float(nwww)/float(n)
  outfile(7,i) = float(nww)/float(n)
  
  n = n_elements(b3(0,*))
  w = where(b3(5,*) gt 0.35 and b3(8,*) lt -0.007,nw) ;rhcp
  ww = where(b3(5,*) gt 0.35 and b3(8,*) gt -0.007 and b3(8,*) lt 0,nww) ; precursor1
  www = where(b3(5,*) gt 0.35 and b3(8,*) gt 0.0,nwww) ;bcc
  wwww = where(b3(5,*) lt 0.35,nwwww) ; liquid
  outfile(8,i) = float(nwwww)/float(n)
  outfile(9,i) = float(nwww)/float(n)
  outfile(10,i) = float(nww)/float(n)
  
  n = n_elements(b4(0,*))
  w = where(b4(5,*) gt 0.35 and b4(8,*) lt -0.007,nw) ;rhcp
  ww = where(b4(5,*) gt 0.35 and b4(8,*) gt -0.007 and b4(8,*) lt 0,nww) ; precursor1
  www = where(b4(5,*) gt 0.35 and b4(8,*) gt 0.0,nwww) ;bcc
  wwww = where(b4(5,*) lt 0.35,nwwww) ; liquid
  outfile(11,i) = float(nwwww)/float(n)
  outfile(12,i) = float(nwww)/float(n)
  outfile(13,i) = float(nww)/float(n)
  
  
;  n = n_elements(slice2(0,*))
;  w = where(slice2(5,*) gt 0.35,nw)
;  ww = where(slice2(5,*) gt 0.35 and slice2(8,*) gt 0,nww)
;  outfile(4,i) = float(nw)/float(n)
;  outfile(5,i) = float(nww)/float(nw)
;  
;  n = n_elements(slice3(0,*))
;  w = where(slice3(5,*) gt 0.35,nw)
;  ww = where(slice3(5,*) gt 0.35 and slice3(8,*) gt 0,nww)
;  outfile(6,i) = float(nw)/float(n)
;  outfile(7,i) = float(nww)/float(nw)
;  
;  
  
;  zmax = max(boo(2,*))
;  zmin = min(boo(2,*))
;  dz=(zmax-zmin)/3
;  blowc = boo(*,where(boo(2,*) ge zmin and boo(2,*) le zmin+dz))
;  bmidc = boo(*,where(boo(2,*) ge zmin+dz and boo(2,*) le zmin+2*dz))
;  bupc  = boo(*,where(boo(2,*) ge zmin+2*dz and boo(2,*) le zmax))
;  blowc = edgecut(lower)
;  bmidc = edgecut(middle)
;  bupc = edgecut(upper)
;  
;  outfile(0,i) = 1
;  outfile(1,i) = i
;  ;low place 
;  n = n_elements(blowc(0,*))
;  w = where(blowc(5,*) gt 0.35,nw)
;  ww = where(blowc(5,*) gt 0.35 and blowc(8,*) gt 0,nww)
;  outfile(2,i) = float(nw)/float(n)
;  outfile(3,i) = float(nww)/float(nw)
;  
;   ;mid place 
;  n = n_elements(bmidc(0,*))
;  w = where(bmidc(5,*) gt 0.35,nw)
;  ww = where(bmidc(5,*) gt 0.35 and bmidc(8,*) gt 0,nww)
;  outfile(4,i) = float(nw)/float(n)
;  outfile(5,i) = float(nww)/float(nw)
;  
;   ;up place 
;  n = n_elements(bupc(0,*)) 
;  w = where(bupc(5,*) gt 0.35,nw)
;  ww = where(bupc(5,*) gt 0.35 and bupc(8,*) gt 0,nww)
;  outfile(6,i) = float(nw)/float(n)
;  outfile(7,i) = float(nww)/float(nw)
;  
;  ;all place
;  n = n_elements(boo(0,*))
;  w = where(boo(5,*) gt 0.35,nw)
;  ww = where(boo(5,*) gt 0.35 and boo(8,*) gt 0,nww)
;  outfile(8,i) = float(nw)/float(n)
;  outfile(9,i) = float(nww)/float(nw)  
  
  
  endfor
  
  write_text,outfile,'D:\liminhuan\s-s transition project\0809 data\fig\p5_allratio.txt'
  
  end