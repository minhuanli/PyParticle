function modratio,ftr,ftrlog
w1=where(ftr(0,*) gt 0.01 and ftr(0,*) le 0.1)
ftr1=interpol(ftr(0,w1),20)
ftr2=interpol(ftr(1,w1),20)
w2=where(ftr(0,*) gt 0.1 and ftr(0,*) le 1)
ftr3=interpol(ftr(0,w2),20)
ftr4=interpol(ftr(1,w2),20)
w3=where(ftr(0,*) gt 1 and ftr(0,*) le 10)
ftr5=interpol(ftr(0,w3),20)
ftr6=interpol(ftr(1,w3),20)
w4=where(ftr(0,*) gt 10 and ftr(0,*) le 20)
ftr7=interpol(ftr(0,w4),20)
ftr8=interpol(ftr(1,w4),20)
n1=n_elements(ftr1)
n2=n_elements(ftr3)
n3=n_elements(ftr5)
n4=n_elements(ftr7)
ftra=findgen(2,n1+n2+n3+n4)
ftra(0,0:n1-1)=ftr1
ftra(1,0:n1-1)=ftr2
ftra(0,n1:n1+n2-1)=ftr3
ftra(1,n1:n1+n2-1)=ftr4
ftra(0,n1+n2:n1+n2+n3-1)=ftr5
ftra(1,n1+n2:n1+n2+n3-1)=ftr6
ftra(0,n1+n2+n3:n1+n2+n3+n4-1)=ftr7
ftra(1,n1+n2+n3:n1+n2+n3+n4-1)=ftr8
ftrlog=ftra
return,ftrlog
end


