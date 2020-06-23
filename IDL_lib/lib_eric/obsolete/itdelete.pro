; $Id: //depot/idl/IDL_71/idldir/lib/obsolete/itdelete.pro#1 $
; Copyright (c) 2002-2009, ITT Visual Information Solutions. All
;       rights reserved. Unauthorized reproduction is prohibited.
;+
; NAME:
;   itDelete
;
; PURPOSE:
;   Used to delete a tool in the system from the command line
;
; CALLING SEQUENCE:
;   itDelete[, idTool]
;
; INPUTS:
;   idTool  - The identifier for the tool to delete. If not provided,
;             the current tool is used.
;
; KEYWORD PARAMETERS:
;   None
;
; MODIFICATION HISTORY:
;   Written by:  KDB, RSI, Novemember 2002
;   Modified:
;
;-

;-------------------------------------------------------------------------
PRO itDelete, idTool

   compile_opt hidden, idl2

   iDelete, idTool

end


