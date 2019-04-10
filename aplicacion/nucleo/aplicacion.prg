DEFINE CLASS Aplicacion AS CUSTOM
    * Propiedades.
    PROTECTED cTipo
    PROTECTED cNombre
    PROTECTED cAutor
    PROTECTED cCorreo

    PROTECTED cVersion
    PROTECTED cCompilacion
    PROTECTED dFechaUltimaModificacion

    PROTECTED oUsuario
    PROTECTED oPermisoUsuario
    PROTECTED oConfiguracion
    PROTECTED oUtiles
    PROTECTED oEstructuraTabla
    PROTECTED oWebHttp
    PROTECTED oValidacion

    * ------------------------------------------------------------------------ *
    FUNCTION Init
        LPARAMETERS toUsuario, toPermisoUsuario, toConfiguracion, toUtiles, ;
                    toEstructuraTabla, toWebHttp, toValidacion

        WITH THIS
            .cTipo = 'Sistema de Gestión Administrativa'
            .cNombre = 'Pytyvõ'
            .cAutor = 'José Acuña'
            .cCorreo = 'jaqnya@gmail.com'

            .EstablecerEntorno()
        ENDWITH

        IF THIS.ValidarArchivoEjecutable() AND ;
                THIS.ValidarUsuario(toUsuario) AND ;
                THIS.ValidarPermisoUsuario(toPermisoUsuario) AND ;
                THIS.ValidarConfiguracion(toConfiguracion) AND ;
                THIS.ValidarUtiles(toUtiles) AND ;
                THIS.ValidarEstructuraTabla(toEstructuraTabla) AND ;
                THIS.ValidarWebHttp(toWebHttp) AND ;
                THIS.ValidarValidacion(toValidacion) THEN
            RELEASE gcOldTalk, goUtiles, goRepositorioConfiguracion, ;
                    goConfiguracion, goUsuario, goPermisoUsuario, ;
                    goEstructuraTabla, goWebHttp, goValidacion
        ELSE
            RETURN .F.
        ENDIF
    ENDFUNC

    * ------------------------------------------------------------------------ *
    FUNCTION ObtenerTipo
        RETURN THIS.cTipo
    ENDFUNC

    * ------------------------------------------------------------------------ *
    FUNCTION ObtenerNombre
        RETURN THIS.cNombre
    ENDFUNC

    * ------------------------------------------------------------------------ *
    FUNCTION ObtenerAutor
        RETURN THIS.cAutor
    ENDFUNC

    * ------------------------------------------------------------------------ *
    FUNCTION ObtenerCorreo
        RETURN THIS.cCorreo
    ENDFUNC

    * ------------------------------------------------------------------------ *
    FUNCTION ObtenerVersion
        RETURN THIS.cVersion
    ENDFUNC

    * ------------------------------------------------------------------------ *
    FUNCTION ObtenerCompilacion
        RETURN THIS.cCompilacion
    ENDFUNC

    * ------------------------------------------------------------------------ *
    FUNCTION ObtenerFechaUltimaModificacion
        RETURN THIS.dFechaUltimaModificacion
    ENDFUNC

    * ------------------------------------------------------------------------ *
    FUNCTION ObtenerLicenciatario
        RETURN THIS.oConfiguracion.ObtenerLicenciatario()
    ENDFUNC

    * ------------------------------------------------------------------------ *
    FUNCTION ObtenerRutaDatos
        RETURN THIS.oConfiguracion.ObtenerRutaDatos()
    ENDFUNC

    * ------------------------------------------------------------------------ *
    FUNCTION ObtenerUsuario
        RETURN THIS.oUsuario
    ENDFUNC

    * ------------------------------------------------------------------------ *
    FUNCTION ObtenerPermisoUsuario
        RETURN THIS.oPermisoUsuario
    ENDFUNC

    * ------------------------------------------------------------------------ *
    FUNCTION ObtenerUtiles
        RETURN THIS.oUtiles
    ENDFUNC

    * ------------------------------------------------------------------------ *
    FUNCTION ObtenerEstructuraTabla
        RETURN THIS.oEstructuraTabla
    ENDFUNC

    * ------------------------------------------------------------------------ *
    FUNCTION ObtenerWebHttp
        RETURN THIS.oWebHttp
    ENDFUNC

    * ------------------------------------------------------------------------ *
    FUNCTION ObtenerValidacion
        RETURN THIS.oValidacion
    ENDFUNC

    * ------------------------------------------------------------------------ *
    PROTECTED PROCEDURE EstablecerEntorno
        CLEAR

        SET CENTURY ON
        SET COLLATE TO 'GENERAL'
        SET DATE BRITISH
        SET DELETED ON
        SET ESCAPE OFF
        SET EXACT ON
        SET EXCLUSIVE ON
        SET HOURS TO 24
        SET MULTILOCKS ON
        SET OPTIMIZE ON
        SET POINT TO ','
        SET REFRESH TO 1
        SET REPROCESS TO AUTOMATIC
        SET SAFETY OFF
        SET SEPARATOR TO '.'
        SET STATUS BAR OFF
        SET SYSMENU TO DEFAULT
        SET TALK OFF
        SET VIEW OFF
    ENDPROC

    * ------------------------------------------------------------------------ *
    PROTECTED FUNCTION ValidarArchivoEjecutable
        * Obtiene la versión del archivo ejecutable y su compilación.
        AGETFILEVERSION(laVersionArchivoEjecutable, 'pytyvo.exe')

        IF VARTYPE(laVersionArchivoEjecutable) != 'C' THEN
            RETURN .F.
        ENDIF

        IF !THIS.ValidarVersion(LEFT(laVersionArchivoEjecutable[4], ;
                AT('.', laVersionArchivoEjecutable[4], 2) - 1)) THEN
            RETURN .F.
        ENDIF

        IF !THIS.ValidarCompilacion(SUBSTR(laVersionArchivoEjecutable[4], ;
                AT('.', laVersionArchivoEjecutable[4], 2) + 1)) THEN
            RETURN .F.
        ENDIF

        * Obtiene la fecha de última modificación del archivo ejecutable.
        ADIR(laVersionArchivoEjecutable, 'pytyvo.exe', 'S', 1)

        IF VARTYPE(laVersionArchivoEjecutable) != 'C' THEN
            RETURN .F.
        ENDIF

        IF !THIS.ValidarFechaUltimaModificacion( ;
                laVersionArchivoEjecutable[1, 3]) THEN
            RETURN .F.
        ENDIF
    ENDFUNC

    * ------------------------------------------------------------------------ *
    PROTECTED FUNCTION ValidarVersion
        LPARAMETERS tcVersion

        IF PARAMETERS() < 1 THEN
            MESSAGEBOX('Muy pocos argumentos.', 0+16, ;
                JUSTSTEM(THIS.ClassLibrary) + '.ValidarVersion()')
            RETURN .F.
        ENDIF

        IF VARTYPE(tcVersion) != 'C' THEN
            MESSAGEBOX([El parámetro 'tcVersion' debe ser de tipo texto.], ;
                0+16, JUSTSTEM(THIS.ClassLibrary) + '.ValidarVersion()')
            RETURN .F.
        ENDIF

        IF EMPTY(tcVersion) THEN
            MESSAGEBOX([El parámetro 'tcVersion' no debe estar vacío.], 0+16, ;
                JUSTSTEM(THIS.ClassLibrary) + '.ValidarVersion()')
            RETURN .F.
        ENDIF

        THIS.cVersion = ALLTRIM(tcVersion)
    ENDFUNC

    * ------------------------------------------------------------------------ *
    PROTECTED FUNCTION ValidarCompilacion
        LPARAMETERS tcCompilacion

        IF PARAMETERS() < 1 THEN
            MESSAGEBOX('Muy pocos argumentos.', 0+16, ;
                JUSTSTEM(THIS.ClassLibrary) + '.ValidarCompilacion()')
            RETURN .F.
        ENDIF

        IF VARTYPE(tcCompilacion) != 'C' THEN
            MESSAGEBOX([El parámetro 'tcCompilacion' debe ser de tipo texto.], ;
                0+16, JUSTSTEM(THIS.ClassLibrary) + '.ValidarCompilacion()')
            RETURN .F.
        ENDIF

        IF EMPTY(tcCompilacion) THEN
            MESSAGEBOX([El parámetro 'tcCompilacion' no debe estar vacío.], ;
                0+16, JUSTSTEM(THIS.ClassLibrary) + '.ValidarCompilacion()')
            RETURN .F.
        ENDIF

        THIS.cCompilacion = ALLTRIM(tcCompilacion)
    ENDFUNC

    * ------------------------------------------------------------------------ *
    PROTECTED FUNCTION ValidarFechaUltimaModificacion
        LPARAMETERS tdFechaUltimaModificacion

        IF PARAMETERS() < 1 THEN
            MESSAGEBOX('Muy pocos argumentos.', 0+16, ;
                JUSTSTEM(THIS.ClassLibrary) + ;
                '.ValidarFechaUltimaModificacion()')
            RETURN .F.
        ENDIF

        IF VARTYPE(tdFechaUltimaModificacion) != 'D' THEN
            MESSAGEBOX([El parámetro 'tdFechaUltimaModificacion' ] + ;
                [debe ser de tipo fecha.], 0+16, ;
                JUSTSTEM(THIS.ClassLibrary) + ;
                '.ValidarFechaUltimaModificacion()')
            RETURN .F.
        ENDIF

        IF EMPTY(tdFechaUltimaModificacion) THEN
            MESSAGEBOX([El parámetro 'tdFechaUltimaModificacion' ] + ;
                [no debe estar vacío.], 0+16, JUSTSTEM(THIS.ClassLibrary) + ;
                '.ValidarFechaUltimaModificacion()')
            RETURN .F.
        ENDIF

        IF tdFechaUltimaModificacion > DATE() THEN
            MESSAGEBOX([El parámetro 'tdFechaUltimaModificacion' ] + ;
                [debe ser menor o igual a la fecha actual del sistema.], ;
                0+16, JUSTSTEM(THIS.ClassLibrary) + ;
                '.ValidarFechaUltimaModificacion()')
            RETURN .F.
        ENDIF

        THIS.dFechaUltimaModificacion = tdFechaUltimaModificacion
    ENDFUNC

    * ------------------------------------------------------------------------ *
    PROTECTED FUNCTION ValidarUsuario
        LPARAMETERS toUsuario

        IF PARAMETERS() < 1 THEN
            MESSAGEBOX('Muy pocos argumentos.', 0+16, ;
                JUSTSTEM(THIS.ClassLibrary) + '.ValidarUsuario()')
            RETURN .F.
        ENDIF

        IF VARTYPE(toUsuario) != 'O' THEN
            MESSAGEBOX([El parámetro 'toUsuario' debe ser de tipo objeto.], ;
                0+16, JUSTSTEM(THIS.ClassLibrary) + '.ValidarUsuario()')
            RETURN .F.
        ENDIF

        IF toUsuario.Class != 'Usuario' THEN
            MESSAGEBOX([El parámetro 'toUsuario' no es una instancia de la ] + ;
                [clase 'Usuario'.], 0+16, JUSTSTEM(THIS.ClassLibrary) + ;
                '.ValidarUsuario()')
            RETURN .F.
        ENDIF

        THIS.oUsuario = toUsuario
    ENDFUNC

    * ------------------------------------------------------------------------ *
    PROTECTED FUNCTION ValidarPermisoUsuario
        LPARAMETERS toPermiso

        IF PARAMETERS() < 1 THEN
            MESSAGEBOX('Muy pocos argumentos.', 0+16, ;
                JUSTSTEM(THIS.ClassLibrary) + '.ValidarPermisoUsuario()')
            RETURN .F.
        ENDIF

        IF VARTYPE(toPermiso) != 'O' THEN
            MESSAGEBOX([El parámetro 'toPermiso' debe ser de tipo objeto.], ;
                0+16, JUSTSTEM(THIS.ClassLibrary) + '.ValidarPermisoUsuario()')
            RETURN .F.
        ENDIF

        IF toPermiso.Class != 'PermisoUsuario' THEN
            MESSAGEBOX([El parámetro 'toPermiso' no es una instancia de la ] + ;
                [clase 'Permiso'.], 0+16, JUSTSTEM(THIS.ClassLibrary) + ;
                '.ValidarPermisoUsuario()')
            RETURN .F.
        ENDIF

        THIS.oPermisoUsuario = toPermiso
    ENDFUNC

    * ------------------------------------------------------------------------ *
    PROTECTED FUNCTION ValidarConfiguracion
        LPARAMETERS toConfiguracion

        IF PARAMETERS() < 1 THEN
            MESSAGEBOX('Muy pocos argumentos.', 0+16, ;
                JUSTSTEM(THIS.ClassLibrary) + '.ValidarConfiguracion()')
            RETURN .F.
        ENDIF

        IF VARTYPE(toConfiguracion) != 'O' THEN
            MESSAGEBOX([El parámetro 'toConfiguracion' debe ser de tipo ] + ;
                [objeto.], 0+16, JUSTSTEM(THIS.ClassLibrary) + ;
                '.ValidarConfiguracion()')
            RETURN .F.
        ENDIF

        IF toConfiguracion.Class != 'Configuracion' THEN
            MESSAGEBOX([El parámetro 'toConfiguracion' no es una instancia ] + ;
                [de la clase 'Configuracion'.], 0+16, ;
                JUSTSTEM(THIS.ClassLibrary) + '.ValidarConfiguracion()')
            RETURN .F.
        ENDIF

        THIS.oConfiguracion = toConfiguracion
    ENDFUNC

    * ------------------------------------------------------------------------ *
    PROTECTED FUNCTION ValidarUtiles
        LPARAMETERS toUtiles

        IF PARAMETERS() < 1 THEN
            MESSAGEBOX('Muy pocos argumentos.', 0+16, ;
                JUSTSTEM(THIS.ClassLibrary) + '.ValidarUtiles()')
            RETURN .F.
        ENDIF

        IF VARTYPE(toUtiles) != 'O' THEN
            MESSAGEBOX([El parámetro 'toUtiles' debe ser de tipo objeto.], ;
                0+16, JUSTSTEM(THIS.ClassLibrary) + '.ValidarUtiles()')
            RETURN .F.
        ENDIF

        IF toUtiles.Class != 'Utiles' THEN
            MESSAGEBOX([El parámetro 'toUtiles' no es una instancia de la ] + ;
                [clase 'Utiles'.], 0+16, JUSTSTEM(THIS.ClassLibrary) + ;
                '.ValidarUtiles()')
            RETURN .F.
        ENDIF

        THIS.oUtiles = toUtiles
    ENDFUNC

    * ------------------------------------------------------------------------ *
    PROTECTED FUNCTION ValidarEstructuraTabla
        LPARAMETERS toEstructuraTabla

        IF PARAMETERS() < 1 THEN
            MESSAGEBOX('Muy pocos argumentos.', 0+16, ;
                JUSTSTEM(THIS.ClassLibrary) + '.ValidarEstructuraTabla()')
            RETURN .F.
        ENDIF

        IF VARTYPE(toEstructuraTabla) != 'O' THEN
            MESSAGEBOX([El parámetro 'toEstructuraTabla' debe ser de tipo objeto.], ;
                0+16, JUSTSTEM(THIS.ClassLibrary) + '.ValidarEstructuraTabla()')
            RETURN .F.
        ENDIF

        IF toEstructuraTabla.Class != 'EstructuraTabla' THEN
            MESSAGEBOX([El parámetro 'toEstructuraTabla' no es una instancia de la ] + ;
                [clase 'EstructuraTabla'.], 0+16, JUSTSTEM(THIS.ClassLibrary) + ;
                '.ValidarEstructuraTabla()')
            RETURN .F.
        ENDIF

        THIS.oEstructuraTabla = toEstructuraTabla
    ENDFUNC

    * ------------------------------------------------------------------------ *
    PROTECTED FUNCTION ValidarWebHttp
        LPARAMETERS toWebHttp

        IF PARAMETERS() < 1 THEN
            MESSAGEBOX('Muy pocos argumentos.', 0+16, ;
                JUSTSTEM(THIS.ClassLibrary) + '.ValidarWebHttp()')
            RETURN .F.
        ENDIF

        IF VARTYPE(toWebHttp) != 'O' THEN
            MESSAGEBOX([El parámetro 'toWebHttp' debe ser de tipo objeto.], ;
                0+16, JUSTSTEM(THIS.ClassLibrary) + '.ValidarWebHttp()')
            RETURN .F.
        ENDIF

        IF toWebHttp.Class != 'WebHttp' THEN
            MESSAGEBOX([El parámetro 'toWebHttp' no es una instancia de la ] + ;
                [clase 'WebHttp'.], 0+16, JUSTSTEM(THIS.ClassLibrary) + ;
                '.ValidarWebHttp()')
            RETURN .F.
        ENDIF

        THIS.oWebHttp = toWebHttp
    ENDFUNC

    * ------------------------------------------------------------------------ *
    PROTECTED FUNCTION ValidarValidacion
        LPARAMETERS toValidacion

        IF PARAMETERS() < 1 THEN
            MESSAGEBOX('Muy pocos argumentos.', 0+16, ;
                JUSTSTEM(THIS.ClassLibrary) + '.ValidarValidacion()')
            RETURN .F.
        ENDIF

        IF VARTYPE(toValidacion) != 'O' THEN
            MESSAGEBOX([El parámetro 'toValidacion' debe ser de tipo objeto.], ;
                0+16, JUSTSTEM(THIS.ClassLibrary) + '.ValidarValidacion()')
            RETURN .F.
        ENDIF

        IF toValidacion.Class != 'Validacion' THEN
            MESSAGEBOX([El parámetro 'toValidacion' no es una instancia de la ] + ;
                [clase 'Validacion'.], 0+16, JUSTSTEM(THIS.ClassLibrary) + ;
                '.ValidarValidacion()')
            RETURN .F.
        ENDIF

        THIS.oValidacion = toValidacion
    ENDFUNC
ENDDEFINE