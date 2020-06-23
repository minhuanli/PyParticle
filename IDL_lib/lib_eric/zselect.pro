function zselect,pta,a1,a2,a3
w=where(pta(2,*) gt a1 and pta(2,*) lt a2)
tr=track(pta(*,w),a3,goodenough=30,dim=3)
mot=motion(tr,dim=3)
trb=rm_motion(tr,mot,smooth=1)
return,trb
end