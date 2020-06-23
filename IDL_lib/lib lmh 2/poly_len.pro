function poly_len,trb=trb
    seq=polyseq(trb)
    nn = n_elements(trb(0,*))
    result = fltarr(nn)
    for i =0,nn-1 do begin 
    if i ne nn-1 then result(i)=norm(trb(0:2,seq(i))-trb(0:2,seq(i+1))) else result(i)=norm(trb(0:2,seq(i))-trb(0:2,seq(0)))
    endfor
    return,result
end