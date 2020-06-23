function coarse_grain,odata,f=f,rmax=rmax,nmax=nmax
data = odata
nn = n_elements(data(0,*))
for i = 0.,nn-1 do begin 
   nb = selectnearest(odata, cp=odata(0:2,i),rmax=rmax, nmax=nmax)
   data(f,i) = mean(nb(f+1,*))
endfor 

return,data

end


