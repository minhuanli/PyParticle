function vecgrall,evcs,pos,deltar=deltar,n_omg=n_omg
vgrall=transpose(findgen(n_omg))
for j=0,n_omg-1 do begin
vgrall01=vecgr(evcs(*,j),pos,bins=deltar/5.0)
vgrall(0,j)=vgrall01(1,0)+vgrall01(1,1)+vgrall01(1,2)+vgrall01(1,3)+vgrall01(1,4)+vgrall01(1,5)
endfor
return,vgrall
end