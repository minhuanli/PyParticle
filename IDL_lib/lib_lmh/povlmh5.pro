pro povlmh5,d1,d2,d3,d4,d5,r1,r2,r3,r4,r5,name
 
 n1=n_elements(d1(0,*))
 n2=n_elements(d2(0,*))
 n3=n_elements(d3(0,*))
 n4=n_elements(d4(0,*))
 n5=n_elements(d5(0,*))
 ;n6=n_elements(d6(0,*))


 pos=[[d1(0:2,*)],[d2(0:2,*)],[d3(0:2,*)],[d4(0:2,*)],[d5(0:2,*)]]
;------r------------------
 rr1=fltarr(1,n1)
 rr1(0,*)=r1
 rr2=fltarr(1,n2)
 rr2(0,*)=r2
 rr3=fltarr(1,n3)
 rr3(0,*)=r3
 rr4=fltarr(1,n4)
 rr4(0,*)=r4
 rr5=fltarr(1,n5)
 rr5(0,*)=r5
 ;rr6=fltarr(1,n6)
 ;rr6(0,*)=r6
 r=[[rr1],[rr2],[rr3],[rr4],[rr5]]
;---------c------------------
 ;---brown---
 cc1=fltarr(3,n1)
 cc1(0,*)=225.0/255.0
 cc1(1,*)=128.0/255.0
 cc1(2,*)=64.0/255.0
 ;---------dark green-------
 cc2=fltarr(3,n2)
 cc2(0,*)=128.0/255.0
 cc2(1,*)=128.0/255.0
 cc2(2,*)=128.0/255.0
 
 ;----purple----
 cc3=fltarr(3,n3)
 cc3(0,*)=63.0/255.0
 cc3(1,*)=72.0/255.0
 cc3(2,*)=204.0/255.0
 ;------blue------
 cc4=fltarr(3,n4)
 cc4(1,*)=108.0/255.0
 
 ;------orange------
 cc5=fltarr(3,n5)
 cc5(0,*)=108.0/255.0
 cc5(1,*)=0.0/255.0
 ;---------dark red------

 
 
 c=[[cc1],[cc2],[cc3],[cc4],[cc5]]
 
 
mkpov,pos,name,radius=r,color=c 
end