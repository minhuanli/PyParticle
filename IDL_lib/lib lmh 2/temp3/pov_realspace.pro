dir1 = 'D:\liminhuan\s-s transition project\0801 data\boo\mf1\'
dir2 = 'D:\liminhuan\s-s transition project\0801 data\boo\mf2\'
file = ['boom1-cell0801-mf1-p','0801mf2bondm1_p']

secrange = [[5,70],[40,105]]
for i = 1,5 do begin

newdir = 'D:\liminhuan\s-s transition project\0801 data\real_space\pov'+string(i)+'\'

file_mkdir,newdir
data1 = file_search(dir1+file(0)+string(i)+'*')
data2 = file_search(dir2+file(1)+string(i)+'*')
filein = [data1,data2]
nb = n_elements(filein)

  for t = 0 ,nb-1 do begin
     bc = edgecut(read_gdf(filein(t)))  
     
     for s = 0, 7  do begin 
     
     xser = s mod 2
     yser = (s / 2) mod 2
     zser = s / 4 
     
     print,'now section: '+strcompress(string(s),/remove_all)+' x: ' + strcompress(string(secrange(0,xser))+' to '+ string(secrange(1,xser)),/remove_all) + $
     ' y: ' + strcompress(string(secrange(0,yser))+' to '+ string(secrange(1,yser)),/remove_all) + $
     ' z: ' + strcompress(string(secrange(0,zser))+' to '+ string(secrange(1,zser)),/remove_all)
     
     test0 = eclip(bc,[0,secrange(0,xser),secrange(1,xser)],[1,secrange(0,yser),secrange(1,yser)],[2,secrange(0,zser),secrange(1,zser)])
;     test0 = eclip(bc,[0,15,35],[1,45,65],[2,90,110])
     
     w1=where(test0(5,*) gt 0.30 and test0(8,*) lt 0,nw1)

     w2=where(test0(5,*) gt 0.30 and test0(8,*) gt 0,nw2)
  
     w3=where(test0(5,*) lt 0.30,nw3)
     
     if nw1 eq 0 then type1 = [mean(test0(0,*)),mean(test0(1,*)),mean(test0(2,*))] else type1 = test0(*,w1)
     if nw2 eq 0 then type2 = [mean(test0(0,*)),mean(test0(1,*)),mean(test0(2,*))] else type2 = test0(*,w2)
     if nw3 eq 0 then type3 = [mean(test0(0,*)),mean(test0(1,*)),mean(test0(2,*))] else type3 = test0(*,w3)
     
     if nw1 eq 0 then rr1 = 0. else rr1=0.05
     if nw2 eq 0 then rr2 = 0. else rr2=0.7
     if nw3 eq 0 then rr3 = 0. else rr3=0.5
     
     type1 = [type1(0,*),type1(2,*),type1(1,*)]
     type2 = [type2(0,*),type2(2,*),type2(1,*)]
     type3 = [type3(0,*),type3(2,*),type3(1,*)]
     
     povlmh32,type1,type2,type3,rr1,rr2,rr3,newdir+'sec'+string(s)+'time'+string(t)+'.pov'
    endfor
  
  endfor
  
endfor

end  
     