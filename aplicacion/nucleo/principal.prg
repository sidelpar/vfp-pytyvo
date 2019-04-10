* Copyright (C) 2000-2019 por José Acuña. Todos los derechos reservados.
CLEAR

* Se asegura de que el administrador de proyectos está cerrado, o podemos
* entrar en conflicto al intentar presionar las teclas de acceso directo
* (hot-keys).
DEACTIVATE WINDOW 'Project Manager'

* Todas las variables públicas se liberarán tan pronto como se cree el objeto
* aplicación.
PUBLIC gcOldTalk, goUtiles, goEstructuraTabla, goWebHttp, goValidacion, ;
       goRepositorioConfiguracion, goConfiguracion, goUsuario, ;
       goPermisoUsuario, goAplicacion

IF SET('TALK') = 'ON' THEN
    SET TALK OFF
    gcOldTalk = 'ON'
ELSE
    gcOldTalk = 'OFF'
ENDIF

* Carga todas las clases que se utilizarán en el sistema.
DO biblioteca.prg

goUtiles = CREATEOBJECT('Utiles')
goEstructuraTabla = CREATEOBJECT('EstructuraTabla')
goWebHttp = CREATEOBJECT('WebHttp')
goValidacion = CREATEOBJECT('Validacion')
goRepositorioConfiguracion = CREATEOBJECT('RepositorioConfiguracion')

IF VARTYPE(goRepositorioConfiguracion) == 'O' THEN
    goConfiguracion = goRepositorioConfiguracion.ObtenerConfiguracion()

    IF VARTYPE(goConfiguracion) == 'O' THEN
        DO FORM frm_inicio_sesion
        READ EVENTS
    ELSE
        MESSAGEBOX('No se pudo cargar la configuración inicial.', 0+16, ;
            LOWER(PROGRAM()) + '.Init()')
    ENDIF
ELSE
    MESSAGEBOX([No se pudo instanciar la clase 'RepositorioConfiguracion'.], ;
        0+16, LOWER(PROGRAM()) + '.Init()')
ENDIF

IF VARTYPE(goUsuario) == 'O' THEN
    DO ObtenerPermisoUsuario

    IF VARTYPE(goUtiles) == 'O' THEN
        IF VARTYPE(goPermisoUsuario) == 'O' THEN
            goAplicacion = CREATEOBJECT( ;
                'Aplicacion', ;
                goUsuario, ;
                goPermisoUsuario, ;
                goConfiguracion, ;
                goUtiles, ;
                goEstructuraTabla, ;
                goWebHttp, ;
                goValidacion ;
            )
        ENDIF
    ENDIF

    IF VARTYPE(goAplicacion) == 'O' THEN
        DO menu_principal.mpr
    ELSE
        MESSAGEBOX([No se pudo instanciar la clase 'Aplicacion'.], 0+16, ;
            LOWER(PROGRAM()) + '.Init()')
    ENDIF
ENDIF

CLEAR DLLS
RELEASE ALL EXTENDED
CLEAR ALL

* --------------------------------------------------------------------------- *
PROCEDURE ObtenerPermisoUsuario
    LOCAL loConexion, loPermisoUsuario
    loConexion = CREATEOBJECT('Conexion', goConfiguracion.ObtenerRutaDatos())

    IF VARTYPE(loConexion) == 'O' THEN
        loConexion.AgregarTabla(CREATEOBJECT('Tabla', 'usercfg', 'permisos'))

        loPermisoUsuario = CREATEOBJECT( ;
            'PermisoUsuario', ;
            loConexion, ;
            goUsuario.ObtenerCodigo() ;
        )

        IF VARTYPE(loPermisoUsuario) == 'O' THEN
            goPermisoUsuario = loPermisoUsuario
        ELSE
            MESSAGEBOX('No se pudieron cargar los permisos del usuario.', ;
                0+16, LOWER(PROGRAM(0)) + '.ObtenerPermisoUsuario()')
        ENDIF
    ELSE
        MESSAGEBOX('Error de conectividad.', 0+16, ;
            LOWER(PROGRAM(0)) + '.ObtenerPermisoUsuario()')
    ENDIF
ENDPROC