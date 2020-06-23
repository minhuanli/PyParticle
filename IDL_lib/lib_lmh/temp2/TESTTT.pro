for j=0.,m-1. do begin
            if strt(si(isort(j))) eq -1 then begin
               strt(si(isort(j))) = j
               fnsh(si(isort(j))) = j
            endif else fnsh(si(isort(j))) = j
endfor 

   END