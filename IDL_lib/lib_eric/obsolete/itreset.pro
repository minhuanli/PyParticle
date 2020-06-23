; $Id: //depot/idl/IDL_71/idldir/lib/obsolete/itreset.pro#1 $
;
; Copyright (c) 2002-2009, ITT Visual Information Solutions. All
;       rights reserved. Unauthorized reproduction is prohibited.
;+
; NAME:
;   itReset
;
; PURPOSE:
;   A command line routine used to reset the entire tools system in
;   the current IDL session. It will call the _ResetSystem method on
;   the underlying system object.
;
; PARAMETERS:
;   None.
;
; KEYWORDS:
;   NO_PROMPT - If set, the user is not prompted to verify the reset action.
;-

;-------------------------------------------------------------------------
PRO itReset, NO_PROMPT=NO_PROMPT

   compile_opt hidden, idl2

   iReset, NO_PROMPT=NO_PROMPT

end


