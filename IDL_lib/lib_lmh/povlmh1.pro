;make 1 particle as pov file
pro povlmh, data=data, r=r,name=name
n1=n_elements(data(1,*))
pos=data(0:2,*)
r01=fltarr(1,n1)  
r01(0,0:(n1-1))=r 
c01=fltarr(3,n1) 
c01(0,0:(n1-1))=139.0/255 
c01(1,0:(n1-1))=139.0/255
mkpov,pos,name,radius=r01,color=c01 

end