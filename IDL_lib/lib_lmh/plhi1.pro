function plhi1,data,gap,sta,nu
 
 w=where(data ge sta and data lt (sta+gap),nw)
 pf=[sta,nw]
 print,pf
 sta=sta+gap
 
 for i=1,nu do begin
 w=where(data ge sta and data lt (sta+gap),nw)
 tpf=[sta,nw]
 pf=[[pf],[tpf]]
 print,tpf
 sta=sta+gap
 endfor

return,pf

end