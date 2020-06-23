pro nwfft2,trb,nw01,nw02,nw03,jtt01,jtt02,jtt03
ta=max(trb(5,*))-min(trb(5,*))+1
pos=position(trb)
naa=transpose(pos(2,*))
na=n_elements(naa)
p6=psi6(pos(0:1,*),polar=1)
p61=mean(p6(0,*))
w1=where(p6(0,*) lt p61,nn1)
w2=where(p6(0,*) ge p61,nn2)
nwa=findgen(na,ta)
jtta=findgen(na,ta)
for j=0,na-1 do begin
w12=where(trb(6,*) eq naa[j])
trc=trb(*,w12)
nwfft,trc,nw1,jtt1
nwa(j,*)=real_part(nw1)
jtta(j,*)=jtt1(1,*)
endfor
jtt01=rebin(jtt1(w1,*),1,ta)
jtt02=rebin(jtt1(w2,*),1,ta)
jtt03=rebin(jtt1,1,ta)
nw01=real_part(fft(jtt01,-1))
nw02=real_part(fft(jtt02,-1))
nw03=real_part(fft(jtt03,-1))
end
