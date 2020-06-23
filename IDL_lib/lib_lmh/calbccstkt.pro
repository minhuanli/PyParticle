pro calbccstkt, filename,deltar=deltar,angle,pert,numt,sizt

f0=file_search(filename)
nt=n_elements(f0(*))
angle=fltarr(100,2*nt)
pert=fltarr(9,nt)
numt=fltarr(9,nt)
sizt=fltarr(9,nt)

;select the largest cluster as the orientation reference
refboo=read_gdf(f0(nt-1))
;refboo=seqchange(refboo)
gb_cr,refboo,gb,cr
idnuclei2,cr,c01,list=s01,deltar=deltar,type=4
refc=selecluster2(cr,c01=c01,nb=0)
pos0=patch_center(cr=refc ,data=refboo,sr=5,rmax=deltar,nmax=15,dr=0.2,np=14)

;calculate the angle 
for i=0,nt-1 do begin
 boo=read_gdf(f0(i))
 ;boow=boo(*,where(boo(14,*) gt 13.0))
 ;boo=seqchange(boo,t=i)
 atemp=calbccstk(boo,deltar=deltar,per=per,pos0=pos0,num=num,siz=siz)
 n=n_elements(atemp(*,0))
 angle(0:n-1,2*i:(2*i+1))=atemp
 pert(*,i)=per
 numt(*,i)=num
 sizt(*,i)=siz
endfor
print,f0(0)
end