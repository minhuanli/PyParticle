function boo3d,tr,ql,deltar=deltar
pos=tr(0:2,*)
n1=n_elements(pos(0,*))
qq1=findgen(3,n1)
for j=0,n1-1 do begin
print,j
pos1=pos
pos1(0,*)=pos1(0,*)-pos(0,j)
pos1(1,*)=pos1(1,*)-pos(1,j)
pos1(2,*)=pos1(2,*)-pos(2,j)
a1=sqrt(pos1(0,*)^2+pos1(1,*)^2+pos1(2,*)^2)
w=where(a1 gt 0 and a1 lt deltar)
b1=n_elements(w)
if w[0] ne -1 then begin
c1=findgen(3,b1)
c1(0,*)=pos1(0,w)
c1(1,*)=pos1(1,w)
c1(2,*)=pos1(2,w)
sph1=cv_coord(from_rect=c1,/to_sphere)
q66=mean(spher_harm(sph1(1,*),sph1(0,*),6,-6))
q65=mean(spher_harm(sph1(1,*),sph1(0,*),6,-5))
q64=mean(spher_harm(sph1(1,*),sph1(0,*),6,-4))
q63=mean(spher_harm(sph1(1,*),sph1(0,*),6,-3))
q62=mean(spher_harm(sph1(1,*),sph1(0,*),6,-2))
q61=mean(spher_harm(sph1(1,*),sph1(0,*),6,-1))
q67=mean(spher_harm(sph1(1,*),sph1(0,*),6,6))
q68=mean(spher_harm(sph1(1,*),sph1(0,*),6,5))
q69=mean(spher_harm(sph1(1,*),sph1(0,*),6,4))
q610=mean(spher_harm(sph1(1,*),sph1(0,*),6,3))
q611=mean(spher_harm(sph1(1,*),sph1(0,*),6,2))
q612=mean(spher_harm(sph1(1,*),sph1(0,*),6,1))
q613=mean(spher_harm(sph1(1,*),sph1(0,*),6,0))
q41=mean(spher_harm(sph1(1,*),sph1(0,*),4,-4))
q42=mean(spher_harm(sph1(1,*),sph1(0,*),4,-3))
q43=mean(spher_harm(sph1(1,*),sph1(0,*),4,-2))
q44=mean(spher_harm(sph1(1,*),sph1(0,*),4,-1))
q45=mean(spher_harm(sph1(1,*),sph1(0,*),4,0))
q46=mean(spher_harm(sph1(1,*),sph1(0,*),4,4))
q47=mean(spher_harm(sph1(1,*),sph1(0,*),4,3))
q48=mean(spher_harm(sph1(1,*),sph1(0,*),4,2))
q49=mean(spher_harm(sph1(1,*),sph1(0,*),4,1))
q6a=(abs(q61))^2+(abs(q62))^2+(abs(q63))^2+(abs(q64))^2+(abs(q65))^2+(abs(q66))^2+(abs(q67))^2+(abs(q68))^2+(abs(q69))^2+(abs(q610))^2+(abs(q611))^2+(abs(q612))^2+(abs(q613))^2
q4a=(abs(q41))^2+(abs(q42))^2+(abs(q43))^2+(abs(q44))^2+(abs(q45))^2+(abs(q46))^2+(abs(q47))^2+(abs(q48))^2+(abs(q49))^2
q6b=(4.0*!pi/13)*q6a
q4b=(4.0*!pi/9)*q4a
qq1(0,j)=sqrt(q4b)
qq1(1,j)=sqrt(q6b)
qq1(2,j)=b1
endif
if w[0] eq -1 then begin
qq1(0,j)=0
qq1(1,j)=0
qq1(2,j)=0
endif
endfor
ql=qq1
return,ql
end




