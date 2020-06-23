; $Id: //depot/idl/IDL_71/idldir/lib/itools/framework/idlitopbringforward__define.pro#1 $
;
; Copyright (c) 2002-2009, ITT Visual Information Solutions. All
;       rights reserved. Unauthorized reproduction is prohibited.
;----------------------------------------------------------------------------
;;---------------------------------------------------------------------------
;; IDLitopBringForward::DoAction
;;
;; Purpose:
;;
;; Parameters:
;; None.
;;
;-------------------------------------------------------------------------
function IDLitopBringForward::DoAction, oTool

    compile_opt idl2, hidden

    return, self->IDLitopOrder::DoAction(oTool, 'Bring Forward')
end


;-------------------------------------------------------------------------
pro IDLitopBringForward__define

    compile_opt idl2, hidden
    struc = {IDLitopBringForward, $
        inherits IDLitopOrder}

end

