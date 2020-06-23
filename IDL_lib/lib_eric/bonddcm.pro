;calculate spring constant distribution from stiffness matrix. 
;ka sqrt(kxx^2+kyy^2) of all nearby bond
;kb sqrt(kxy^2+kyx^2) of all nearby bond
;;(0,x,1,y,2,total,3,averagr,4,bond
;dcmbond:0)bond id,1)kxx,2)kxy,3)kyx,4),kyy,5),dx,6)dy,7),dr
pro bonddcm,pos,dcmr,ka,kb,deltar=deltar
n1=n_elements(pos(0,*))
x0=transpose(pos(0,*))
y0=transpose(pos(1,*))
;triangulate,pos(0,*),pos(1,*),trig,connectivity=list
;n2=n_elements(list)
;dcmaa=findgen(8,n2)
;dcmaa(0,*)=transpose(list)
ka=findgen(5,n1)
kb=findgen(5,n1)
for j=0,n1-1 do begin
pos1=pos
pos1(0,*)=pos1(0,*)-pos(0,j)
pos1(1,*)=pos1(1,*)-pos(1,j)
a1=sqrt(pos1(0,*)^2+pos1(1,*)^2)
w=where(a1 gt 0 and a1 lt deltar,ncount)
if w[0] ne -1 then begin
id1=w
dcmxx=dcmr(2*j,2*id1)
dcmxy=dcmr(2*j+1,2*id1)
dcmyx=dcmr(2*j,2*id1+1)
dcmyy=dcmr(2*j+1,2*id1+1)
endif
if w[0] eq -1 then begin
dcmxx=0.0
dcmxy=0.0
dcmyx=0.0
dcmyy=0.0
ncount=0.0
endif
k01=total(sqrt(dcmxx^2+dcmyy^2))
k001=mean(sqrt(dcmxx^2+dcmyy^2))
k02=total(sqrt(dcmxy^2+dcmyx^2))
k002=mean(sqrt(dcmxy^2+dcmyx^2))
ka[2,j]=k01
ka[3,j]=k001
ka[4,j]=ncount
kb[2,j]=k02
kb[3,j]=k002
kb[4,j]=ncount
endfor
ka(0,*)=pos(0,*)
ka(1,*)=pos(1,*)
kb(0,*)=pos(0,*)
kb(1,*)=pos(1,*)

;id1=list[list[j]:list[j+1]-1]
;dx1=x0[id1]-x0[j]
;dy1=y0[id1]-y0[j]
;dcmxx=dcmr(2*j,2*id1)
;dcmxy=dcmr(2*j+1,2*id1)
;dcmyx=dcmr(2*j,2*id1+1)
;dcmyy=dcmr(2*j+1,2*id1+1)
;dcmaa(1,list[j]:list[j+1]-1)=dcmxx
;dcmaa(2,list[j]:list[j+1]-1)=dcmxy
;dcmaa(3,list[j]:list[j+1]-1)=dcmyx
;dcmaa(4,list[j]:list[j+1]-1)=dcmyy
;dcmaa(5,list[j]:list[j+1]-1)=transpose(dx1)
;dcmaa(6,list[j]:list[j+1]-1)=transpose(dy1)
;dcmaa(7,list[j]:list[j+1]-1)=transpose(sqrt(dx1^2+dy1^2))
;k01=total(sqrt(dcmxx^2+dcmyy^2))
;k02=total(sqrt(dcmxy^2+dcmyx^2))
;ka[0,j]=k01
;kb[0,j]=k02
;endfor
;dcmbond=dcmaa(*,n1:n2-1)
end

