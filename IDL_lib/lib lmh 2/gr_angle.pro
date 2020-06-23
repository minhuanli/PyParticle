;can be used to calculate crystal with different types
function gr_angle, trb, id, cluid1,cluid2, rmax=rmax, database1=database1,database2=database2,layer=layer,rhcp=rhcp,bcc=bcc,clip=clip
    if (not keyword_set(database1)) then database1=trb
    if (not keyword_set(database2)) then database2=trb
    w1=where(id eq cluid1)
    clu1=trb(*,w1)
    w2=where(id eq cluid2)
    clu2=trb(*,w2)
    
    ;-------eliminate the boundary particles and pick out crystal particles--------------------
    if (keyword_set(clip)) then begin
    max1=max(database1(0,*))-rmax-2
    may1=max(database1(1,*))-rmax-2
    maz1=max(database1(2,*))-rmax-2
    mix1=min(database1(0,*))+rmax+2
    miy1=min(database1(1,*))+rmax+2
    miz1=min(database1(2,*))+rmax+2
    
    max2=max(database2(0,*))-rmax-2
    may2=max(database2(1,*))-rmax-2
    maz2=max(database2(2,*))-rmax-2
    mix2=min(database2(0,*))+rmax+2
    miy2=min(database2(1,*))+rmax+2
    miz2=min(database2(2,*))+rmax+2
    
    clu1=eclip(clu1,[0,mix1,max1],[1,miy1,may1],[2,miz1,maz1])
    clu2=eclip(clu2,[0,mix2,max2],[1,miy2,may2],[2,miz2,maz2])
    endif
    
    ww1=where( clu1(3,*) ge 10,nww1)
    ww2=where( clu2(3,*) ge 10,nww2)
    print,nww1
    print,nww2
    if nww1 gt 2000 then ww1=ww1(0:1999)
    if nww2 gt 2000 then ww2=ww2(0:1999)
    cr1=clu1(*,ww1)
    cr2=clu2(*,ww2)
    
    ;---------------determine crystal type of cr1 and cr2--------------------
    flag1=0
    wb1=where(cr1(16,*) gt 13,nwb1)
    wh1=where(cr1(16,*) lt 13,nwh1)
    print,'bcc and rhcp in cr1' + string(nwb1) + string(nwh1)
    if nwh1 gt nwb1 then begin
    flag1=1
    print,'cr1 is a rhcp type crystal'
    cr1=cr1(*,wh1)
    endif else begin
    print,'cr1 is a bcc type crystal'
    cr1=cr1(*,wb1)
    endelse 
    
    flag2=0
    wb2=where(cr2(16,*) gt 13,nwb2)
    wh2=where(cr2(16,*) lt 13,nwh2)
    print,'bcc and rhcp in cr2'+ string(nwb2) + string(nwh2) 
    if nwh2 gt nwb2 then begin
    flag2=1
    print,'cr2 is a rhcp type crystal'
    cr2=cr2(*,wh2)
    endif else begin
    print,'cr2 is a bcc type crystal'
    cr2=cr2(*,wb2)
    endelse 
   
    
    ;  result(0), 0 is both bcc, 1 is both hcp, 2 is mix 
    result=fltarr(2,1)
    if (flag1 eq 0 and flag2 eq 0) then begin
      result(0,0) = 0
      if keyword_set(layer) then begin
          result(1,0)=cal_bcc(cr1=cr1,cr2=cr2,data1=database1,data2=database2,rmax=rmax,/layer)
      endif else begin
          result=cal_bcc(cr1=cr1,cr2=cr2,data1=database1,data2=database2,rmax=rmax)
      endelse
    endif
    
     if (flag1 eq 1 and flag2 eq 1)  then begin
      result(0,0) = 1
      if keyword_set(layer) then begin
          result(1,0)=cal_fcc(cr1=cr1,cr2=cr2,data1=database1,data2=database2,rmax=rmax,/layer)
      endif else begin
          result=cal_fcc(cr1=cr1,cr2=cr2,data1=database1,data2=database2,rmax=rmax)
      endelse
    endif
    
    if (flag1 eq 1 and flag2 eq 0) then begin
      result(0,0) = 2
      result(1,0) = cal_mix(crbcc=cr2,crhcp=cr1,database=database1,rmax=rmax)
    endif
    
    if (flag1 eq 0 and flag2 eq 1) then begin
      result(0,0) = 2
      result(1,0) = cal_mix(crbcc=cr1,crhcp=cr2,database=database1,rmax=rmax)
    endif
    
    
 return,result
 
end