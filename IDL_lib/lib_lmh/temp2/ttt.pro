
lind0 = read_gdf('D:\liminhuan\s-s transition project\1003 data\f&b after\45_75_continue_res\pos4\lind3d26.gdf')
w=where(lind0(2,*) gt 15)

plot_hist,lind0(1,w),bin=0.002,res3d
;res3d = smooth(res3d,[1,3])
;plot,res3d(0,*),res3d(1,*),psym=-1
;plot_hist,lind0(1,*),bin=0.002,res3d
res3d = smooth(res3d,[1,4])
plot,res3d(0,*),res3d(1,*),psym=-1
plot_hist,lind0(3,w),bin=0.002,resx
plot_hist,lind0(4,w),bin=0.002,resy
plot_hist,lind0(5,w),bin=0.002,resz
resx = smooth(resx,[1,4])
plot,resx(0,*),resx(1,*),psym=-1
resy = smooth(resy,[1,4])
plot,resy(0,*),resy(1,*),psym=-1
resz = smooth(resz,[1,4])
plot,resz(0,*),resz(1,*),psym=-1

bt0 = eclip(bt,[17,150,200])

b0c = edgecut(bt0,dc=2.5)
plot_hist,b0c(5,*),bin=0.002,q6
plot_hist,b0c(8,*),bin=0.0005,w6
q6 = smooth(q6,[1,3])
plot,q6(0,*),q6(1,*),psym=-1
w6 = smooth(w6,[1,3])
plot,w6(0,*),w6(1,*),psym=-1
write_text,res3d,'D:\liminhuan\s-s transition project\1003 data\lindemann res\after\pos4\p4res3d475.txt'
write_text,resx,'D:\liminhuan\s-s transition project\1003 data\lindemann res\after\pos4\p4resx475.txt'
write_text,resy,'D:\liminhuan\s-s transition project\1003 data\lindemann res\after\pos4\p4resy475.txt'
write_text,resz,'D:\liminhuan\s-s transition project\1003 data\lindemann res\after\pos4\p4resz475.txt'
write_text,q6,'D:\liminhuan\s-s transition project\1003 data\lindemann res\after\pos4\p4q6475.txt'
write_text,w6,'D:\liminhuan\s-s transition project\1003 data\lindemann res\after\pos4\p4w6475.txt'



end