;make pov file for two particles
pro povlmh2, data1=data1, data2=data2,name=name
n1=n_elements(data1(1,*))
n2=n_elements(data2(1,*))
pos=[[data1(0:2,*)],[data2(0:2,*)]]
r01=fltarr(1,(n1+n2))  
r01(0,0:(n1-1))=0.8  
r01(0,n1:(n1+n2-1))=0.8  
c01=fltarr(3,(n1+n2)) 
c01(2,0:(n1-1))=139.0/255  
c01(0,n1:(n1+n2-1))=255.0/255 
;c01(1,n1:(n1+n2-1))=139.0/255
mkpov,pos,name,radius=r01,color=c01 

end