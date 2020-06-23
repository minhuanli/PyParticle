;return starting point of each frame (or traj for track data)
;the last number is a starting point of a virtue extra frame
;i.e. ending point of the last frame +1.
;each frame will be xy=xyt[0:1,fp[i]:fp[i+1]-1]
pro framepoints,time,nframe,fp
tmp=shift(time,-1)-time
fp=where(tmp ne 0,count);ending point of each frame
nframe=n_elements(fp)
fp=[0,fp+1];starting points
if count eq 0 then fp[1]=n_elements(time) ;if only 1 traj,
end
