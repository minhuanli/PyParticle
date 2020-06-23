; $Id: //depot/idl/IDL_71/idldir/lib/obsolete/itcurrent.pro#1 $
; Copyright (c) 2002-2009, ITT Visual Information Solutions. All
;       rights reserved. Unauthorized reproduction is prohibited.

;-------------------------------------------------------------------------
;+
; :Description:
;    Used to set the current tool in the iTools system.
;
; :Params:
;    idTool:
;        The identifier for the tool to set current. If idTool is
;        not present and /SHOW is set, then the current tool
;        is made visible.
;
; :Keywords:
;    SHOW 
;       If set then also ensure that the tool is visible
;       and raised (not iconified).
;
; :Author: KDB, RSI, Novemember 2002
;-
PRO itCurrent, idTool, SHOW=show

   compile_opt hidden, idl2

   iSetCurrent, idTool, SHOW=show

end


