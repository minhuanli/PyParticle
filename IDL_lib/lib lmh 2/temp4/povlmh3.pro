; liquid blue ; hcp royal blue ; bcc dark orange ; fcc dark green
pro povlmh3,d1,d2,d3,r1,r2,r3,name
 
 n1=n_elements(d1(0,*))
 n2=n_elements(d2(0,*))
 n3=n_elements(d3(0,*))


 pos=[[d1(0:2,*)],[d2(0:2,*)],[d3(0:2,*)]]
;------r------------------
 rr1=fltarr(1,n1)
 rr1(0,*)=r1
 rr2=fltarr(1,n2)
 rr2(0,*)=r2
 rr3=fltarr(1,n3)
 rr3(0,*)=r3
 r=[[rr1],[rr2],[rr3]]
;---------c------------------
 ;---white---
 cc1=fltarr(3,n1)
 cc1(0,*)=255./255.0
 cc1(1,*)=255./255.0
 cc1(2,*)=255./255.0
 
 ;-----brown------ 
 cc2=fltarr(3,n2)
 cc2(0,*)=168.0/255.0
 cc2(1,*)=84.0/255.0
 cc2(2,*)=0.0/255.0
 
 ;---------orange------
 cc3=fltarr(3,n3)
 cc3(0,*)=255.0/255.0
 cc3(1,*)=128.0/255.0
 cc3(2,*)=0.0/255.0
; 
 
 c=[[cc1],[cc2],[cc3]]
 
 
mkpov,pos,name,radius=r,color=c,/margin,camera=[30.0,30.0,98],light=[30.0,30.0,100]

end