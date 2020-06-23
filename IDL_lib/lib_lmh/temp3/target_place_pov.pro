dir1 = 'D:\liminhuan\s-s transition project\0809 data\boo\0809-boo-mf1\'
dir2 = 'D:\liminhuan\s-s transition project\0809 data\boo\0809-boo-mf2\'
file = ['0809-boo-mf1-p','0809-boo-mf2-p']

for i = 1,1 do begin

newdir = 'D:\liminhuan\s-s transition project\paper figure\figure1\pov\'

data1 = file_search(dir1+file(0)+string(i)+'*')
data2 = file_search(dir2+file(1)+string(i)+'*')
filein = [data1,data2]

  for t = 0 ,0 do begin
     bc = edgecut(read_gdf(filein(t)))  
     
     
     test0 = eclip(bc,[0,20,70],[1,20,70],[2,60,110])
     
     w1=where(test0(5,*) gt 0.30 and test0(8,*) lt 0,nw1)
     
     w2=where(test0(5,*) gt 0.30 and test0(8,*) gt 0,nw2)
     nw2 = 0
     w3=where(test0(5,*) lt 0.28,nw3)
     nw3 = 0
     if nw1 eq 0 then type1 = [mean(test0(0,*)),mean(test0(1,*)),mean(test0(2,*))] else type1 = test0(*,w1)
     if nw2 eq 0 then type2 = [mean(test0(0,*)),mean(test0(1,*)),mean(test0(2,*))] else type2 = test0(*,w2)
     if nw3 eq 0 then type3 = [mean(test0(0,*)),mean(test0(1,*)),mean(test0(2,*))] else type3 = test0(*,w3)
     
     if nw1 eq 0 then rr1 = 0. else rr1=0.05
     if nw2 eq 0 then rr2 = 0. else rr2=1.0
     if nw3 eq 0 then rr3 = 0. else rr3=0.8
     
     
     povlmh32,type1,type2,type3,rr1,rr2,rr3,newdir+'sec_4'+'before'+string(t)+'.pov'
  
  endfor
  
endfor

end  
