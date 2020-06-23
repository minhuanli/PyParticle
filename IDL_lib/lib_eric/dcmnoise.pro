function dcmnoise, dcm01,pos,bondlength=bondlength
dcm02=dcm01
na=n_elements(pos(0,*))
for j=0,na-1 do begin
disx=pos(0,*)-pos(0,j)
disy=pos(1,*)-pos(1,j)
w=where(disx^2+disy^2 gt bondlength^2,nb)
for i=0,nb-1 do begin
dcm02(2*j,2*w[i])=0.0
dcm02(2*j,2*w[i]+1)=0.0
dcm02(2*j+1,2*w[i])=0.0
dcm02(2*j+1,2*w[i]+1)=0.0
endfor
endfor
return,dcm02
end
