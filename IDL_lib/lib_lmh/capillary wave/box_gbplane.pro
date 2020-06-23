;designed for gbdy1026, box the plane after the rotate, input data is the particle poss after rotate
;box on the xy plane,add two indice behind the data
;ave is the average z of box(i,j) above all time, 0,indice i; 1, indice j; 2, number; 3, average z
;boxt is the average z of box(i,j) at specific time, 0,indice i; 1, indice j; 2, number; 3, average z; 4, fluctuate 5, time 
pro box_gbplane,data=data,nbx=nbx,nby=nby,ave=ave,boxt=boxt
xmax = max(data(0,*))
xmin = min(data(0,*))
ymax = max(data(1,*))
ymin = min(data(1,*))
time = data(3,uniq(data(3,*)))
nt = n_elements(time(0,*))
deltax = (xmax - xmin)/float(nbx)
deltay = (ymax - ymin)/float(nby)
print,'deltax:',deltax
print,'deltay:',deltay
indice = fltarr(2,n_elements(data(0,*)))
ave = fltarr(4,nbx*nby)
boxt = fltarr(6,nbx*nby*nt)
m=-1.
k=-1.
  for i = 0,nbx -1 do begin 
    for j = 0,nby-1 do begin
      w=where(data(0,*) ge (xmin+i*deltax) and data(0,*) lt (xmin+(i+1)*deltax) and data(1,*) ge (ymin+j*deltay) and data(1,*) lt (ymin+(j+1)*deltay),nw)
      k = k + 1.
      ave(0,k) = i
      ave(1,k) = j
      ave(2,k) = nw
      if nw eq 0 then continue 
      indice(0,w)=i
      indice(1,w)=j
      ave(3,k) = mean(data(2,w)) 
    endfor
  endfor
  
 for t = 0,nt-1 do begin
  datat = eclip(data,[3,time(t),time(t)])
  k = -1.
  for i = 0,nbx -1 do begin 
    for j = 0,nby-1 do begin
      w=where(datat(0,*) ge (xmin+i*deltax) and datat(0,*) lt (xmin+(i+1)*deltax) and datat(1,*) ge (ymin+j*deltay) and datat(1,*) lt (ymin+(j+1)*deltay),nw)
      k = k + 1.
      m = m + 1.
      boxt(0,m) = i
      boxt(1,m) = j
      boxt(2,m) = nw
      boxt(5,m) = time(t)
      if nw eq 0 then continue 
      boxt(3,m) = mean(datat(2,w)) 
      boxt(4,m) = boxt(3,m) - ave(3,k)
    endfor
  endfor
 endfor
  
 
data=[data,indice]
      
end
 
      
      
      