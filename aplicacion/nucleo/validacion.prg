DEFINE CLASS Validacion AS CUSTOM
    * ------------------------------------------------------------------------ *
    FUNCTION ValidarNumero
        LPARAMETERS tnValor, tcTitulo, tnValorMinimo, tnValorMaximo

        * inicio { validaciones de parámetros }
        IF PARAMETERS() < 4 THEN
            MESSAGEBOX('Muy pocos argumentos.', 0+16, ;
                LOWER(PROGRAM(PROGRAM(-1)-1)) + '->' + ;
                JUSTSTEM(THIS.ClassLibrary) + '.ValidarNumero()')
            RETURN .F.
        ENDIF

        IF VARTYPE(tnValor) != 'N' THEN
            MESSAGEBOX([El parámetro 'tnValor' debe ser de tipo número.], ;
                0+16, LOWER(PROGRAM(PROGRAM(-1)-1)) + '->' + ;
                JUSTSTEM(THIS.ClassLibrary) + '.ValidarNumero()')
            RETURN .F.
        ENDIF

        IF VARTYPE(tcTitulo) != 'C' THEN
            MESSAGEBOX([El parámetro 'tcTitulo' debe ser de tipo texto.], ;
                0+16, LOWER(PROGRAM(PROGRAM(-1)-1)) + '->' + ;
                JUSTSTEM(THIS.ClassLibrary) + '.ValidarNumero()')
            RETURN .F.
        ENDIF

        IF EMPTY(tcTitulo) THEN
            MESSAGEBOX([El parámetro 'tcTitulo' no puede quedar en blanco.], ;
                0+16, LOWER(PROGRAM(PROGRAM(-1)-1)) + '->' + ;
                JUSTSTEM(THIS.ClassLibrary) + '.ValidarNumero()')
            RETURN .F.
        ENDIF

        IF VARTYPE(tnValorMinimo) != 'N' THEN
            MESSAGEBOX([El parámetro 'tnValorMinimo' debe ser de tipo ] + ;
                [número.], 0+16, LOWER(PROGRAM(PROGRAM(-1)-1)) + '->' + ;
                JUSTSTEM(THIS.ClassLibrary) + '.ValidarNumero()')
            RETURN .F.
        ENDIF

        IF VARTYPE(tnValorMaximo) != 'N' THEN
            MESSAGEBOX([El parámetro 'tnValorMaximo' debe ser de tipo ] + ;
                [número.], 0+16, LOWER(PROGRAM(PROGRAM(-1)-1)) + '->' + ;
                JUSTSTEM(THIS.ClassLibrary) + '.ValidarNumero()')
            RETURN .F.
        ENDIF

        IF tnValorMinimo < 0 THEN
            MESSAGEBOX('La longitud mínima debe ser mayor o igual a cero.', + ;
                0+16, LOWER(PROGRAM(PROGRAM(-1)-1)) + '->' + ;
                JUSTSTEM(THIS.ClassLibrary) + '.ValidarNumero()')
            RETURN .F.
        ENDIF

        IF tnValorMinimo > tnValorMaximo THEN
            MESSAGEBOX('La valor mínimo debe ser menor o igual a la ' + ;
                'valor máximo.', 0+16, ;
                LOWER(PROGRAM(PROGRAM(-1)-1)) + '->' + ;
                JUSTSTEM(THIS.ClassLibrary) + '.ValidarNumero()')
            RETURN .F.
        ENDIF
        * fin { validaciones de parámetros }

        IF tnValor < tnValorMinimo THEN
            MESSAGEBOX(tcTitulo + ': Debe ser mayor o igual a ' + ;
                ALLTRIM(STR(tnValorMinimo)) + '.', 0+48, ;
                'Mensaje del sistema')
            RETURN .F.
        ELSE
            IF tnValor > tnValorMaximo THEN
                MESSAGEBOX(tcTitulo + ': Debe ser menor o igual a ' + ;
                    ALLTRIM(STR(tnValorMaximo)) + '.', 0+48, ;
                    'Mensaje del sistema')
                RETURN .F.
            ENDIF
        ENDIF
    ENDFUNC

    * ------------------------------------------------------------------------ *
    FUNCTION ValidarTexto
        LPARAMETERS tcValor, tcTitulo, tnLongitudMinima, tnLongitudMaxima

        * inicio { validaciones de parámetros }
        IF PARAMETERS() < 4 THEN
            MESSAGEBOX('Muy pocos argumentos.', 0+16, ;
                LOWER(PROGRAM(PROGRAM(-1)-1)) + '->' + ;
                JUSTSTEM(THIS.ClassLibrary) + '.ValidarTexto()')
            RETURN .F.
        ENDIF

        IF VARTYPE(tcValor) != 'C' THEN
            MESSAGEBOX([El parámetro 'tcValor' debe ser de tipo texto.], ;
                0+16, LOWER(PROGRAM(PROGRAM(-1)-1)) + '->' + ;
                JUSTSTEM(THIS.ClassLibrary) + '.ValidarTexto()')
            RETURN .F.
        ENDIF

        IF VARTYPE(tcTitulo) != 'C' THEN
            MESSAGEBOX([El parámetro 'tcTitulo' debe ser de tipo texto.], ;
                0+16, LOWER(PROGRAM(PROGRAM(-1)-1)) + '->' + ;
                JUSTSTEM(THIS.ClassLibrary) + '.ValidarTexto()')
            RETURN .F.
        ENDIF

        IF EMPTY(tcTitulo) THEN
            MESSAGEBOX([El parámetro 'tcTitulo' no puede quedar en blanco.], ;
                0+16, LOWER(PROGRAM(PROGRAM(-1)-1)) + '->' + ;
                JUSTSTEM(THIS.ClassLibrary) + '.ValidarTexto()')
            RETURN .F.
        ENDIF

        IF VARTYPE(tnLongitudMinima) != 'N' THEN
            MESSAGEBOX([El parámetro 'tnLongitudMinima' debe ser de tipo ] + ;
                [número.], 0+16, LOWER(PROGRAM(PROGRAM(-1)-1)) + '->' + ;
                JUSTSTEM(THIS.ClassLibrary) + '.ValidarTexto()')
            RETURN .F.
        ENDIF

        IF VARTYPE(tnLongitudMaxima) != 'N' THEN
            MESSAGEBOX([El parámetro 'tnLongitudMaxima' debe ser de tipo ] + ;
                [número.], 0+16, LOWER(PROGRAM(PROGRAM(-1)-1)) + '->' + ;
                JUSTSTEM(THIS.ClassLibrary) + '.ValidarTexto()')
            RETURN .F.
        ENDIF

        IF tnLongitudMinima < 0 THEN
            MESSAGEBOX('La longitud mínima debe ser mayor o igual a cero.', + ;
                0+16, LOWER(PROGRAM(PROGRAM(-1)-1)) + '->' + ;
                JUSTSTEM(THIS.ClassLibrary) + '.ValidarTexto()')
            RETURN .F.
        ENDIF

        IF tnLongitudMinima > tnLongitudMaxima THEN
            MESSAGEBOX('La longitud mínima debe ser menor o igual a la ' + ;
                'longitud máxima.', 0+16, ;
                LOWER(PROGRAM(PROGRAM(-1)-1)) + '->' + ;
                JUSTSTEM(THIS.ClassLibrary) + '.ValidarTexto()')
            RETURN .F.
        ENDIF
        * fin { validaciones de parámetros }

        IF tnLongitudMinima > 0 THEN    && requerido.
            IF EMPTY(tcValor) THEN
                MESSAGEBOX(tcTitulo + ': No puede quedar en blanco.', 0+48, ;
                    'Mensaje del sistema')
                RETURN .F.
            ENDIF
        ENDIF

        IF LEN(tcValor) < tnLongitudMinima THEN
            MESSAGEBOX(tcTitulo + ': Demasiado corto.', 0+48, ;
                'Mensaje del sistema')
            RETURN .F.
        ELSE
            IF LEN(tcValor) > tnLongitudMaxima THEN
                MESSAGEBOX(tcTitulo + ': Demasiado largo.', 0+48, ;
                    'Mensaje del sistema')
                RETURN .F.
            ENDIF
        ENDIF
    ENDFUNC
ENDDEFINE