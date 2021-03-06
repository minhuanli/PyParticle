; $Id: //depot/idl/IDL_71/idldir/lib/itools/components/idlitopfliphorizontal__define.pro#1 $
;
; Copyright (c) 2000-2009, ITT Visual Information Solutions. All
;       rights reserved. Unauthorized reproduction is prohibited.
;----------------------------------------------------------------------------
; Purpose:
;   Implements a data flip operation.
;

;---------------------------------------------------------------------------
; Lifecycle Routines
;---------------------------------------------------------------------------
; Purpose:
;   The constructor of the IDLitopFlipVertical object.
;
; Arguments:
;   None.
;
; Keywords:
;   All keywords to superclass.
;
function IDLitopFlipHorizontal::Init, _EXTRA=_extra
    ; Pragmas
    compile_opt idl2, hidden

    if (~self->IDLitDataOperation::Init(NAME="Flip Horizontal", $
        DESCRIPTION="Flip data horizontally", $
        TYPES=['IDLARRAY2D','IDLROI'], $
        _EXTRA=_extra)) then $
        return, 0

    if (~self->_IDLitROIVertexOperation::Init(_EXTRA=_extra)) then begin
        self->Cleanup
        return, 0
    endif
   
    return, 1
end

;---------------------------------------------------------------------------
; IDLitopFlipHorizontal::Cleanup
;
; Purpose:
;   This procedure method cleans up the flip horizontal operation.
;
pro IDLitopFlipHorizontal::Cleanup
    compile_opt idl2, hidden

    ; Cleanup superclasses.
    self->_IDLitROIVertexOperation::Cleanup
    self->IDLitDataOperation::Cleanup
end

;---------------------------------------------------------------------------
; IDLitopFlipHorizontal::_ExecuteOnROI
;
; Purpose:
;   This function method executes the operation on the given ROI.
;
; Arguments:
;   oROI: A reference to the ROI visualization that is the target
;     of this operation.
;
; Keywords:
;   PARENT_IS_TARGET: Set this keyword to a non-zero value to indicate
;     that the parent is the actual target of the operation and that the
;     ROI should be handled accordingly.  By default (if this keyword is
;     not set), the ROI itself is the target of the operation.
;
function IDLitopFlipHorizontal::_ExecuteOnROI, oROI, $
    PARENT_IS_TARGET=parentIsTarget

    compile_opt idl2, hidden

    if (KEYWORD_SET(parentIsTarget)) then begin
        oROI->GetProperty, PARENT=oParent
        if (OBJ_VALID(oParent)) then $
            oParent->GetProperty, CENTER_OF_ROTATION=center
    endif

    oROI->_IDLitVisualization::Scale, -1, 1, 1, /PREMULTIPLY, $
        CENTER_OF_ROTATION=center

    return, 1
end

;---------------------------------------------------------------------------
; Purpose:
;   Execute the Image Flip operation
;
; Arguments:
;   Data: The array of data to flip.
;
; Keywords:
;   None.
;
function IDLitopFlipHorizontal::Execute, data

    compile_opt idl2, hidden

    data = rotate(temporary(data),5)
    return,1

end

;-------------------------------------------------------------------------
pro IDLitopFlipHorizontal__define

    compile_opt idl2, hidden

    struc = {IDLitopFlipHorizontal,             $
             inherits IDLitDataOperation,       $
             inherits _IDLitROIVertexOperation  $
    }
end

