
;------------------------------------------------------
pro cal_density,data,rad=rad,dens=dens,dc=dc
datac=edgecut(data,dc=dc)
n=n_elements(datac(0,*))
v=(max(datac(0,*))-min(datac(0,*)))*(max(datac(1,*))-min(datac(1,*)))*(max(datac(2,*))-min(datac(2,*)))
dens=4.*n*!pi*rad*rad*rad/(3.*v)
print,dens

end