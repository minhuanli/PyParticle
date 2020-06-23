for s = 0,20 do begin
   slice = eclip(b8,[1,60+s*1.5,64+s*1.5])
   cg = coarse_grain([slice(0:2,*),slice(5,*)],rmax=2.5,nmax=14)
   povlmh_color,[slice(0:2,*),slice(5,*)], r = 0.92, minc=0.25, maxc=0.55 , name = 'D:\liminhuan\s-s transition project\0801 data\Q6 trial\xzslice'+string(s)+'.pov',verse=1.
   povlmh_color,cg, r = 0.92, minc=-0.009, maxc=0.002 , name = 'D:\liminhuan\s-s transition project\0801 data\Q6 trial\xzcg'+string(s)+'.pov',verse=1.
endfor

end
