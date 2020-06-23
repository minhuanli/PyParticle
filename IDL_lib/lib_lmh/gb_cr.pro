pro gb_cr, data,gb,cr,pre,sp
n=n_elements(data(0,*))

w=where((data(14,*)-data(3,*)) gt 1,nw1)
if nw1 gt 0 then gb=data(*,w)
w=where((data(14,*)-data(3,*)) le 1,nw2)
if nw2 gt 0 then cr=data(*,w) else cr=0
w=where(data(5,*) gt 0.27 and data(3,*) lt 7)
pre=data(*,w)
sp=float(nw2)/float(n)

end