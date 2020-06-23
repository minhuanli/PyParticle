;xmin etc. define the chosen area (edge should be cut away)
;minlength: min length of trajectory, same as
;goodenough in track. if not set minlength, then
;minlength is set to the full-length of the experimental time
;meantrk: average position of each good track
;t0: only trajs start from the t0'th frame, if not specified, give a negative value
pro goodtraj,trk,newtrk,xyrange,minlength=minlength,meantrk=meantrk,t0

;trk=read_gdf(infile)
n=n_elements(trk[*,0])
framepoints,trk[n-1,*],ntraj,tp
IF (not keyword_set(minlength)) THEN minlength=max(trk[n-2,*])+1;full length
;if keyword_set(meantrk) then meantrk=[0,0]
meantrk=[0,0]
count=0L; count for good traj
for i=0L,ntraj-1 do begin
  traj=trk[*,tp[i]:tp[i+1]-1]
IF (tp[i+1]-tp[i]) ge minlength then begin
  if t0 lt 0 then tt0=traj[2,0] else tt0=t0;temp t0: tt0
  if traj[2,0] eq tt0 then begin
   x=mean(traj[0,*])
   y=mean(traj[1,*])
   if x gt xyrange[0] and x lt xyrange[1] and y gt xyrange[2] and $
   y lt xyrange[3] then begin
     traj[n-1,*]=count
;     if keyword_set(t0) then if traj[2,0] ne t0 then count=-1
     if count gt 0 then newtrk=[[newtrk],[traj]] else newtrk=traj
;if keyword_set(meantrk) then meantrk=[[meantrk],[x,y]]
    meantrk=[[meantrk],[x,y]]
    count=count+1
   endif
  endif
Endif
endfor
 if count gt 1 then meantrk=meantrk[*,1:count-1]
;return,newtrk
end
