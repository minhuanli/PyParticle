; $Id: //depot/idl/IDL_71/idldir/lib/obsolete/pairwise.pro#1 $
;
;  Copyright (c) 1991-2009, ITT Visual Information Solutions. All
;       rights reserved. Unauthorized reproduction is prohibited.


 Pro Pairwise,X,Missing,YR,YC, NotGood1, good
 ;On return,  YR(i) = the number of entries in the ith row of the two
 ; dimensional array X that are unequal to Missing. YC= analoque of YR
 ; for rows. Also, all occurences of Missinig in X will be changed to 0.
 ; Pairwise is intended to handle missing data.

   
  S=Size(X)
  C=S(1)
  R=S(2)

 A=X
 NotGood = where(A eq Missing, count)
 Good = where(A ne Missing, count1)

 if count ne 0 THEN BEGIN
  if count1 ne 0 THEN A(Good) =1
  A(NotGood)  =0
  YR=REplicate(1,C) # A
  YC= A# replicate(1,R)
  X(where(X EQ Missing))=0
  notgood1 = notgood
 ENDIF ELSE BEGIN
   YR = replicate(C,R)
   YC = replicate(R,C)
 ENDELSE
 return
 end