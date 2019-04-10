DEFINE CLASS Campo AS CUSTOM
    * Propiedades.
    PROTECTED cTabla
    PROTECTED cAlias
    PROTECTED cCampo
    PROTECTED cTipo
    PROTECTED nAncho
    PROTECTED nDecimal
    PROTECTED lNulo

    PROTECTED cTitulo
    PROTECTED cVariable
    PROTECTED nMinimo
    PROTECTED nMaximo
    PROTECTED lRequerido

    * ------------------------------------------------------------------------ *
    FUNCTION Init
        LPARAMETERS tcTabla, tcAlias, tcCampo, tcTipo, tnAncho, tnDecimal, ;
                    tlNulo, tcTitulo, tcVariable, tnMinimo, tnMaximo, ;
                    tlRequerido

        * inicio { validaciones de parámetros }
        IF PARAMETERS() < 12 THEN
            MESSAGEBOX('Muy pocos argumentos.', 0+16, ;
                JUSTSTEM(THIS.ClassLibrary) + '.Init()')
            RETURN .F.
        ENDIF

        * 01 - tcTabla
        IF VARTYPE(tcTabla) != 'C' THEN
            MESSAGEBOX([El parámetro 'tcTabla' debe ser de tipo texto.], ;
                0+16, JUSTSTEM(THIS.ClassLibrary) + '.Init()')
            RETURN .F.
        ENDIF

        IF EMPTY(tcTabla) THEN
            MESSAGEBOX([El parámetro 'tcTabla' no debe estar vacío.], ;
                0+16, JUSTSTEM(THIS.ClassLibrary) + '.Init()')
            RETURN .F.
        ENDIF

        * 02 - tcAlias
        IF VARTYPE(tcAlias) != 'C' THEN
            MESSAGEBOX([El parámetro 'tcAlias' debe ser de tipo texto.], ;
                0+16, JUSTSTEM(THIS.ClassLibrary) + '.Init()')
            RETURN .F.
        ENDIF

        IF EMPTY(tcAlias) THEN
            MESSAGEBOX([El parámetro 'tcAlias' no debe estar vacío.], ;
                0+16, JUSTSTEM(THIS.ClassLibrary) + '.Init()')
            RETURN .F.
        ENDIF

        * 03 - tcCampo
        IF VARTYPE(tcCampo) != 'C' THEN
            MESSAGEBOX([El parámetro 'tcCampo' debe ser de tipo texto.], ;
                0+16, JUSTSTEM(THIS.ClassLibrary) + '.Init()')
            RETURN .F.
        ENDIF

        IF EMPTY(tcCampo) THEN
            MESSAGEBOX([El parámetro 'tcCampo' no debe estar vacío.], ;
                0+16, JUSTSTEM(THIS.ClassLibrary) + '.Init()')
            RETURN .F.
        ENDIF

        * 04 - tcTipo
        IF VARTYPE(tcTipo) != 'C' THEN
            MESSAGEBOX([El parámetro 'tcTipo' debe ser de tipo texto.], ;
                0+16, JUSTSTEM(THIS.ClassLibrary) + '.Init()')
            RETURN .F.
        ENDIF

        IF EMPTY(tcTipo) THEN
            MESSAGEBOX([El parámetro 'tcTipo' no debe estar vacío.], ;
                0+16, JUSTSTEM(THIS.ClassLibrary) + '.Init()')
            RETURN .F.
        ENDIF

        IF !INLIST(tcTipo, 'C', 'D', 'L', 'M', 'N') THEN
            MESSAGEBOX([El tipo de dato para el campo '] + tcCampo + ;
                [' no es válido], 0+16, JUSTSTEM(THIS.ClassLibrary) + '.Init()')
            RETURN .F.
        ENDIF

        * 05 - tnAncho
        IF VARTYPE(tnAncho) != 'N' THEN
            MESSAGEBOX([El parámetro 'tnAncho' debe ser de tipo número.], ;
                0+16, JUSTSTEM(THIS.ClassLibrary) + '.Init()')
            RETURN .F.
        ENDIF

        DO CASE
        CASE tcTipo == 'C'
            IF !BETWEEN(tnAncho, 1, 254) THEN
                MESSAGEBOX([El parámetro 'tnAncho' debe ser un valor ] + ;
                    [entre 1 y 254.], 0+16, JUSTSTEM(THIS.ClassLibrary) + ;
                    '.Init()')
                RETURN .F.
            ENDIF
        CASE tcTipo == 'D'
            IF tnAncho != 8 THEN
                MESSAGEBOX([El parámetro 'tnAncho' debe ser igual a 8.], ;
                    0+16, JUSTSTEM(THIS.ClassLibrary) + '.Init()')
                RETURN .F.
            ENDIF
        CASE tcTipo == 'L'
            IF tnAncho != 1 THEN
                MESSAGEBOX([El parámetro 'tnAncho' debe ser igual a 1.], ;
                    0+16, JUSTSTEM(THIS.ClassLibrary) + '.Init()')
                RETURN .F.
            ENDIF
        CASE tcTipo == 'M'
            IF !BETWEEN(tnAncho, 1, 254) THEN
                MESSAGEBOX([El parámetro 'tnAncho' debe ser un valor ] + ;
                    [entre 1 y 254.], 0+16, JUSTSTEM(THIS.ClassLibrary) + ;
                    '.Init()')
                RETURN .F.
            ENDIF
        CASE tcTipo == 'N'
            IF !BETWEEN(tnAncho, 1, 20) THEN
                MESSAGEBOX([El parámetro 'tnAncho' debe ser un valor ] + ;
                    [entre 1 y 20.], 0+16, JUSTSTEM(THIS.ClassLibrary) + ;
                    '.Init()')
                RETURN .F.
            ENDIF
        ENDCASE

        * 06 - tnDecimal
        IF VARTYPE(tnDecimal) != 'N' THEN
            MESSAGEBOX([El parámetro 'tnDecimal' debe ser de tipo número.], ;
                0+16, JUSTSTEM(THIS.ClassLibrary) + '.Init()')
            RETURN .F.
        ENDIF

        IF tcTipo == 'N'
            IF !BETWEEN(tnDecimal, 0, tnAncho - 1) THEN
                MESSAGEBOX([El parámetro 'tnDecimal' debe ser un valor ] + ;
                    [entre 0 y ] + ALLTRIM(STR(tnAncho - 1)) + [.], 0+16, ;
                    JUSTSTEM(THIS.ClassLibrary) + '.Init()')
                RETURN .F.
            ENDIF
        ELSE
            IF tnDecimal != 0 THEN
                MESSAGEBOX([El parámetro 'tnDecimal' debe ser igual a cero.], ;
                    0+16, JUSTSTEM(THIS.ClassLibrary) + '.Init()')
                RETURN .F.
            ENDIF
        ENDIF

        * 07 - tlNulo
        IF VARTYPE(tlNulo) != 'L' THEN
            MESSAGEBOX([El parámetro 'tlNulo' debe ser de tipo lógico.], ;
                0+16, JUSTSTEM(THIS.ClassLibrary) + '.Init()')
            RETURN .F.
        ENDIF

        * 08 - tcTitulo
        IF VARTYPE(tcTitulo) != 'C' THEN
            MESSAGEBOX([El parámetro 'tcTitulo' debe ser de tipo texto.], ;
                0+16, JUSTSTEM(THIS.ClassLibrary) + '.Init()')
            RETURN .F.
        ENDIF

        IF EMPTY(tcTitulo) THEN
            MESSAGEBOX([El parámetro 'tcTitulo' no debe estar vacío.], ;
                0+16, JUSTSTEM(THIS.ClassLibrary) + '.Init()')
            RETURN .F.
        ENDIF

        * 09 - tcVariable
        IF VARTYPE(tcVariable) != 'C' THEN
            MESSAGEBOX([El parámetro 'tcVariable' debe ser de tipo texto.], ;
                0+16, JUSTSTEM(THIS.ClassLibrary) + '.Init()')
            RETURN .F.
        ENDIF

        IF EMPTY(tcVariable) THEN
            MESSAGEBOX([El parámetro 'tcVariable' no debe estar vacío.], ;
                0+16, JUSTSTEM(THIS.ClassLibrary) + '.Init()')
            RETURN .F.
        ENDIF

        * 10 - tnMinimo
        IF VARTYPE(tnMinimo) != 'N' THEN
            MESSAGEBOX([El parámetro 'tnMinimo' debe ser de tipo número.], ;
                0+16, JUSTSTEM(THIS.ClassLibrary) + '.Init()')
            RETURN .F.
        ENDIF

        IF tnMinimo < 0 THEN
            MESSAGEBOX([El parámetro 'tnMinimo' debe ser mayor o igual ] + ;
                [a cero.], 0+16, JUSTSTEM(THIS.ClassLibrary) + '.Init()')
            RETURN .F.
        ENDIF

        * 11 - tnMaximo
        IF VARTYPE(tnMaximo) != 'N' THEN
            MESSAGEBOX([El parámetro 'tnMaximo' debe ser de tipo número.] + ;
                CHR(13) + ;
                CHR(13) + [Tabla: '] + tcTabla + ['] + ;
                CHR(13) + [Alias: '] + tcAlias + ['] + ;
                CHR(13) + [Campo: '] + tcCampo + ['], ;
                0+16, JUSTSTEM(THIS.ClassLibrary) + '.Init()')
            RETURN .F.
        ENDIF

        IF tnMaximo < 0 THEN
            MESSAGEBOX([El parámetro 'tnMaximo' debe ser mayor o igual ] + ;
                [a cero.] + ;
                CHR(13) + ;
                CHR(13) + [Tabla: '] + tcTabla + ['] + ;
                CHR(13) + [Alias: '] + tcAlias + ['] + ;
                CHR(13) + [Campo: '] + tcCampo + ['], ;
                0+16, JUSTSTEM(THIS.ClassLibrary) + '.Init()')
            RETURN .F.
        ENDIF

        DO CASE
        CASE tcTipo == 'C'
            IF tnMaximo != tnAncho THEN
                MESSAGEBOX([El parámetro 'tnMaximo' debe ser igual al ] + ;
                    [ancho.], 0+16, JUSTSTEM(THIS.ClassLibrary) + ;
                    '.Init()')
                RETURN .F.
            ENDIF
        CASE tcTipo == 'D'
            IF tnMaximo != 8 THEN
                MESSAGEBOX([El parámetro 'tnMaximo' debe ser igual a 8.], ;
                    0+16, JUSTSTEM(THIS.ClassLibrary) + '.Init()')
                RETURN .F.
            ENDIF
        CASE tcTipo == 'N'
            IF tnMaximo > VAL(REPLICATE('9', tnAncho)) THEN
                MESSAGEBOX([El parámetro 'tnMaximo' debe ser menor o igual ] + ;
                    [a ] + REPLICATE('9', tnAncho) + [.], 0+16, ;
                    JUSTSTEM(THIS.ClassLibrary) + '.Init()')
                RETURN .F.
            ENDIF
        CASE tcTipo == 'L'
            IF tnMaximo != 1 THEN
                MESSAGEBOX([El parámetro 'tnMaximo' debe ser igual a 1.] + ;
                    CHR(13) + ;
                    CHR(13) + [Tabla: '] + tcTabla + ['] + ;
                    CHR(13) + [Alias: '] + tcAlias + ['] + ;
                    CHR(13) + [Campo: '] + tcCampo + ['], ;
                    0+16, JUSTSTEM(THIS.ClassLibrary) + '.Init()')
                RETURN .F.
            ENDIF
        ENDCASE

        * 12 - tlRequerido
        IF VARTYPE(tlRequerido) != 'L' THEN
            MESSAGEBOX([El parámetro 'tlRequerido' debe ser de tipo lógico.], ;
                0+16, JUSTSTEM(THIS.ClassLibrary) + '.Init()')
            RETURN .F.
        ENDIF

        IF tlRequerido THEN
            IF tlNulo THEN
                MESSAGEBOX([El parámetro 'tlRequerido' debe ser .F. (falso).], ;
                    0+16, JUSTSTEM(THIS.ClassLibrary) + '.Init()')
                RETURN .F.
            ENDIF
        ELSE
            IF !tlNulo THEN
                MESSAGEBOX([El parámetro 'tlRequerido' debe ser .T. ] + ;
                    [(verdadero).], ;
                    0+16, JUSTSTEM(THIS.ClassLibrary) + '.Init()')
                RETURN .F.
            ENDIF
        ENDIF
        * fin { validaciones de parámetros }

        WITH THIS
            .cTabla = ALLTRIM(LOWER(tcTabla))
            .cAlias = ALLTRIM(LOWER(tcAlias))
            .cCampo = ALLTRIM(tcCampo)
            .cTipo = ALLTRIM(tcTipo)
            .nAncho = tnAncho
            .nDecimal = tnDecimal
            .lNulo = tlNulo
            .cTitulo = ALLTRIM(tcTitulo)
            .cVariable = ALLTRIM(tcVariable)
            .nMinimo = tnMinimo
            .nMaximo = tnMaximo
            .lRequerido = tlRequerido
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
    FUNCTION ObtenerCampo
        RETURN THIS.cCampo
    ENDFUNC

    * ------------------------------------------------------------------------ *
    FUNCTION ObtenerTipo
        RETURN THIS.cTipo
    ENDFUNC

    * ------------------------------------------------------------------------ *
    FUNCTION ObtenerAncho
        RETURN THIS.nAncho
    ENDFUNC

    * ------------------------------------------------------------------------ *
    FUNCTION ObtenerDecimal
        RETURN THIS.nDecimal
    ENDFUNC

    * ------------------------------------------------------------------------ *
    FUNCTION PermiteNulo
        RETURN THIS.lNulo
    ENDFUNC

    * ------------------------------------------------------------------------ *
    FUNCTION ObtenerTitulo
        RETURN THIS.cTitulo
    ENDFUNC

    * ------------------------------------------------------------------------ *
    FUNCTION ObtenerVariable
        RETURN THIS.cVariable
    ENDFUNC

    * ------------------------------------------------------------------------ *
    FUNCTION ObtenerMinimo
        RETURN THIS.nMinimo
    ENDFUNC

    * ------------------------------------------------------------------------ *
    FUNCTION ObtenerMaximo
        RETURN THIS.nMaximo
    ENDFUNC

    * ------------------------------------------------------------------------ *
    FUNCTION EsRequerido
        RETURN THIS.lRequerido
    ENDFUNC
ENDDEFINE