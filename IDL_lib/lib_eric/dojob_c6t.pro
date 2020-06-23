pro dojobC6t

filen=findfile('D:\HanUSdata\2triangle\xy2*')
nfile=n_elements(filen)
print,nfile,filen
range=[100,500,50,400]+[10,-10,10,-10];[20,620,20,450]+[100,-100,20,-10]

;for i=0,nfile-1 do begin
; xyt=read_gdf(filen[i])
; Hanbondall,xyt,range[0],range[1],range[2],range[3],'bond'+strmid(filen[i],30,7)
; xyt=0
;endfor

for i=0,nfile-1 do begin
 xyt=read_gdf('bond'+strmid(filen[i],30,7))
 xyt[3,*]=xyt[2,*]
 xyt[2,*]=xyt[4,*]
 xyt=xyt[0:3,*]
 ;p=where(xyt[0,*] gt range[0]+10 and xyt[0,*] lt range[1]-10 and xyt[1,*] gt range[2]+10 and xyt[1,*] lt range[3]-10)
 ;xyt=xyt[*,p]
 ;p=0
 trk=track(xyt,2)
 xyt=0
 write_gdf,trk,'trkbond'+strmid(filen[i],30,7)
 goodtraj,trk,newtrk,range+[10,-10,10,-10],minlength=100,-1
 trk=0
 C6rt,newtrk,'C6t'+strmid(filen[i],30,7),rrange=1,trange=6000
 newtrk=0
endfor
end
