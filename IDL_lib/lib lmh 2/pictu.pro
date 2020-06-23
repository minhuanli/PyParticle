boo=file_search('E:\temp1\20160513\5\0513p5 b*')
tr33=file_search('E:\temp1\20160513\5\0513p5 tr33*')
n=n_elements(boo)
for i=0,n-1 do begin

tempb=read_gdf(boo(i))
temptr=read_gdf(tr33(i))
angle=calbccstk(tempb,deltar=3.0,ic=ic,is=is,w1=w1,w8=w8,w3=w3,w4=w4,nw1=nw1,nw8=nw8,nw3=nw3,nw4=nw4)
gb_cr,tempb,gb,cr

window,0,xsize=800,ysize=800
w=where(tempb(3,*) lt 7)
plot,tempb(0,w),tempb(1,w),psym=3

if nw1 gt 0 then begin 
c1=selecluster2(cr,c01=ic,nb=w1)
oplot,c1(0,*),c1(1,*),psym=3,color=1000
endif


if nw3 gt 0 then begin 
c3=selecluster2(cr,c01=ic,nb=w3)
oplot,c3(0,*),c3(1,*),psym=3,color=50000
endif

if nw4 gt 0 then begin 
c2=selecluster2(cr,c01=ic,nb=w4)
oplot,c2(0,*),c2(1,*),psym=3,color=50000
endif

if nw8 gt 0 then begin 
c4=selecluster2(cr,c01=ic,nb=w8)
oplot,c4(0,*),c4(1,*),psym=3,color=100000
endif




topo=picktopo(tempb,temptr)
oplot,topo(0,*),topo(1,*),psym=6,color=1000

saveimage,0,[800,800],'0513p5'+string(i)+'.png',type=4
endfor

end
