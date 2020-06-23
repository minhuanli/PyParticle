function s2_prj,prj=prj,num=num,rou0=rou0,bin=bin
 if not(keyword_set(bin)) then bin=0.02
 plot_hist,prj(3,*),bin=0.02,grt
 grt(1,*)=grt(1,*)/(rou0*float(num))
 grt(1,*)=grt(1,*)/(4*!pi*grt(0,*)*grt(0,*)*bin)
 w=where(grt(1,*) eq 0)
 grt(1,w)=0.00001  ; compensate the 0. point, or the alog process will come out error!
 s2t=s2_gr(gr=grt,rou0=rou0)
 return,s2t
end