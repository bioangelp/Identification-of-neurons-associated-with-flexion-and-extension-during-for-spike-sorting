Documentación del Proyecto de Procesamiento y Análisis de Señales Neuronales

1. Descripción del Proyecto
    
    El sistema en MATLAB procesa, separa y analiza actividad neuronal para clasificar neuronas en movimientos de flexión y extensión. Automatiza el análisis de registros electrofisiológicos para identificar picos de señal y evaluar estadísticamente su comportamiento temporal.  
    
2. Instalación
    
    Descarga el archivo practica1, que incluye Axoscope, Waveclus y los experimentos. Abre MATLAB y añade todas las carpetas al camino actual. Para evitar el error donde MATLAB no encuentra la interfaz gráfica de waveclus al cambiar de directorio, debes ir a la pestaña Home, hacer clic en Set Path, elegir forzosamente la opción Add with Subfolders, seleccionar la carpeta contenedora del proyecto, guardar los cambios y cerrar la ventana. 
    
3. Extracción de Datos con AxoScope
    
    Abre Axoscope dentro de la carpeta de pCLAMP y selecciona el archivo que quieres abrir. Haz clic derecho y mueve los cursores a los límites de las señales. Presiona Control + C y selecciona copiar los datos al portapapeles como un archivo de texto de Axon entre los cursores 1 y 2. Asegúrate de marcar la opción para ajustar los datos para que el tiempo inicie en cero y dale a OK.
    
      
    
4. Procesamiento Inicial en MATLAB Corre el archivo axoscopedata.m en la consola. Sigue las instrucciones en pantalla y presiona Enter para pegar tu segmento de datos. Cuando el programa te pregunte el número de canal para la lectura, siempre debes ingresar el número 2. Si ingresas un número distinto, el código se rompe por exceder el límite de la matriz. Esto ocurre porque AxoScope solo copia dos columnas al portapapeles: el tiempo y los datos de tu canal. El número real de tu canal original de AxoScope solo lo debes introducir después, cuando el programa te lo pida para armar el texto con el nombre de tu archivo final.
    
      
    
5. Separación de Señales con Wave_clus El código axoscopedata.m creará una carpeta raw y te pedirá cargar ahí el archivo generado en wave_clus. Revisa las gráficas para confirmar que el programa separó bien las señales. La línea negra promedio debe mostrar la forma de un potencial de acción con un pico pronunciado y estrecho de 1 a 2 milisegundos. Las líneas de colores deben abrazar estrechamente a la línea negra formando una banda, sin verse como estática dispersa. Revisa el histograma inferior; un clúster de buena calidad debe tener cero o muy pocos disparos en intervalos menores a 3 milisegundos para respetar el periodo refractario biológico de la neurona. Deja marcadas las opciones de Accept en la parte inferior para conservar las neuronas. Presiona el botón para guardar los clústeres en wave_clus, espera a que salgan las letras naranjas en pantalla y presiona Enter en la consola de MATLAB para terminar de guardar y acomodar los archivos extraídos.
    
      
    
6. Análisis y Clasificación Automática Para el análisis final, ejecuta el programa principal mainneuronas.m. Este código descargará y normalizará los tiempos de las neuronas extraídas usando la función descargarNeuronas.m. Luego, agrupará las neuronas que pertenezcan al mismo registro mediante organizarNeuronas.m. Después, el archivo organizarFlexExt.m evaluará los tiempos para clasificar cada neurona; si el 58 por ciento o más de los disparos ocurren en la fase flexora o extensora, se le asigna esa clase, pero si no alcanza ese umbral, la neurona se elimina del análisis. Finalmente, el sistema genera una gráfica general mostrando el pool de neuronas, los canales de amplitud y los histogramas de frecuencia de disparos mediante graficarNeuronas.m.

### Funcion Acexcope

Cuando seleccionas un segmento temporal entre los cursores y lo copias al portapapeles teniendo todos esos canales en pantalla, AxoScope no exporta una tabla de solo dos columnas. Lo que realmente hace es exportar una matriz grande donde la primera columna es el tiempo y las siguientes columnas corresponden a todos los canales de datos que copiaste.

Por esta razón el código de MATLAB te pregunta por el número de canal y el número de flexión. Como copiaste información de muchos electrodos a la vez, el programa necesita que le indiques exactamente en qué columna de esa gran tabla quedó guardada la actividad eléctrica de la neurona que quieres aislar y en qué columna quedó el registro del movimiento físico de flexión. 

La tabla que copias al portapapeles siempre usa la primera columna para guardar la línea de tiempo. Si quieres analizar la pista que se llama IN 2 en tu pantalla, sus datos quedan guardados en la tercera columna de esa matriz. Al escribir un 3 en la primera pregunta, le dices a MATLAB exactamente de qué columna jalar la información para procesarla. En la segunda pregunta respondes con un 2 porque ese número solo funciona como una etiqueta de texto para armar el nombre del archivo final.

### Donde termina la fase flexora? 

Ese punto exacto donde la curva deja de descender y comienza a subir nuevamente indica el cambio de dirección del sensor, lo que marca físicamente el final de un movimiento y el inicio del otro.

La diferenciación de las pistas en el conjunto de datos se realiza mediante el análisis morfológico de las formas de onda. La actividad eléctrica celular se caracteriza por picos transitorios de alta frecuencia y baja amplitud, diferenciándose de los registros de desplazamiento mecánico, los cuales se manifiestan como trayectorias continuas y de baja frecuencia producto de la cinemática articular. Asimismo, las señales de sincronización temporal se identifican como funciones lineales de rampa, y las señales de control digital adoptan patrones de onda cuadrada. Esta distinción morfológica permite aislar el transductor de posición por un proceso de eliminación visual de las señales bioeléctricas y de estímulo, independientemente de la bitácora experimental.

Configuración de Parámetros de Entrada del Sistema. El script requiere la definición de tres variables para estructurar el procesamiento de los datos tabulares. El canal de lectura especifica la columna matricial de la señal eléctrica orientada al aislamiento y análisis de picos neuronales. El canal real corresponde al identificador físico original del transductor de origen, empleado estrictamente como metadato descriptivo en la nomenclatura de exportación para mantener la trazabilidad del archivo. Finalmente, el canal de flexión designa la pista analógica del sensor físico de movimiento, cuya función es establecer el umbral temporal de transición entre las fases cinemáticas para la normalización porcentual de la actividad neuronal.
### Temperatura:

A temperaturas bajas, el programa es muy permisivo y amontona diferentes señales y estática a la fuerza en un solo grupo gigante. Conforme subes la temperatura, le exiges al algoritmo que sea más estricto, provocando que ese grupo grande se divida en partes más pequeñas y precisas. Es normal que la señal cambie de cluster porque la temperatura más alta por fin le permitió al programa aislar esa forma de onda específica del resto de la basura con la que estaba mezclada.

No es mala suerte ni un error en tu extracción. Al observar tu imagen, la temperatura en la gráfica de la esquina inferior izquierda está en el nivel cero. Bajo esa configuración, el algoritmo es completamente permisivo y amontona toda la estática, ruido y señales reales en el mismo bloque, creando ese Clúster 1 inservible con 29 eventos superpuestos en menos de 3 milisegundos. Tu único error en esta etapa es no subir la temperatura haciendo clic derecho en esa gráfica para obligar al programa a ser estricto y separar la neurona limpia de la basura.

Para garantizar que tu flujo de trabajo esté impecable desde el inicio, sigue esta secuencia exacta.

1. En AxoScope, encierra tu señal con los cursores, presiona Control + C, selecciona copiar como texto de Axon entre cursores 1 y 2, marca el inicio de tiempo en 0 y acepta.

2. Pasa a la consola de MATLAB, teclea verCanales y presiona Enter para ubicar qué número de gráfica tiene tus picos eléctricos y cuál tiene la onda del movimiento físico.

3. Ejecuta axoscopedata, presiona Enter para descargar el portapapeles y responde a las preguntas usando el número del canal eléctrico para la lectura, el de la curva física para la flexión y tus etiquetas de bitácora.

4. Cuando salte la gráfica emergente, haz clic visualmente en el valle de la onda para marcar dónde termina la flexión y arranca la extensión.

5. Presiona Enter en la consola para que el script abra wave_clus, usa el botón Load Data para cargar el archivo .mat que se acaba de guardar en tu carpeta raw y sube la temperatura para separar tus clústeres.

Esta gráfica te muestra cómo el algoritmo agrupa los picos eléctricos dependiendo de qué tan estricto le pides que sea. El eje horizontal de abajo es la "temperatura", que realmente significa el nivel de exigencia: el cero a la izquierda es muy relajado y los números hacia la derecha son más estrictos. El eje vertical mide la cantidad de picos de señal que hay agrupados. Cada línea de color representa un grupo o clúster diferente que el programa está intentando armar.

El punto azul con las líneas punteadas te indica dónde estás ubicado ahora mismo. En tu imagen, estás casi pegado al cero. A esa temperatura tan baja, el programa es muy permisivo y mete toda tu señal, tanto las neuronas buenas como la estática, en un único grupo gigante representado por la línea roja que está hasta arriba.

  

Para separarlos, tienes que dar clic sobre la gráfica más hacia la derecha, en las zonas donde veas que nacen nuevas líneas. Al hacer clic en una temperatura más alta, por ejemplo cerca del 0.1 o 0.2, le exiges al programa que discrimine mejor. Notarás que la línea roja original baja drásticamente y las líneas morada y naranja se separan y se mantienen rectas de forma horizontal. Eso significa que el grupo de basura se rompió y tu neurona por fin quedó aislada en su propio canal. Tu objetivo al usar el modo manual es simplemente hacer clic en un punto del eje horizontal donde veas que esas líneas de colores secundarias estén estables y separadas, evitando irte tan a la derecha que todas las líneas se caigan a cero.
### Criterio de selección: 


Para saber si una neurona te servirá o no tienes que fijarte en:

Primero debes observar la silueta central de la onda. La línea negra promedio tiene que mostrar la forma clásica de un potencial de acción: un pico muy pronunciado y estrecho, ya sea hacia arriba o hacia abajo dependiendo del electrodo, que dura apenas entre 1 y 2 milisegundos antes de regresar a su línea base. Si la onda se ve muy ancha, lenta, o tiene múltiples picos erráticos, estás viendo ruido mecánico o eléctrico.

Segundo, tienes que fijarte en la dispersión de las líneas de colores. Todas las ondas individuales de color deben abrazar apretadamente a la línea negra central, formando una banda definida. Si las líneas de colores están dispersas por toda la cuadrícula formando una mancha gruesa o garabatos sin sentido, el programa está mezclando estática o combinó por accidente los disparos de dos neuronas diferentes en un mismo grupo.

Tercero y más importante, debes revisar los errores de tiempo en el histograma de la parte inferior. Por biología básica, una neurona real entra en un periodo refractario donde necesita tiempo para recargar sus canales iónicos antes de volver a activarse. Si el texto del clúster te indica que tienes decenas o cientos de disparos ocurriendo en un intervalo menor a 3 milisegundos, es físicamente imposible que vengan de la misma célula. Un clúster de buena calidad debe tener entre 0 y 2 disparos. 

### Cropped 

El código actual en MATLAB está diseñado para recibir un solo clic que divida todo el registro en exactamente dos etapas (una fase de flexión y una fase de extensión). 

Si le entregas al programa un segmento que contiene tres fases mecánicas (bajada, subida y bajada), el cálculo del porcentaje de tiempo se desfasará y la clasificación de las neuronas será errónea. 

Lo recomendable es ajustar tu selección original. 

Debes regresar a AxoScope y acercar tus cursores para copiar un fragmento más corto que contenga exclusivamente un ciclo limpio, aislando una sola bajada y una sola subida.

Esta gráfica te muestra cómo el algoritmo agrupa los picos eléctricos dependiendo de qué tan estricto le pides que sea. El eje horizontal de abajo es la "temperatura", que realmente significa el nivel de exigencia: el cero a la izquierda es muy relajado y los números hacia la derecha son más estrictos. El eje vertical mide la cantidad de picos de señal que hay agrupados. Cada línea de color representa un grupo o clúster diferente que el programa está intentando armar.

  

El punto azul con las líneas punteadas te indica dónde estás ubicado ahora mismo. En tu imagen, estás casi pegado al cero. A esa temperatura tan baja, el programa es muy permisivo y mete toda tu señal, tanto las neuronas buenas como la estática, en un único grupo gigante representado por la línea roja que está hasta arriba.

  

Para separarlos, tienes que dar clic sobre la gráfica más hacia la derecha, en las zonas donde veas que nacen nuevas líneas. Al hacer clic en una temperatura más alta, por ejemplo cerca del 0.1 o 0.2, le exiges al programa que discrimine mejor. Notarás que la línea roja original baja drásticamente y las líneas morada y naranja se separan y se mantienen rectas de forma horizontal. Eso significa que el grupo de basura se rompió y tu neurona por fin quedó aislada en su propio canal. Tu objetivo al usar el modo manual es simplemente hacer clic en un punto del eje horizontal donde veas que esas líneas de colores secundarias estén estables y separadas, evitando irte tan a la derecha que todas las líneas se caigan a cero.

### Cuanto necesita un cluster util?  Cantidad mínima de disparos 

Un clúster útil necesita al menos entre 20 y 30 disparos como mínimo absoluto para demostrar que hay un patrón biológico real, aunque lo ideal es que agrupe docenas o cientos de eventos dependiendo de cuántos segundos dure tu segmento. Si el programa solo atrapa 3, 6 o 15 picos en toda la ventana de tiempo, no estás viendo la actividad constante de una célula viva, sino simples fluctuaciones al azar, estática o errores del equipo que cruzaron el umbral de detección por accidente.

### DESCARTAR CANALES, selección del segmento de análisis

No debes descartar el canal completo solo porque esta primera extracción salió mal. Los registros en AxoScope son largos y es completamente normal que hayas agarrado un pedazo donde la neurona estaba en reposo o donde el electrodo solo captó ruido de fondo. En lugar de rendirte con ese canal, regresa a la ventana de AxoScope, desplázate a lo largo de esa misma pista y busca visualmente un momento diferente del experimento donde haya una ráfaga densa y evidente de picos rápidos. Selecciona ese nuevo fragmento lleno de actividad, cópialo y vuelve a correr el proceso en MATLAB.

#### DALE A ENTER 

Para que tu iteración 1 de 52 disparos aparezca por fin en la carpeta de `neuronas`, sigue estos pasos exactos:

1. Corre `axoscopedata.m` desde el principio, pega tu matriz, responde a las preguntas y selecciona tu límite de flexión en la gráfica.
    
2. Cuando se abra WaveClus y le des a Load data, ajusta tu temperatura hasta que aísles la neurona perfectamente limpia.
    
3. Dale clic a "Save clusters" en la interfaz **una sola vez**.
    
4. Ahora, ve a la consola negra de MATLAB. Ahí vas a ver el mensaje "Presione enter una vez guardados los clusters, despues de las letras naranjas". **Presiona la tecla Enter**.
    
5. En ese instante, tu programa retomará la ejecución, leerá el archivo de tiempos que WaveClus acaba de escupir, extraerá tu clúster válido y fabricará el archivo `n1r037c10i1.mat` directamente dentro de la carpeta `neuronas`. Aparecerá un mensaje confirmando la ruta de guardado.
    

Una vez que compruebes que tus archivos ya viven en la carpeta `neuronas`, el resto se hace solo. Simplemente abres `mainneuronas.m` y lo corres. Esto ejecutará la función de descarga que te abrirá una ventanita para seleccionar tus archivos, luego los mandará a clasificar para ver si cumplen la regla de tener el 60% de sus disparos en flexión o extensión, y finalmente te aventará la ventana con el raster plot y los histogramas completos.