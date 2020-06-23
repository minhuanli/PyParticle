function hist2d,evs,number=number,bins=bins
n1=n_elements(evs)
evs01=evs(0:number-1)
omg1=1./sqrt(abs(evs01))
w=where(omg1 lt 20)
omg1=omg1(w)
h01=histogram(omg1,binsize=bins,locations=data)
n2=n_elements(data)
h02=findgen(3,n2)
h02(0,*)=data+0.9*bins
data2=data+0.9*bins
h02(1,*)=h01/(n1*data2)
h02(2,*)=h01*1.0/n1
w=where(h02(2,*) gt 0)
h03=h02(*,w)
return,h03
end

