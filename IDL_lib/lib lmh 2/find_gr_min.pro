function find_gr_min,grain,rmin,rmax    ;'f' for Fearure
    
    range = where(grain(0,*) ge rmin and grain(0,*) le rmax)
    sample = grain(*,range)
    n = n_elements(sample(0,*))
    
    i = 0
    min_g = sample(1,0)
    min_r = sample(0,0)
    for i = 1,n-2 do begin
    left_change  = sample(1,i)-sample(1,i-1)
    right_change = sample(1,i+1)-sample(1,i)
        if left_change lt 0 and right_change gt 0 then begin
            min_r = sample(0,i)
            break
        end
    end
    print,min_r
    return,min_r
    
end