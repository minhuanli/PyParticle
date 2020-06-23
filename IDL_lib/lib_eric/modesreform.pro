function modesreform,modea,modeb,pn=pn
n1=n_elements(modea)
modec=findgen(2,n1)
modec(0,*)=transpose(modea)
modec(1,*)=transpose(modeb)
n2=1.*n1/(pn+1)
evc1=reform(modec,2*(pn+1),n2)
evc=evc1(2:2*(pn+1)-1,*)
return,evc
end
