pro crystaldata,fname,fname1,deltar=deltar
f1=file_search(fname)
f2=fname1
a1=read_gdf(f1[0])
a2=eclip(a1,[0,10,100],[1,10,100],[2,5,95])
f01=fccboo3d(a2)
fname01='f01_'+f2
write_text,f01,fname01
clustercount,a2,deltar=deltar,solid=s1,bcc=b1,fcchcp=h1,mrco=m1
fname02='solid_'+f2
write_text,s1,fname02
fname03='bcc_'+f2
write_text,b1,fname03
fname04='fcchcp_'+f2
write_text,h1,fname04
fname05='mrco_'+f2
write_text,m1,fname05
a01=avgbin(s1(2,*),s1(0,*),binsize=1)
a001=avgbin(s1(2,*),s1(1,*),binsize=1)
a02=avgbin(b1(2,*),b1(0,*),binsize=1)
a002=avgbin(b1(2,*),b1(1,*),binsize=1)
a03=avgbin(h1(2,*),h1(0,*),binsize=1)
a003=avgbin(h1(2,*),h1(1,*),binsize=1)
a04=avgbin(m1(2,*),m1(0,*),binsize=1)
a004=avgbin(m1(2,*),m1(1,*),binsize=1)
fname06='solidnumber_'+f2
write_text,a01,fname06
fname07='solidsize_'+f2
write_text,a001,fname07
fname08='bccnumber_'+f2
write_text,a02,fname08
fname09='bccsize_'+f2
write_text,a002,fname09
fname10='fcchcpnumber_'+f2
write_text,a03,fname10
fname11='fcchcpsize_'+f2
write_text,a003,fname11
fname12='mrconumber_'+f2
write_text,a04,fname12
fname13='mrcosize_'+f2
write_text,a004,fname13
w=where(a2(3,*) ge 7.0)
g1=voronoigr3d(a2(*,w),rmin=1,rmax=20,deltar=0.1)
w1=where(a2(3,*) ge 7.0 and a2(14,*) gt 13)
g2=voronoigr3d(a2(*,w1),rmin=1,rmax=20,deltar=0.1)
w2=where(a2(3,*) ge 7.0 and a2(14,*) lt 13)
g3=voronoigr3d(a2(*,w2),rmin=1,rmax=20,deltar=0.1)
fname14='solidgr_'+f2
write_text,g1,fname14
fname15='bccgr_'+f2
write_text,g2,fname15
fname16='fcchcpgr_'+f2
write_text,g3,fname16
w=where(a2(3,*) lt 7.0 and a2(5,*) gt 0.27)
g1=voronoigr3d(a2(*,w),rmin=1,rmax=20,deltar=0.1)
w1=where(a2(3,*) lt 7.0 and a2(5,*) gt 0.27 and a2(14,*) gt 13)
g2=voronoigr3d(a2(*,w1),rmin=1,rmax=20,deltar=0.1)
w2=where(a2(3,*) lt 7.0 and a2(5,*) gt 0.27 and a2(14,*) lt 13)
g3=voronoigr3d(a2(*,w2),rmin=1,rmax=20,deltar=0.1)
fname14='mrcogr_'+f2
write_text,g1,fname14
fname15='mrcobccgr_'+f2
write_text,g2,fname15
fname16='mrcofcchcpgr_'+f2
write_text,g3,fname16
end







