pro planarwavexy_particularnorm,evc,pos,ftr,flo,qnorm=qnorm,deltar=deltar
n1=n_elements(evc)
evc01=reform(evc,2,n1/2)
qnorm12=[2*deltar,8*deltar]
qnorm=interpol(qnorm12,30)
thetaoriginal=[-1,1]*2*!pi
;qy=[-64,64]*2*!pi/192

b=complex(0,1)
ttheta=interpol(thetaoriginal,129)
f1=fltarr(30,129,n1/2)
f01=fltarr(30,129)
f2=fltarr(30,129,n1/2)
f02=fltarr(30,129)
for j=0,29 do begin
 q=2*!pi*exp(b*ttheta)/qnorm[j]
 qxx=real_part(q)
 qyy=imaginary(q)
 for i=0,128 do begin
  for k=0,n1/2-1 do begin
   f1(j,i,k)=(evc01(0,k)*qyy[i]/sqrt(qxx[i]^2+qyy[i]^2)-evc01(1,k)*qxx[i]/sqrt(qxx[i]^2+qyy[i]^2))*exp(b*(qxx[i]*pos(0,k)+qyy[i]*pos(1,k)))
   f2(j,i,k)=(evc01(0,k)*qxx[i]/sqrt(qxx[i]^2+qyy[i]^2)+evc01(1,k)*qyy[i]/sqrt(qxx[i]^2+qyy[i]^2))*exp(b*(qxx[i]*pos(0,k)+qyy[i]*pos(1,k)))
  endfor
  f01(j,i)=(abs(total(f1(j,i,*))))^2
  f02(j,i)=(abs(total(f2(j,i,*))))^2
 ;f01(i,j)=(total(f1(i,j,*)))^2
 ;f02(i,j)=(total(f2(i,j,*)))^2
 endfor
endfor
f01(*,64)=0
f02(*,64)=0
ftr=f01
flo=f02
end



function cal_particlenexttime,previousparticle,particlelibrary=particlelibrary,previousparticle_revised=previousparticle_revised
ncol=n_elements(previousparticle[*,0])
time=previousparticle[ncol-2,0]
w=where(particlelibrary[ncol-2,*] eq time+1)
particlelatter=particlelibrary[*,w] 
particlenum=n_elements(w)
latterparticle=fltarr(ncol,1)
previousparticle_revised=fltarr(ncol,1)
for i=0,particlenum-1 do begin
 w=where(previousparticle[ncol-1,*] eq particlelatter[ncol-1,i],nc)
 if nc gt 0 then begin
  latterparticle=[[latterparticle],[particlelatter[*,i]]]
  previousparticle_revised=[[previousparticle_revised],[previousparticle[*,w]]]
 endif
endfor
n=n_elements(latterparticle[0,*])
latterparticle=latterparticle[*,1:n-1]
previousparticle_revised=previousparticle_revised[*,1:n-1]
return,latterparticle
end





pro find_displacement_field_near_a_nuclei,layerparticle,deltar=deltar,particlelibrary=particlelibrary,particlethistime $
=particlethistime,particlenexttime=particlenexttime
w=where(layerparticle[3,*] ge 7)
solidlayerparticle=layerparticle[*,w]
idcluster2d,solidlayerparticle,cluster,deltar=deltar,list=list
sizeorder=sort(list[0,*])
print,transpose(list[0,sizeorder])
max1=sizeorder[n_elements(sizeorder)-1];;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
if list[0,max1] ge 50 then begin
 w1=where(cluster[*,max1] eq 1)
 extendid=compensate2d(layerparticle,w[w1],deltar=2*deltar,shellid=shellid)
 particlenexttime_solid=cal_particlenexttime(layerparticle[*,w[w1]],particlelibrary=particlelibrary,$
 previousparticle_revised=previousparticle_revised_solid)
 particlethistime_solid=previousparticle_revised_solid
 evc_solid=particlenexttime_solid[0:1,*]-particlethistime_solid[0:1,*]
 pos_solid=particlethistime_solid[0:1,*]
 planarwavexy_particularnorm,evc_solid,pos_solid,flt_solid,flo_solid,qnorm=qnorm_solid,deltar=deltar
 flt_solid=total(flt_solid,2)
 flo_solid=total(flo_solid,2)
 ratio_solid=flt_solid/flo_solid
 window,/free
 plot,qnorm_solid/deltar,ratio_solid,psym=-1
 
 particlenexttime_pre=cal_particlenexttime(layerparticle[*,shellid],particlelibrary=particlelibrary,$
 previousparticle_revised=previousparticle_revised_pre)
 particlethistime_pre=previousparticle_revised_pre
 evc_pre=particlenexttime_pre[0:1,*]-particlethistime_pre[0:1,*]
 pos_pre=particlethistime_pre[0:1,*]
 planarwavexy_particularnorm,evc_pre,pos_pre,flt_pre,flo_pre,qnorm=qnorm_pre,deltar=deltar
 flt_pre=total(flt_pre,2)
 flo_pre=total(flo_pre,2)
 ratio_pre=flt_pre/flo_pre
 oplot,qnorm_pre/deltar,ratio_pre,color=1000,psym=-1
endif
end