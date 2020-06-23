function vecgr,evc,pos,bins=bins
s=size(evc)
s1=s[1]/2
evc01=reform(evc,2,s1)
vecgr01=findgen(s1,s1)
pos01=findgen(s1,s1)
for j=0,s1-1 do begin
for i=0,s1-1 do begin
vecgr01(j,i)=(evc01(0,j)-mean(evc01(0,*)))*(evc01(0,i)-mean(evc01(0,*)))+(evc01(1,j)-mean(evc(1,*)))*(evc01(1,i)-mean(evc01(1,*)))
pos01(j,i)=sqrt((pos(0,j)-pos(0,i))*(pos(0,j)-pos(0,i))+(pos(1,j)-pos(1,i))*(pos(1,j)-pos(1,i)))
endfor
endfor
vecgr02=findgen(2,s1*s1)
vecgr02(0,*)=reform(pos01,1,s1*s1)
vecgr02(1,*)=reform(vecgr01,1,s1*s1)
av=avgbin(vecgr02(0,*),vecgr02(1,*),binsize=bins)
av01=av(0:1,*)
return,av01
end