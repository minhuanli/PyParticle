; liquid blue ; hcp royal blue ; bcc dark orange ; fcc dark green
pro povlmh42,d1,d2,d3,d4,r1,r2,r3,r4,name
 
 n1=n_elements(d1(0,*))
 n2=n_elements(d2(0,*))
 n3=n_elements(d3(0,*))
 n4=n_elements(d4(0,*))


 pos=[[d1(0:2,*)],[d2(0:2,*)],[d3(0:2,*)],[d4(0:2,*)]]
;------r------------------
 rr1=fltarr(1,n1)
 rr1(0,*)=r1
 rr2=fltarr(1,n2)
 rr2(0,*)=r2
 rr3=fltarr(1,n3)
 rr3(0,*)=r3
 rr4=fltarr(1,n4)
 rr4(0,*)=r4
 r=[[rr1],[rr2],[rr3],[rr4]]
;---------c------------------
 ;---white---
 cc1=fltarr(3,n1)
 cc1(0,*)=255./255.0
 cc1(1,*)=255./255.0
 cc1(2,*)=255./255.0
 
 ;---------royal blue-------
 cc2=fltarr(3,n2)
 cc2(0,*)=39./255.
 cc2(1,*)=64.0/255.0
 cc2(2,*)=139.0/255.0
 
 ;----dark orange----
 cc3=fltarr(3,n3)
 cc3(0,*)=255.0/255.0
 cc3(1,*)=140.0/255.0
 ;cc2(2,*)=255.0/255.0
; ;------green------
; cc3=fltarr(3,n3)
; cc3(0,*)=0.0/255.0
; cc3(1,*)=139.0/255.0
; cc3(2,*)=0.0/255.0
; 
;; ------dark green------
 cc4=fltarr(3,n4)
 ;cc4(0,*)=139.0/255.0
 cc4(1,*)=128.0/255.0
; cc4(2,*)=139.0/255.0
 ;---------brown------
; cc3=fltarr(3,n5)
; cc3(0,*)=168.0/255.0
; cc3(1,*)=84.0/255.0
; cc3(2,*)=0.0/255.0
 ;---------orange------
; cc4=fltarr(3,n6)
; cc4(0,*)=255.0/255.0
; cc4(1,*)=128.0/255.0
; cc4(2,*)=0.0/255.0
; 
 
 c=[[cc1],[cc2],[cc3],[cc4]]
 
 
mkpov,pos,name,radius=r,color=c,/margin
end