; calculate distance of one point A away from the line created by other two points B C
; the signal represent the direction of A away from BC, right or left 
function point2line, a,b,c
ab = norm(a-b)
ac = norm(a-c)
bc = norm(b-c)

p = (ab+ac+bc) /2.

s = sqrt( p*(p-ab)*(p-ac)*(p-bc) )  ; heron's

h = 2*s / bc

if c(1) gt b(1) then begin
  tp = b
  b = c 
  c = tp
endif

judge = crossp([b-a,0.],[c-a,0.])

if judge(2) lt 0 then h = -h 

return,h

end