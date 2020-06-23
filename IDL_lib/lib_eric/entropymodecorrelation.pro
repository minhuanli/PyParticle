function entropymodecorrelation,dcm,entropy
n1=n_elements(entropy(0,*))
s01=size(dcm)
d01=(abs(dcm))^2
d02=rebin(d01,s01[1]/2.0,s01[2])
e01=transpose(entropy(2,*)/mean(entropy(2,*)))
sa=sort(e01)
for j=0,s01[2]-1 do begin
da=d02(*,j)
d03=da[sa]
d02(*,j)=d03
endfor
return,d02
end
