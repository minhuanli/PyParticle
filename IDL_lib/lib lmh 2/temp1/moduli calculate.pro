res = dblarr(4,5)
for i = 0, 4 do begin 
   res(0,i) = i
   test = eclip(gr,[2,i,i],[0,1.56,2.0])
   fitr = gaussfit(test(0,*),test(1,*),aaa,nterms=4,sigma=sig)
   res(1,i) = ( (1.38*10^(-5.) * 293.15) / aaa(2) ^2. ) / (aaa(1))
   res(2,i) = res(1,i) * ( sig(2) / aaa(2) )
   res(3,i) = aaa(1)
endfor 

end 
   