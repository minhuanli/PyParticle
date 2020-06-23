     test0 = polycut(testr,f1=0,f2=2)
     
     w1=where(test0(5,*) gt 0.33 and test0(8,*) lt 0,nw1)

     w2=where(test0(5,*) gt 0.33 and test0(8,*) gt 0,nw2)
  
     w3=where(test0(5,*) lt 0.33,nw3)
     
     if nw1 eq 0 then type1 = [mean(test0(0,*)),mean(test0(1,*)),mean(test0(2,*))] else type1 = test0(*,w1)
     if nw2 eq 0 then type2 = [mean(test0(0,*)),mean(test0(1,*)),mean(test0(2,*))] else type2 = test0(*,w2)
     if nw3 eq 0 then type3 = [mean(test0(0,*)),mean(test0(1,*)),mean(test0(2,*))] else type3 = test0(*,w3)
     
     if nw1 eq 0 then rr1 = 0. else rr1=0.9
     if nw2 eq 0 then rr2 = 0. else rr2=0.9
     if nw3 eq 0 then rr3 = 0. else rr3=0.9
     
     newdir = 'D:\liminhuan\s-s transition project\paper figure\figure1\nuclei_slicexy2\'
     
     povlmh32,type1,type2,type3,rr1,rr2,rr3,newdir+'0809p1_t20_xy.pov'
     
     end