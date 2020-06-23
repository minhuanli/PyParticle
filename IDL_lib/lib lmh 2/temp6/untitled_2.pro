file0 = file_search('D:\liminhuan\s-s transition project\0808 data\boo\mf1\0809-boo-mf1-p       1-t*')
file1 = file_search('D:\liminhuan\s-s transition project\0808 data\boo\mf2\0809-boo-mf2-p       1-t*')
file = [file0,file1]
outfile = fltarr(14,40)
rad1 = 0.07
rad2 = 0.8
rad3 = 0.8
rad4 = 0.8
color1 = [0.,0.,0.]  ; dark
color2 = [0.,0.,192./255.]  ;blue
color3 = [144./255.,72./255.,0.]  ;brown
color4 = [255.,128.,0.]/255.  ;orange
for i = 10,39 do begin 
  boo = read_gdf(file[i])
  bc = edgecut(boo)
  box = eclip(bc,[0,40,70],[1,10,40],[2,10,40])
  w1 = where(box(5,*) gt 0.35 and box(8,*) lt -0.007,nw1)  ; regular rhcp
  w2 = where(box(5,*) lt 0.25,nw2)   ; liquid 
  w3 = where(box(5,*) gt 0.35 and box(8,*) gt 0,nw3) ; bcc
  w4 = where(box(5,*) gt 0.35 and box(8,*) gt -0.007 and box(8,*) lt 0,nw4)  ; precursor
  ct = [nw1,nw2,nw3,nw4]
  
  pos = [-1,-1,-1]
  rad = [-1.]
  color = [-1.,-1.,-1.]
  for j = 0 ,3 do begin
     if ct[j] eq 0 then continue
     
     if j eq 0 then begin 
       post = box(0:2,w1) 
       radt = fltarr(1,ct(j))
       radt[0,*] = rad1
       colort = fltarr(3,ct(j))
       colort[0,*] = color1[0]
       colort[1,*] = color1[1]
       colort[2,*] = color1[2]
     endif
       
     if j eq 1 then begin
       post = box(0:2,w2) 
       radt = fltarr(1,ct(j))
       radt[0,*] = rad2
       colort = fltarr(3,ct(j))
       colort[0,*] = color2[0]
       colort[1,*] = color2[1]
       colort[2,*] = color2[2]
     endif
       
     if j eq 2 then begin
       post = box(0:2,w3) 
       radt = fltarr(1,ct(j))
       radt[0,*] = rad3
       colort = fltarr(3,ct(j))
       colort[0,*] = color3[0]
       colort[1,*] = color3[1]
       colort[2,*] = color3[2]
    endif
    
    if j eq 3 then begin  
       post = box(0:2,w4) 
       radt = fltarr(1,ct(j))
       radt[0,*] = rad4
       colort = fltarr(3,ct(j))
       colort[0,*] = color4[0]
       colort[1,*] = color4[1]
       colort[2,*] = color4[2]
     endif
     pos = [[pos],[post]]
     rad = [[rad],[radt]]
     color = [[color],[colort]]
  endfor
  pos = pos[*,1:total(ct)]
  rad = rad[*,1:total(ct)]
  color = color[*,1:total(ct)]
  
  
  mkpov,pos,'D:\liminhuan\s-s transition project\0808 data\fig\povray\pos1-20-40\'+'t'+string(i)+'.pov',radius=rad,color=color,margin=1.2
  endfor

end
     
  
  