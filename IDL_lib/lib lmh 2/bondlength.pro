pro bondlength,cpdata=cpdata,data=data,rmax=rmax,nmax=nmax,mean,dev

n=n_elements(cpdata(0,*))
nb1=selectnearest(data,cp=cpdata(*,0),rmax=rmax,nmax=nmax)
n0=n_elements(nb1(0,*))
all=sqrt(nb1(0,1:(n0-1)))
all=transpose(all)

for i=1,n-1 do begin
nb=selectnearest(data,cp=cpdata(*,i),rmax=rmax,nmax=nmax)
n1=n_elements(nb(0,*))
temp=sqrt(nb(0,1:(n1-1)))
temp=transpose(temp)
all=[all,temp]
endfor

mean=mean(all)
dev=stddev(all)

end