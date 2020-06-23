function vecgrlo,evc,pos,deltar=deltar,bins=bins
s=size(evc)
s1=s[1]/2
evc01=reform(evc,2,s1)
vecgr01=findgen(s1,s1)
pos01=findgen(s1,s1)
pos001=findgen(s1,s1)
for j=0,s1-1 do begin
for i=0,s1-1 do begin
vecgr01(j,i)=(evc01(0,j)*(pos(1,j)-pos(1,i))+evc01(1,j)*(pos(0,j)-pos(0,i)))*(evc01(0,i)*(pos(1,j)-pos(1,i))+evc01(1,i)*(pos(0,j)-pos(0,i)))/((pos(0,j)-pos(0,i))^2+(pos(1,j)-pos(1,i))^2)
pos01(j,i)=pos(0,j)-pos(0,i)
pos001(j,i)=pos(1,j)-pos(1,i)
endfor
endfor
av01=findgen(3,s1^2)
av01(0,*)=reform(pos01,1,s1^2)
av01(1,*)=reform(pos001,1,s1^2)
av01(2,*)=reform(vecgr01,1,s1^2)
b0=av01(0,*)
w=uniq(b0,sort(b0))
s2=n_elements(w)
av02=findgen(3,s2)
av02(0,*)=av01(0,w)
av02(1,*)=av01(1,w)
av02(2,*)=av01(2,w)
grid=griddata(av02(0,*),av02(1,*),av02(2,*),delta=deltar,dimension=bins,start=[-500,-500])
return,grid
end
