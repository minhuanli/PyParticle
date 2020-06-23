function boo3davgtb,data
t1=min(data(7,*))
t2=max(data(7,*))
ta=t1+1+indgen(t2-t1)
w=where(data(7,*) eq t1)
g01=ericgr3d(data(*,w),rmin=1,rmax=10,deltar=0.1)
wa=where(g01(0,*) gt 3.5 and g01(0,*) lt 5.5)
g001=g01(*,wa)
wb=where(g001(1,*) eq min(g001(1,*)))
r1=min(g001(0,wb))
b01=boo3davgta(data(*,w),deltar=r1,bondmax=14.0)
for j=0,t2-t1-1 do begin
w=where(data(7,*) eq ta[j])
g01=ericgr3d(data(*,w),rmin=1,rmax=10,deltar=0.1)
wa=where(g01(0,*) gt 3.5 and g01(0,*) lt 5.5)
g001=g01(*,wa)
wb=where(g001(1,*) eq min(g001(1,*)))
r1=min(g001(0,wb))
b0a=boo3davgta(data(*,w),deltar=r1,bondmax=14.0)
b01=[[b01],[b0a]]
endfor
return,b01
end

