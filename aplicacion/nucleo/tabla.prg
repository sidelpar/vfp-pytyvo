DEFINE CLASS Tabla AS CUSTOM
    * Propiedades.
    PROTECTED cTabla
    PROTECTED cAlias
    PROTECTED lLecturaEscritura

    * ------------------------------------------------------------------------ *
    FUNCTION Init
        LPARAMETERS tcTabla, tcAlias, tlLecturaEscritura

        * inicio { validaciones de par�metros }
        IF PARAMETERS() < 1 THEN
            MESSAGEBOX('Muy pocos argumentos.', 0+16, ;
                JUSTSTEM(THIS.ClassLibrary) + '.Init()')
            RETURN .F.
        ENDIF

        IF VARTYPE(tcTabla) != 'C' THEN
            MESSAGEBOX([El par�metro 'tcTabla' deben ser de tipo texto.], ;
                0+16, JUSTSTEM(THIS.ClassLibrary) + '.Init()')
            RETURN .F.
        ENDIF

        IF EMPTY(tcTabla) THEN
            MESSAGEBOX([El par�metro 'tcTabla' no debe estar vac�o.], ;
                0+16, JUSTSTEM(THIS.ClassLibrary) + '.Init()')
            RETURN .F.
        ENDIF
        * fin { validaciones de par�metros }

        IF VARTYPE(tcAlias) == 'C' THEN
            IF EMPTY(tcAlias) THEN
                tcAlias = tcTabla
            ENDIF
        ELSE
            tcAlias = tcTabla
        ENDIF

        IF VARTYPE(tlLecturaEscritura) != 'L' THEN
            tlLecturaEscritura = .F.
        ENDIF

        WITH THIS
            .cTabla = ALLTRIM(LOWER(tcTabla))
            .cAlias = ALLTRIM(LOWER(tcAlias))
            .lLecturaEscritura = tlLecturaEscritura
        ENDWITH
    ENDFUNC

    * ------------------------------------------------------------------------ *
    FUNCTION ObtenerTabla
        RETURN THIS.cTabla
    ENDFUNC

    * ------------------------------------------------------------------------ *
    FUNCTION ObtenerAlias
        RETURN THIS.cAlias
    ENDFUNC

    * ------------------------------------------------------------------------ *
    FUNCTION EnModoLecturaEscritura
        RETURN THIS.lLecturaEscritura
    ENDFUNC
ENDDEFINE