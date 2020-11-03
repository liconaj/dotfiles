# Guardar
`<lider> + s`

# Cerrar
`C-Down`

# Abrir en el directorio actual
`C-Up`

# Formas de moverse (Normal)
`b`   -> Palabra
`w`   -> Palabra hacia atrás
`0`   -> Inicio de la línea
`$`   -> Final de la línea
`C-e` -> Scroll
`C-y` -> Scorll

# Seleccionar texto (Normal)
`v`   -> Modo viual

# Copiar y pegar
`<lider> + d` -> cortar
`<lider> + p` -> pegar
`<lider> + y` -> copiar


# Comandos en modo editar
`C-o`         -> Insertar comando en modo normal
`C-w`         -> Eliminar palabra a la izquierda
`C-o D`       -> Elimina todo a la derecha del cursor
`C-u`         -> Elimina todo a la izquierda del cursor
`C-h`         -> Eliminar hacia atrás
`C-j`         -> Enter
`C-t`         -> Indentar línea actual
`C-d`         -> Desindentar línea actual
`C-k {1} [2]` -> Insertar carácteres especiales (:digraphs)
`C-p`         -> Autocompletar
`C-n`         -> Autocompletar
`C-Left`      -> Moverse una palabra atrás
`C-Right`     -> Moverse una palabra adelante

`M-{comando}` -> Insertar comando y entrar al modo normal
`M-b`         -> Moverse una palabra atrás y modo normal
`M-w`         -> Moverse una palabra adelante y modo normal

# Cambiar entre modos
`C-x`         -> Cambiar entre modos

# Comandos en modo normal
`w`           -> Mover cursor palabra adelante
`b`           -> Mover cursor palabra atrás
`f {char}`    -> Poner cursor en caracter encontrado adelante
`F {char}`    -> Poner cursor en caracter encontrado atrás
`r {char}`    -> Reemplazar caracter en cursor por el puesto
`a`           -> Cursor adelante y modo insertar
`A `          -> Cursor al final de línea y modo insertar
`i`           -> Cursor atrás y modo insertar
`I`           -> Cursor al inicio de línia y modo insertar
`c {mov}`     -> Eliminar según movimiento y modo insertar

# Ventanas (Normal)
`C-w v`       -> Dividir verticalmente :sp <archivo>
`C-w s`       -> Dividir horizontalmente :vs <archivo>
`C-w c`       -> Cerrar ventana :close
`C-w >`       -> Aumentar tamaño horizontal
`C-w <`       -> Disminuir tamaño horizontal
`C-w + `      -> Aumentar tamaño vertical
`C-w -`       -> Disminuir tamaño vertical
`C-w =`       -> Reiniciar tamaño
`C-w {k,Up}`  -> Cambiar foco a ventana arriba
`C-w {j,↓}`   -> Cambiar foco a ventana abajo
`C-w {h,←}`   -> Cambiar foco a ventana izquierda
`C-w {l,→} `  -> Cambiar foco a ventana derecha


# Buffers (Normal)
`C-o`         -> Cambiar de buffer
`<lider>l`    -> Buffer siguiente
`<lider>j `   -> Buffer anterior
`<lider>q`    -> Cerrar buffer actual
`:ls`         -> Listar
`:buffers`    -> Listar
`:b <numero>` -> Cambiar a buffer

# Pestañas 
`vim -p <archivo1> <archivo2>`
`:tabnew`         -> Añadir pestaña
`:tabnew <file>`  -> Abrir archivo en nueva pestaña
`:tabclose`       -> Cierra pestaña
`C-RePag`         -> Cambiar a pestaña anterior
`C-AvPag`         -> Cambiar a pestaña siguiente
`gt`              -> Ir a siguiente pestaña
`gT`              -> Ir a pestaña anterior

# Snippets and Plugins
`:PlugInstall`    -> Instalar plugins en el archivo plugins

# NerdTREE
`m`   -> Filesystem menu
`a`   -> Add file or folder with /

# Running files
`F4`      -> Run actual script
`F5`      -> Run python script
`F6`      -> Run nodejs script
`F7`      -> Compile and run *.bas file
`C-F7`    -> Just run *.bas file

# Buscar
`/<termino> `     -> Buscar hacia adelante
`?<termino>`      -> Buscar hacia atrás
`n`               -> Siguiente resultado
`S-n`             -> Anterior resultado

# Buscar y reemplazar
`:rango s/patron/reemplazo/[cgil]`        -> Sintaxis

## rango
    - numero de linea
    - `inicio,fin` de la linea inicio a la linea fin
    - `.` para la linea actual
    - `$` ultima linea del archivo
    - `%` todo el archivo

## Opciones [cgil]
    - `c` confirmar cada sustitución
    - `g` reemplaza rodas las ocurrencias, sino solo cambiara la primera
    - `i` no distingue entre mayúsculas y minúsculas
    - `l` diferencia entre mayúsculas y minúsculas

## Ejemlos:
    - `:5,10s/casa/caso/g` " Reemplaza casa por caso entre lineas 5 y 10
    - `:%s/casa/caso/g` " Lo mismo que arriba pero en todo el documento

## Terminal
`F2`        -> Abrir terminal abajo
`kj`        -> Cerrar terminal
`ESC`       -> Cambiar a modo normal
`C-x`       -> Cambiar foco

