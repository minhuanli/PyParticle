function dwpi,evs,pi,a2,number=number
n001=n_elements(evs)
a3=alog(number-20)/alog(a2)
a5=round((findgen(a2)+1)^a3)
;w=where(a5 gt 10)
;a5=a5[w]
a4=[0,a5,number-5]
a=a4(uniq(a4,sort(a4)))
print,a
n1=n_elements(evs)
omg1=1./sqrt(abs(evs(0:number-1)))
omg4=smooth(omg1,5)
omg2=[0,omg4]
a1=findgen(number+1)
n2=n_elements(a)
dw01=findgen(4,n2)
dw02=findgen(1,n2)
for j=0,n2-2 do begin
a2=a[j+1]-a[j]
omg3=omg2[a[j+1]]-omg2[a[j]]
pi3=total(pi(0,a[j]:a[j+1]))
dw01(0,j)=omg2[a[j+1]]
dw01(1,j)=a2/omg3
dw01(2,j)=a2/(omg3*omg2[a[j+1]])
dw01(3,j)=pi3/omg3
dw02(0,j)=a2*omg3
endfor

dw01(1,*)=dw01(1,*)/n001
dw01(1,*)=smooth(dw01(1,*),5)
dw01(2,*)=dw01(2,*)/n001
dw01(2,*)=smooth(dw01(2,*),5)
dw01(3,*)=smooth(dw01(3,*),5)
return,dw01
end
