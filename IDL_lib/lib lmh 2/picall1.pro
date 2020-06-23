pro picall1,b,tr,dr=dr,r=r
;----------------------------------the disordered--------------------------------

w=where((b(14,*)-b(3,*)) gt 1)
diso=b(*,w)
dstr=tr(*,w)

sernumber,diso,f=15
idcluster2,diso,c01,list=s01,deltar=dr

w=where(s01(0,*) le 100)                     ;---adjustable parameter 100---------------
cr1=selecluster2(diso,c01=c01,nb=w)
a=subset(diso(15,*),cr1(15,*))
diso1=diso(*,a)
dstr=dstr(*,a)
distct2,diso1,dstr,cr,pre,liq,ico
;----------------------------the bulk and the extension-----------------------------------------
w=where((b(14,*)-b(3,*)) le 1)
cr=b(*,w)
cr=[[cr],[cr1]]

;----------------------------------------------------------
;-----------divede #1--------
;------------------------------------------------------
sernumber,cr,f=15
idnuclei2,cr,c01,list=s01,deltar=dr,type=2
cr1=selecluster(data=cr,c01=c01,s01=s01,sc=20)
a=subset(cr(15,*),cr1(15,*))
ex1=cr(*,a)

;------------------------------------------
;-----------group back #1-------------
;--------------------------------------------
sernumber,ex1,f=15
idcluster2,ex1,c01,list=s01,deltar=dr

w=where(s01(0,*) le 7)   ;---------adjustable parameter 7--------
exx1=selecluster2(ex1,c01=c01,nb=w)
a=subset(ex1(15,*),exx1(15,*))
ex11=ex1(*,a)
cr=[[cr1],[exx1]]

;---------------------------------------
;-------group back #2--------------
;------------------------------------
sernumber,ex11,f=15
idnuclei2,ex11,c01,list=s01,deltar=dr,type=1
exx1=selecluster(data=ex11,c01=c01,s01=s01,sc=20)   ;------------adjustable parameter 20-----------------
a=subset(ex11(15,*),exx1(15,*))
ex111=ex11(*,a)
cr1=[[cr],[exx1]]
pre1=[[pre],[ex111]]
 w=where(pre1(14,*) gt 13)
bcc=pre1(*,w)
w=where(pre1(14,*) lt 13)
fcp=pre1(*,w)

end
