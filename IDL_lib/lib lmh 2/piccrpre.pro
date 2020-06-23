;boo=file_search('E:\temp1\20160513\10\0513p10 b*')
for i=0,19 do begin
;tempb=read_gdf(boo(i))
w=where(f1(17,*) eq i and f1(3,*) gt 7)

window,0,xsize=800,ysize=800
plot,f1(0,w),f1(2,w),psym=3,/iso

;oplot,pre(0,*),pre(1,*),psym=3,color=1000

saveimage,0,[800,800],'tsx pathway'+string(i)+'.png',type=4

endfor

print,i
end