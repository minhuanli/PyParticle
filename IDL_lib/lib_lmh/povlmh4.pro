; liquid blue ; hcp purple ; bcc dark red ; fcc dark green
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
 ;---red---
 cc1=fltarr(3,n1)
 cc1(0,*)=248./255.0
 cc1(1,*)=90./255.0 ; 248,90,41
 cc1(2,*)=41./255.0
 
 ;---------dark green-------
; cc4=fltarr(3,n2)
; cc4(1,*)=128.0/255.0
; cc4(2,*)=128.0/255.0
; 
 ;----red----
 cc2=fltarr(3,n2)
 cc2(0,*)=126.0/255.0
 cc2(1,*)=197.0/255.0   ;126,197,83
 cc2(2,*)=83.0/255.0
; ;------green------
; cc3=fltarr(3,n3)
; cc3(0,*)=0.0/255.0
; cc3(1,*)=139.0/255.0
; cc3(2,*)=0.0/255.0
; 
;; ------purple------
 cc3=fltarr(3,n3)
 cc3(0,*)=38.0/255.0
 cc3(1,*)=86.0/255.0   ;126,197,83
 cc3(2,*)=163.0/255.0
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
 
 c=[[cc1],[cc2],[cc3]]
 
 
mkpov,pos,name,radius=r,color=c,/margin,/nobox
end