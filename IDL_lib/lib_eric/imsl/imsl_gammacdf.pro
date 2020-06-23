; $Id: //depot/idl/IDL_71/idl_src/libs/imsl/imsl_6.0/lib/imsl_gammacdf.pro#1 $
;
; Copyright (c) 1970-2006, VISUAL NUMERICS Inc. All Rights Reserved.
; This software is confidential information which is proprietary to and a
; trade secret of Visual Numerics Inc.  Use, duplication or disclosure is
; subject to the terms of an appropriate license agreement.
;
FUNCTION imsl_gammacdf, x, $      ;INPUT Scalar or 1-D array: floating point
                 y, $          ;INPUT Scalar or 1-D array: floating point
                double=double  ;INPUT Scalar ON/OFF flag
@imsl_init.pro
   ON_ERROR, on_err_action

   RETURN, imsl_call_spcl_fcn2(x, y, $
                          fcn_name = "GAMMACDF", $
                          double = double, $
                          inverse = inverse)
END
