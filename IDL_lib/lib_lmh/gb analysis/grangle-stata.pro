;0,fig id  1,grain1 size  3,angle  4, grainboundary number  5,bcc nuc 6,hcp nuc 7, 

bond=file_search('E:\temp1\20160513\10-\0513p10 b*')
id=file_search('E:\temp1\20160513\10-\crid\0513p10 crid*')
tr33=file_search('E:\temp1\20160513\10-\0513p10 tr33*')

for j=0,24 do begin
bondt=read_gdf(bond(j+5))
idt=read_gdf(id(j))
tr33t=read_gdf(tr33(j+5))
print,bond(j+5)
print,id(j)

bondtc=edgecut(bondt)
tr33tc=edgecut(tr33t)
classt=classify(bondtc,tr33tc)
gbcont=gb_conid(bondtc,idt,deltar=3.0,grlist=glt)
w=where(glt(2,*) eq 2 and glt(1,*) gt 100,nw)
glt=glt(*,w)
result=fltarr(12,2*nw)
 for i=0,nw-1 do begin
    ;split the gb into grain 1 and grain2
 ; grain 1 part-------
    gbiid=where(gbcont(1,*) eq glt(3,i) and gbcont(2,*) eq glt(4,i) and gbcont(0,*) eq 2 and idt eq glt(3,i),ni)
    ;print,ni
    gbclassi=classt(gbiid)
        
    w1=where(gbclassi eq 1,nw1)
    w2=where(gbclassi eq 2,nw2)
    w3=where(gbclassi eq 3,nw3)
    w4=where(gbclassi eq 4,nw4)
    w5=where(gbclassi eq 5,nw5)
    w6=where(gbclassi eq 6,nw6)
    w7=where(gbclassi eq 7,nw7)
    w8=where(gbclassi eq 8,nw8)
    
    result(4,2*i)=nw1
    result(5,2*i)=nw2
    result(6,2*i)=nw3
    result(7,2*i)=nw4
    result(8,2*i)=nw5
    result(9,2*i)=nw6
    result(10,2*i)=nw7
    result(11,2*i)=nw8
    
    ww=where(idt eq glt(3,i),nww)
    result(1,2*i)=nww
    
    result(3,2*i)=ni
    result(0,2*i)=glt(0,i)
    
; grain 2 part-------
    gbiid=where(gbcont(1,*) eq glt(3,i) and gbcont(2,*) eq glt(4,i) and gbcont(0,*) eq 2 and idt eq glt(4,i),ni2)
    print,ni2+ni
    print,glt(1,i)
    gbclassi=classt(gbiid)
        
    w1=where(gbclassi eq 1,nw1)
    w2=where(gbclassi eq 2,nw2)
    w3=where(gbclassi eq 3,nw3)
    w4=where(gbclassi eq 4,nw4)
    w5=where(gbclassi eq 5,nw5)
    w6=where(gbclassi eq 6,nw6)
    w7=where(gbclassi eq 7,nw7)
    w8=where(gbclassi eq 8,nw8)
    
    result(4,2*i+1)=nw1
    result(5,2*i+1)=nw2
    result(6,2*i+1)=nw3
    result(7,2*i+1)=nw4
    result(8,2*i+1)=nw5
    result(9,2*i+1)=nw6
    result(10,2*i+1)=nw7
    result(11,2*i+1)=nw8
    
    ww=where(idt eq glt(4,i),nww2)
    result(1,2*i+1)=nww2
    
    result(3,2*i+1)=ni2
    result(0,2*i+1)=glt(0,i)
 ;--angle part   
    result(2,2*i)=gr_angle(bondtc,idt,glt(3,i),glt(4,i),rmax=3.0,database1=bondt,database2=bondt,/bcc,/layer)
    result(2,2*i+1)=result(2,2*i)
    
    
  endfor
write_text,result,'0513 p10 granglestata'+string(j+5)+'.txt'
endfor

end
