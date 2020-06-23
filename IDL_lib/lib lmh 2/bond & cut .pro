
data=boo3davgtnew(a1,deltar=2.9,bondmax=14.0,dc=0.75)
w=where(data(0,*) lt 113 and data(0,*) gt 5 and data(1,*) lt 113 and data(1,*) gt 5 and data(2,*) lt 50 and data(2,*) gt 5)
b0=data(*,w)

end