; $Id: //depot/idl/IDL_71/idldir/lib/itools/ui_widgets/idlituisplash.pro#1 $
; Copyright (c) 2004-2009, ITT Visual Information Solutions. All
;       rights reserved. Unauthorized reproduction is prohibited.
;+
; NAME:
;   IDLituiSplash
;
; PURPOSE:
;   This function implements the user interface for the splash screen.
;
; CALLING SEQUENCE:
;   Result = IDLituiSplash(oUI, Requester)
;
; INPUTS:
;
;   oUI - Objref to the UI.
;
;   Requester - Set this argument to the object reference for the caller.
;
; KEYWORD PARAMETERS:
;
; MODIFICATION HISTORY:
;   Written by:  CT, RSI, June 2004
;   Modified:
;
;-


;-------------------------------------------------------------------------
function IDLituiSplash, oUI, oRequester

    compile_opt idl2, hidden

    oRequester->GetProperty, $
        DISABLE_SPLASH=disableSplash, SPLASH_PERCENT=splashPercent

    result = IDLitwdSplash( $
        DISABLE_SPLASH=disableSplash, $
        PERCENT=splashPercent)

    return, result
end

