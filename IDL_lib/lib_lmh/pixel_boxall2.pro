; this function output n random integers between integer A and integer B,containing A and B , B should be larger than A
; those integers can be repeatable
function randombetween, A, B ,n
output = long(randomu(undefinevar,n)*(B-A+1)) + A 
return,output
end


; this pixel box contains a random shift on xy plane concerning the boundary distance, for data augumentation
; resdis is the minimal distance which the center particle can posses away the box shell, also the background boundary
function box_pixel2,cp=cp,bg=bg,xrange=xrange,yrange=yrange,zrange=zrange, resdis=resdis
  
  xc=round(cp(0,*))
  yc=round(cp(1,*))
  zc=round(cp(2,*))
  
  dx1 = n_elements(bg[*,0,0]) - 1 - xc
  dx2 = xc 
  dy1 = n_elements(bg[0,*,0]) - 1 - yc
  dy2 = yc
  
  xshiftmax = min([dx1-xrange,xrange - resdis])
  xshiftmin = max([xrange - dx2, resdis - xrange])
  yshiftmax = min([dy1-yrange,yrange - resdis])
  yshiftmin = max([yrange - dy2, resdis - yrange])
  
  xc = xc + randombetween(xshiftmin,xshiftmax,1)
  yc = yc + randombetween(yshiftmin,yshiftmax,1)
  
  temp=bg[(xc-xrange):(xc+xrange),(yc-yrange):(yc+yrange),(zc-zrange):(zc+zrange)]
  return,temp
end

;---------------------------------------------------------------------------------
function flatten3d,data=data  
  
  nz=n_elements(data(0,0,*))
  ny=n_elements(data(0,*,0))
  result=[-1]
  for i = 0,nz-1 do begin
     for j = 0,ny-1 do begin
        result=[result,data(*,j,i)]
     endfor
  endfor
  n=n_elements(result)
  return,result(1:n-1)
  
end

;--------------------------------------------------------------------------
function pixel_boxall2,cp=cp,bg=bg,xrange=xrange,yrange=yrange,zrange=zrange,resdis=resdis
  n=n_elements(cp(0,*))
  result=flatten3d(data=box_pixel2(cp=cp(*,0),bg=bg,xrange=xrange,yrange=yrange,zrange=zrange,resdis=resdis))
  
  for i = 1. ,n-1 do begin
     temp=flatten3d(data=box_pixel2(cp=cp(*,i),bg=bg,xrange=xrange,yrange=yrange,zrange=zrange,resdis=resdis))  
     result=[[result],[temp]]
  endfor
  
  return,result
end  