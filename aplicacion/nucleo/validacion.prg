DEFINE CLASS Validacion AS CUSTOM
    * ------------------------------------------------------------------------ *
    FUNCTION ValidarNumero
        LPARAMETERS tnValor, tcTitulo, tnValorMinimo, tnValorMaximo

        * inicio { validaciones de par�metros }
        IF PARAMETERS() < 4 THEN
            MESSAGEBOX('Muy pocos argumentos.', 0+16, ;
                LOWER(PROGRAM(PROGRAM(-1)-1)) + '->' + ;
                JUSTSTEM(THIS.ClassLibrary) + '.ValidarNumero()')
            RETURN .F.
        ENDIF

        IF VARTYPE(tnValor) != 'N' THEN
            MESSAGEBOX([El par�metro 'tnValor' debe ser de tipo n�mero.], ;
                0+16, LOWER(PROGRAM(PROGRAM(-1)-1)) + '->' + ;
                JUSTSTEM(THIS.ClassLibrary) + '.ValidarNumero()')
            RETURN .F.
        ENDIF

        IF VARTYPE(tcTitulo) != 'C' THEN
            MESSAGEBOX([El par�metro 'tcTitulo' debe ser de tipo texto.], ;
                0+16, LOWER(PROGRAM(PROGRAM(-1)-1)) + '->' + ;
                JUSTSTEM(THIS.ClassLibrary) + '.ValidarNumero()')
            RETURN .F.
        ENDIF

        IF EMPTY(tcTitulo) THEN
            MESSAGEBOX([El par�metro 'tcTitulo' no puede quedar en blanco.], ;
                0+16, LOWER(PROGRAM(PROGRAM(-1)-1)) + '->' + ;
                JUSTSTEM(THIS.ClassLibrary) + '.ValidarNumero()')
            RETURN .F.
        ENDIF

        IF VARTYPE(tnValorMinimo) != 'N' THEN
            MESSAGEBOX([El par�metro 'tnValorMinimo' debe ser de tipo ] + ;
                [n�mero.], 0+16, LOWER(PROGRAM(PROGRAM(-1)-1)) + '->' + ;
                JUSTSTEM(THIS.ClassLibrary) + '.ValidarNumero()')
            RETURN .F.
        ENDIF

        IF VARTYPE(tnValorMaximo) != 'N' THEN
            MESSAGEBOX([El par�metro 'tnValorMaximo' debe ser de tipo ] + ;
                [n�mero.], 0+16, LOWER(PROGRAM(PROGRAM(-1)-1)) + '->' + ;
                JUSTSTEM(THIS.ClassLibrary) + '.ValidarNumero()')
            RETURN .F.
        ENDIF

        IF tnValorMinimo < 0 THEN
            MESSAGEBOX('La longitud m�nima debe ser mayor o igual a cero.', + ;
                0+16, LOWER(PROGRAM(PROGRAM(-1)-1)) + '->' + ;
                JUSTSTEM(THIS.ClassLibrary) + '.ValidarNumero()')
            RETURN .F.
        ENDIF

        IF tnValorMinimo > tnValorMaximo THEN
            MESSAGEBOX('La valor m�nimo debe ser menor o igual a la ' + ;
                'valor m�ximo.', 0+16, ;
                LOWER(PROGRAM(PROGRAM(-1)-1)) + '->' + ;
                JUSTSTEM(THIS.ClassLibrary) + '.ValidarNumero()')
            RETURN .F.
        ENDIF
        * fin { validaciones de par�metros }

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

        * inicio { validaciones de par�metros }
        IF PARAMETERS() < 4 THEN
            MESSAGEBOX('Muy pocos argumentos.', 0+16, ;
                LOWER(PROGRAM(PROGRAM(-1)-1)) + '->' + ;
                JUSTSTEM(THIS.ClassLibrary) + '.ValidarTexto()')
            RETURN .F.
        ENDIF

        IF VARTYPE(tcValor) != 'C' THEN
            MESSAGEBOX([El par�metro 'tcValor' debe ser de tipo texto.], ;
                0+16, LOWER(PROGRAM(PROGRAM(-1)-1)) + '->' + ;
                JUSTSTEM(THIS.ClassLibrary) + '.ValidarTexto()')
            RETURN .F.
        ENDIF

        IF VARTYPE(tcTitulo) != 'C' THEN
            MESSAGEBOX([El par�metro 'tcTitulo' debe ser de tipo texto.], ;
                0+16, LOWER(PROGRAM(PROGRAM(-1)-1)) + '->' + ;
                JUSTSTEM(THIS.ClassLibrary) + '.ValidarTexto()')
            RETURN .F.
        ENDIF

        IF EMPTY(tcTitulo) THEN
            MESSAGEBOX([El par�metro 'tcTitulo' no puede quedar en blanco.], ;
                0+16, LOWER(PROGRAM(PROGRAM(-1)-1)) + '->' + ;
                JUSTSTEM(THIS.ClassLibrary) + '.ValidarTexto()')
            RETURN .F.
        ENDIF

        IF VARTYPE(tnLongitudMinima) != 'N' THEN
            MESSAGEBOX([El par�metro 'tnLongitudMinima' debe ser de tipo ] + ;
                [n�mero.], 0+16, LOWER(PROGRAM(PROGRAM(-1)-1)) + '->' + ;
                JUSTSTEM(THIS.ClassLibrary) + '.ValidarTexto()')
            RETURN .F.
        ENDIF

        IF VARTYPE(tnLongitudMaxima) != 'N' THEN
            MESSAGEBOX([El par�metro 'tnLongitudMaxima' debe ser de tipo ] + ;
                [n�mero.], 0+16, LOWER(PROGRAM(PROGRAM(-1)-1)) + '->' + ;
                JUSTSTEM(THIS.ClassLibrary) + '.ValidarTexto()')
            RETURN .F.
        ENDIF

        IF tnLongitudMinima < 0 THEN
            MESSAGEBOX('La longitud m�nima debe ser mayor o igual a cero.', + ;
                0+16, LOWER(PROGRAM(PROGRAM(-1)-1)) + '->' + ;
                JUSTSTEM(THIS.ClassLibrary) + '.ValidarTexto()')
            RETURN .F.
        ENDIF

        IF tnLongitudMinima > tnLongitudMaxima THEN
            MESSAGEBOX('La longitud m�nima debe ser menor o igual a la ' + ;
                'longitud m�xima.', 0+16, ;
                LOWER(PROGRAM(PROGRAM(-1)-1)) + '->' + ;
                JUSTSTEM(THIS.ClassLibrary) + '.ValidarTexto()')
            RETURN .F.
        ENDIF
        * fin { validaciones de par�metros }

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