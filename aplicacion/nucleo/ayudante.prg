DEFINE CLASS Ayudante AS Validacion
    * Propiedades.
    PROTECTED cClaseRepositorio
    PROTECTED oConexion

    * ------------------------------------------------------------------------ *
    PROTECTED FUNCTION Init
        IF VARTYPE(THIS.cClaseRepositorio) != 'C' OR ;
                EMPTY(THIS.cClaseRepositorio) THEN
            RETURN .F.
        ENDIF

        IF !THIS.EstablecerConexion() THEN
            RETURN .F.
        ENDIF
    ENDFUNC

    * ------------------------------------------------------------------------ *
    FUNCTION ValidarNombre
        LPARAMETERS tcNombre, tnBandera, tnCodigo, tnLongitudMinima, ;
                    tnLongitudMaxima

        * inicio { validaciones de parámetros }
        IF VARTYPE(tnLongitudMinima) != 'N' THEN
            tnLongitudMinima = 6
        ENDIF

        IF VARTYPE(tnLongitudMaxima) != 'N' THEN
            tnLongitudMaxima = 30
        ENDIF

        IF !THIS.ValidarTexto( ;
                tcNombre, 'Nombre', tnLongitudMinima, tnLongitudMaxima) THEN
            RETURN .F.
        ENDIF

        IF !THIS.ValidarNumero(tnBandera, 'Bandera', 1, 2) THEN
            RETURN .F.
        ENDIF

        IF tnBandera == 1 THEN    && agregar.
            IF !THIS.ValidarNumero(tnCodigo, 'Código', 0, 32767) THEN
                RETURN .F.
            ENDIF
        ENDIF

        IF tnBandera == 2 THEN   && modificar.
            IF !THIS.ValidarNumero(tnCodigo, 'Código', 1, 32767) THEN
                RETURN .F.
            ENDIF
        ENDIF
        * fin { validaciones de parámetros }

        LOCAL loRepositorio, loModelo

        IF tnBandera == 1 THEN    && agregar.
            IF THIS.ValidarRepositorio() THEN
                loRepositorio = CREATEOBJECT(THIS.cClaseRepositorio, ;
                    THIS.oConexion)

                IF loRepositorio.NombreExiste(tcNombre) THEN
                    MESSAGEBOX('Nombre: Ya existe.', 0+48, ;
                        'Mensaje del sistema')
                    RETURN .F.
                ENDIF
            ELSE
                RETURN .F.
            ENDIF
        ENDIF

        IF tnBandera == 2 THEN    && modificar.
            IF THIS.ValidarRepositorio() THEN
                loRepositorio = CREATEOBJECT(THIS.cClaseRepositorio, ;
                    THIS.oConexion)
                loModelo = loRepositorio.ObtenerPorNombre(tcNombre)

                IF VARTYPE(loModelo) == 'O' THEN
                    IF loModelo.ObtenerCodigo() != tnCodigo THEN
                        MESSAGEBOX('Nombre: Ya existe.', 0+48, ;
                            'Mensaje del sistema')
                        RETURN .F.
                    ENDIF
                ENDIF
            ELSE
                RETURN .F.
            ENDIF
        ENDIF
    ENDFUNC

    * ------------------------------------------------------------------------ *
    FUNCTION ValidarRUC
        LPARAMETERS tcRUC, tnBandera

        * inicio { validaciones de parámetros }
        IF !THIS.ValidarTexto(tcRUC, 'RUC', 5, 15) THEN
            RETURN .F.
        ENDIF

        IF !_SCREEN.oUtiles.ValidarFormatoRUCyDV(tcRUC) THEN
            MESSAGEBOX('RUC: No es válido.', 0+48, 'Mensaje del sistema')
            RETURN .F.
        ENDIF

        IF !THIS.ValidarNumero(tnBandera, 'Bandera', 1, 2) THEN
            RETURN .F.
        ENDIF
        * fin { validaciones de parámetros }

        LOCAL loRepositorio

        IF THIS.ValidarRepositorio() THEN
            loRepositorio = CREATEOBJECT(THIS.cClaseRepositorio, ;
                THIS.oConexion)

            IF loRepositorio.RucExiste(tcRUC) THEN
                MESSAGEBOX('RUC: Ya existe.', 0+48, 'Mensaje del sistema')
                RETURN .F.
            ENDIF
        ELSE
            RETURN .F.
        ENDIF
    ENDFUNC

    * ------------------------------------------------------------------------ *
    PROTECTED FUNCTION EstablecerConexion
        LOCAL loConexion, laTabla, lnContador, lcTabla, lcAlias

        loConexion = CREATEOBJECT('Conexion', goAplicacion.ObtenerRutaDatos())

        IF VARTYPE(loConexion) == 'O' THEN
            DO CASE
            CASE THIS.cClaseRepositorio == 'RepositorioArticulo'
                * {fila, 1} Tabla  |  {fila, 2} Alias
                DIMENSION laTabla[1,2]
                laTabla[1,1] = 'maesprod'
                laTabla[1,2] = 'articulos'
            CASE THIS.cClaseRepositorio == 'RepositorioProveedor'
                * {fila, 1} Tabla  |  {fila, 2} Alias
                DIMENSION laTabla[1,2]
                laTabla[1,1] = 'proveedo'
                laTabla[1,2] = 'proveedores'
            OTHERWISE
                MESSAGEBOX('No se pudo identificar el módulo al cual ' + ;
                    'pertenece este ayudante.', 0+16, ;
                    JUSTSTEM(THIS.ClassLibrary) + '.EstablecerConexion()')
                RETURN .F.
            ENDCASE
        ELSE
            MESSAGEBOX([No se pudo crear el objeto 'loConexion'.], 0+16, ;
                JUSTSTEM(THIS.ClassLibrary) + '.EstablecerConexion()')
            RETURN .F.
        ENDIF

        IF TYPE('laTabla', 1) == 'A' THEN
            IF VARTYPE(laTabla) == 'C' THEN
                FOR lnContador = 1 TO ALEN(laTabla, 1)
                    IF VARTYPE(laTabla[lnContador, 1]) == 'C' AND ;
                            !EMPTY(laTabla[lnContador, 1]) THEN
                        lcTabla = laTabla[lnContador, 1]

                        IF VARTYPE(laTabla[lnContador, 2]) == 'C' AND ;
                                !EMPTY(laTabla[lnContador, 2]) THEN
                            lcAlias = laTabla[lnContador, 2]
                        ELSE
                            lcAlias = lcTabla
                        ENDIF

                        IF !loConexion.AgregarTabla(CREATEOBJECT('Tabla', ;
                                lcTabla, lcAlias)) THEN
                            MESSAGEBOX([No se pudo agregar la tabla '] + ;
                                lcTabla + [' al objeto 'loConexion'.], 0+16, ;
                                JUSTSTEM(THIS.ClassLibrary) + ;
                                '.EstablecerConexion()')
                            RETURN .F.
                        ENDIF
                    ENDIF
                ENDFOR
            ELSE
                RETURN .F.
            ENDIF
        ELSE
            RETURN .F.
        ENDIF

        THIS.oConexion = loConexion
    ENDFUNC

    * ------------------------------------------------------------------------ *
    PROTECTED FUNCTION ValidarRepositorio
        * inicio { validaciones }
        IF VARTYPE(THIS.cClaseRepositorio) != 'C' OR ;
                EMPTY(THIS.cClaseRepositorio) THEN
            RETURN .F.
        ENDIF
        * fin { validaciones }

        LOCAL loRepositorio, loExcepcion

        TRY
            loRepositorio = CREATEOBJECT(THIS.cClaseRepositorio, THIS.oConexion)
        CATCH TO loExcepcion
            _SCREEN.oUtiles.MostrarExcepcion( ;
                loExcepcion.ErrorNo, ;
                loExcepcion.LineNo, ;
                loExcepcion.Message, ;
                loExcepcion.LineContents, ;
                JUSTSTEM(THIS.ClassLibrary) + '.ValidarRepositorio()' ;
            )
        ENDTRY

        IF VARTYPE(loRepositorio) != 'O' THEN
            MESSAGEBOX('Repositorio: No es válido.', 0+16, ;
                JUSTSTEM(THIS.ClassLibrary) + '.ValidarRepositorio()')
            RETURN .F.
        ENDIF
    ENDFUNC
ENDDEFINE