function realdynamic1,trb,evc,t1=t1,t2=t2
n1=max(trb(6,*))+1
rd004=findgen(2,n1)
a01=findgen(n1)+1
for j=1,n1 do begin
a02=a01[j-1]+1
rd001=realdynamic(trb,evc,t1=t1,t2=t2,number=a02)
rd002=rd001(2,*)*rd001(4,*)+rd001(3,*)*rd001(5,*)
rd003=rd001(2,*)*rd001(5,*)+rd001(3,*)*rd001(4,*)
rd004(0,j-1)=total(rd002)
rd004(1,j-1)=total(rd003)
endfor
rd004(0,*)=rd004(0,*)/max(rd004(0,*))
rd004(1,*)=rd004(1,*)/max(rd004(1,*))
return,rd004
end