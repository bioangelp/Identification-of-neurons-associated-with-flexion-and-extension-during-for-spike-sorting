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