;----------------------------------------------------------------
; $Id: //depot/idl/IDL_71/idldir/lib/wavelet/source/wv_fn_symlet.pro#1 $
;
; Copyright (c) 1999-2009, ITT Visual Information Solutions. All
;       rights reserved. Unauthorized reproduction is prohibited.
;+
; NAME:
;    WV_FN_SYMLET
;
; PURPOSE:
;    This function returns the Symlet wavelet coefficients.
;
; CALLING SEQUENCE:
;    info = WV_FN_SYMLET( Order, Scaling, Wavelet, Ioff, Joff)
;
; INPUTS:
;    Order: This is the order number for the Symlet wavelet.
;           Order=4 has 4 vanishing moments and 8 coefficients.
;
; OUTPUTS:
;    Scaling: A vector of the scaling (father) coefficients
;
;    Wavelet: A vector of the wavelet (mother) coefficients
;
;    Ioff: The offset index used to center the Scaling support
;
;    Joff: The offset index used to center the Wavelet support
;
; KEYWORD PARAMETERS:
;    None.
;
; RETURN VALUE:
;    Returns a structure with the following information:
;          (this is an example for order=2)
;       info = {family:'Symlet', $    ; name of wavelet family
;               order_name:'Order', $     ; term used for "order"
;               order_range:[4,15,4], $   ; valid range [first,last,default]
;               order:4, $                ; order number
;               discrete:1, $             ; 0=continuous, 1=discrete
;               orthogonal:1, $           ; 0=nonorthogonal, 1=orthogonal
;               symmetric:2, $            ; 0=asymmetric, 1=sym., 2=near sym.
;               support:7, $              ; support width
;               moments:4, $              ; # of vanishing moments
;               regularity:0.550}         ; # of continuous derivatives
;
; REFERENCE:
;    Daubechies, I., 1992: Ten Lectures on Wavelets, SIAM, p. 198.
;       Daubechies has orders 4-10, although note that Daubechies
;       has multiplied by Sqrt(2), and for some Orders the coefficients
;       are reversed.
;
;    Orders 11-15 are from <http://www.isds.duke.edu/~brani/filters.html>
;
; MODIFICATION HISTORY:
;    Written by: Chris Torrence, 1999
;-


;----------------------------------------------------------------
; Symlet orthogonal near-symmetric wavelet coefficients
FUNCTION wv_fn_symlet_coeff, order
    COMPILE_OPT strictarr, hidden
    CASE (order) OF    ; orders 1-3 are same as Daubechies 1-3
    1: coeff = [1d,1d]/SQRT(2d)  ; same as Haar
    2: coeff = [1d + SQRT(3d),3d + SQRT(3d), $
            3d - SQRT(3d),1d - SQRT(3d)]/(4d*SQRT(2d))
    3: BEGIN
        sq10 = SQRT(10d)
        sq5210 = SQRT(5d + 2d*SQRT(10d))
        coeff = [1d + sq10 + sq5210, 5d + sq10 + 3d*sq5210, $
            10d - 2d*sq10 + 2d*sq5210, 10d - 2d*sq10 - 2d*sq5210, $
            5d + sq10 - 3d*sq5210, 1d + sq10 - sq5210]/(16d*SQRT(2d))
        END
    4: coeff = [ $
        -0.07576571478950233d,$
        -0.02963552764600275d,$
        0.497618667632775d,$
        0.8037387518051327d,$
        0.2978577956053062d,$
        -0.09921954357663366d,$
        -0.01260396726203138d,$
        0.03222310060405147d]
    5: coeff = [ $
        0.0195388827352497d,$
        -0.02110183402468898d,$
        -0.1753280899080548d,$
        0.01660210576451275d,$
        0.6339789634567916d,$
        0.7234076904040388d,$
        0.1993975339768545d,$
        -0.03913424930231376d,$
        0.02951949092570631d,$
        0.02733306834499873d]
    6: coeff = [ $
        0.01540410932704474d,$
        0.003490712084221531d,$
        -0.1179901111485212d,$
        -0.04831174258569789d,$
        0.4910559419279768d,$
        0.7876411410286536d,$
        0.3379294217281644d,$
        -0.07263752278637825d,$
        -0.02106029251237119d,$
        0.04472490177078142d,$
        0.001767711864253766d,$
        -0.007800708325032496d]
    7: coeff = [ $
        0.01026817670846495d,$
        0.004010244871523197d,$
        -0.1078082377032895d,$
        -0.1400472404429405d,$
        0.2886296317506303d,$
        0.7677643170048699d,$
        0.5361019170905749d,$
        0.01744125508685128d,$
        -0.04955283493703385d,$
        0.06789269350122353d,$
        0.03051551316588014d,$
        -0.01263630340323927d,$
        -0.001047384888679668d,$
        0.002681814568260057d]
    8: coeff = [ $
        -0.003382415951003908d,$
        -0.000542132331797018d,$
        0.03169508781151886d,$
        0.00760748732494897d,$
        -0.1432942383512576d,$
        -0.06127335906765891d,$
        0.4813596512592537d,$
        0.7771857516996492d,$
        0.3644418948360139d,$
        -0.05194583810802026d,$
        -0.02721902991713553d,$
        0.04913717967372511d,$
        0.003808752013880463d,$
        -0.01495225833706814d,$
        -0.0003029205147226741d,$
        0.001889950332768561d]
    9: coeff = [ $
        0.001069490032908175d,$
        -0.0004731544986808867d,$
        -0.01026406402762793d,$
        0.008859267493410117d,$
        0.06207778930285313d,$
        -0.01823377077946773d,$
        -0.1915508312971598d,$
        0.03527248803579076d,$
        0.6173384491414731d,$
        0.7178970827644066d,$
        0.2387609146068536d,$
        -0.05456895843120489d,$
        0.0005834627459892242d,$
        0.03022487885821281d,$
        -0.01152821020772933d,$
        -0.01327196778183437d,$
        0.0006197808889867399d,$
        0.001400915525915921d]
    10: coeff = [ $
        0.0007701598091036597d,$
        0.00009563267068491565d,$
        -0.008641299277002591d,$
        -0.001465382581138532d,$
        0.04592723923095083d,$
        0.0116098939028464d,$
        -0.1594942788849671d,$
        -0.0708805357805798d,$
        0.4716906669415791d,$
        0.7695100370206782d,$
        0.3838267610640166d,$
        -0.03553674047551473d,$
        -0.03199005688220715d,$
        0.04999497207760673d,$
        0.005764912033412411d,$
        -0.02035493981234203d,$
        -0.0008043589319389408d,$
        0.004593173585320195d,$
        0.00005703608359777954d,$
        -0.0004593294210107238d]
    11: coeff = [ $
        0.0004892636102790465d,$
        0.00011053509770077d,$
        -0.006389603666537886d,$
        -0.002003471900538333d,$
        0.04300019068196203d,$
        0.03526675956730489d,$
        -0.1446023437042145d,$
        -0.2046547945050104d,$
        0.2376899090326669d,$
        0.7303435490812422d,$
        0.5720229780188006d,$
        0.09719839447055164d,$
        -0.02283265101793916d,$
        0.06997679961196318d,$
        0.03703741598066749d,$
        -0.0240808415947161d,$
        -0.009857934828835874d,$
        0.006512495674629366d,$
        0.0005883527354548924d,$
        -0.001734366267274675d,$
        -0.00003879565575380471d,$
        0.0001717219506928879d]
    12: coeff = [ $
        -0.0001790665869786187d,$
        -0.0000181580788773471d,$
        0.002350297614165271d,$
        0.0003076477963025531d,$
        -0.01458983644921009d,$
        -0.002604391031185636d,$
        0.05780417944546282d,$
        0.01530174062149447d,$
        -0.1703706972388913d,$
        -0.07833262231005749d,$
        0.4627410312313846d,$
        0.7634790977904264d,$
        0.3988859723844853d,$
        -0.0221623061807925d,$
        -0.03584883074255768d,$
        0.04917931829833128d,$
        0.007553780610861577d,$
        -0.02422072267559388d,$
        -0.001408909244210085d,$
        0.007414965517868044d,$
        0.0001802140900854918d,$
        -0.001349755755614803d,$
        -0.00001135392805049379d,$
        0.0001119671942470856d]
    13: coeff = [ $
        0.00007042986709788876d,$
        0.00003690537416474083d,$
        -0.0007213643852104347d,$
        0.0004132611973679777d,$
        0.00567485376954048d,$
        -0.00149244724795732d,$
        -0.02074968632748119d,$
        0.01761829684571489d,$
        0.09292603099190611d,$
        0.008819757923922775d,$
        -0.1404900930989444d,$
        0.1102302225796636d,$
        0.6445643835707201d,$
        0.6957391508420829d,$
        0.1977048192269691d,$
        -0.1243624606980946d,$
        -0.05975062792828035d,$
        0.01386249731469475d,$
        -0.01721164274779766d,$
        -0.02021676815629033d,$
        0.005296359721916584d,$
        0.007526225395916087d,$
        -0.0001709428497111897d,$
        -0.001136063437095249d,$
        -0.0000357386241733562d,$
        0.00006820325245288671d]
    14: coeff = [ $
        0.00004461898110644152d,$
        0.00001932902684197359d,$
        -0.0006057602055992672d,$
        -0.00007321430367811753d,$
        0.004532677588409982d,$
        0.001013142476182283d,$
        -0.01943931472230284d,$
        -0.002365051066227485d,$
        0.06982761641982026d,$
        0.02589859164319225d,$
        -0.1599974161449017d,$
        -0.05811184934484923d,$
        0.4753357348650867d,$
        0.7599762436030552d,$
        0.3932015487235067d,$
        -0.03531809075139569d,$
        -0.05763449302747868d,$
        0.03743308903888159d,$
        0.004280522331795536d,$
        -0.02919621738508546d,$
        -0.002753775776578359d,$
        0.01003769335863697d,$
        0.000366476770515625d,$
        -0.002579441672422145d,$
        -0.00006286548683867455d,$
        0.0003984356519092697d,$
        0.00001121086996816579d,$
        -0.00002587908845615303d]
    15: coeff = [ $
        0.00002866070677120333d,$
        0.00002171787955311147d,$
        -0.0004021685533613114d,$
        -0.0001081543887175515d,$
        0.003481028703942169d,$
        0.001526137844414152d,$
        -0.01717125372019869d,$
        -0.008744789536991206d,$
        0.06796982865464372d,$
        0.06839330637828124d,$
        -0.1340563101529709d,$
        -0.1966263778558184d,$
        0.2439626866290417d,$
        0.7218430206728932d,$
        0.5786404210564978d,$
        0.1115337122112223d,$
        -0.04108264812160452d,$
        0.04073549232451155d,$
        0.0219376493087618d,$
        -0.03887671358112607d,$
        -0.01940501010809092d,$
        0.01007997710234975d,$
        0.003423450420331992d,$
        -0.003590165587998719d,$
        -0.0002673164968523743d,$
        0.00107056717058685d,$
        0.00005512252372901569d,$
        -0.0001606618669228563d,$
        -7.359664092097746D-6,$
        9.712420309178714D-6]
    ELSE: coeff = -1
    ENDCASE
    RETURN,coeff
END


;----------------------------------------------------------------
FUNCTION wv_fn_symlet,order,scaling,wavelet,ioff,joff

    COMPILE_OPT strictarr
    ON_ERROR,2  ; return to caller

;defaults
    order_range = [1,15,4]  ; [first,last,default]
    IF (N_ELEMENTS(order) LT 1) THEN order = order_range[2]  ; default

; check for invalid Order
    order = FIX(order + 1E-5)
    IF ((order LT order_range[0]) OR (order GT order_range[1])) THEN BEGIN
        MESSAGE,/INFO,'Order out of range, reverting to default...'
        order = order_range[2]  ; default
    ENDIF

; Regularity = # of continuous derivatives
; orders 1-15 from Taswell (1998) p. 36 "DROLA"
    regularity = [0d,0d,0.550d,1.088d, $ ; order 0-3
        1.403d,1.776d,2.122d,2.468d, $   ; 4-7
        2.750d,3.039d,3.311d,3.579d, $   ; 8-11
        3.826d,4.072d,4.312d,4.550d]     ; 12-15
    regularity = regularity[order]

; construct Info structure
    info = {family:'Symlet', $
        order_name:'Order', $
        order_range:order_range, $
        order:order, $
        discrete:1, $
        orthogonal:1, $
        symmetric:2, $
        support:FIX(order*2-1), $
        moments:FIX(order), $
        regularity:regularity}

    IF (N_PARAMS() LT 1) THEN RETURN, info ; don't bother with rest

; choose scaling coefficients
    scaling = WV_FN_SYMLET_COEFF(order)

; construct wavelet coefficients & offsets
    n =N_ELEMENTS(scaling)
    wavelet = REVERSE(scaling)*((-1)^LINDGEN(n))
    ioff = -n/2 + 2  ; offset for scaling
    joff = ioff     ; offset for wavelet

    RETURN, info
END


