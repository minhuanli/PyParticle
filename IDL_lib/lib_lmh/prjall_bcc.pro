;project all the bcc particles
function prjall_bcc, cpdata=cpdata, sr=sr, data=data, rm=rm, nm=nm
s=n_elements(cpdata(0,*))
for j=0.,(s-1) do begin
  temp=prj1_bcc(sr1=sr,data1=data,cp1=cpdata(*,j),rm1=rm,nm1=nm)
  if (j eq 0) then begin
    pjall=temp
  endif else begin
    pjall=[[pjall],[temp]]
  endelse
endfor

return, pjall

end 
