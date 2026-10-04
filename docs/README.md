# Documentación del Proyecto de Procesamiento y Análisis de Señales Neuronales

Sistema en MATLAB para procesar, separar y analizar actividad neuronal con el fin de clasificar neuronas en movimientos de flexión y extensión.
## Índice General

Descripción del Proyecto

Guías de Instalación y Uso
## 1. Descripción del Proyecto

El sistema automatiza el análisis de registros electrofisiológicos para identificar y clasificar neuronas asociadas con movimientos motores específicos. Está diseñado para optimizar el procesamiento de datos crudos, la ejecución de picos de señal y la posterior evaluación estadística de su comportamiento temporal.

## 2. Guías de Instalación y Uso

2. Selecciona el archivo que quieres abrir 
![[Pasted image 20260930213348.png]]

3. Haz clic derecho y selecciona

4. Mueve los cursores a los límites de las señales.

![[Pasted image 20260930213419.png]]

5. Presiona _Control + C_ y selecciona _copy data to clipboard as an Axon text file, between cursors 1 and 2_, y _shift data to start time 0_, después dale a _OK_

6. Corre el archivo `axoscopedata` y dale Enter

7. Solo sigues las instrucciones, un ejemplo sería: Enter, 047, 2, 3, Enter

8. El error ocurre porque la variable registro tiene únicamente dos columnas, tal como se muestra en tu espacio de trabajo con el valor 494637x2 double. Al ingresar un 4 en la variable numeroCanal, le estás pidiendo a MATLAB que extraiga una cuarta columna que no existe al ejecutar la línea 19, lo que rompe el código por exceder el límite de la matriz. Esto pasa porque cuando copias un segmento de datos desde AxoScope hacia el portapapeles, el programa solo te entrega la columna correspondiente al tiempo y la columna del canal específico que tenías seleccionado. Para solucionarlo, siempre debes ingresar el número 2 en la pregunta del número de canal para la lectura, ya que los datos numéricos de tu neurona siempre van a caer en esa segunda columna al pegarlos en MATLAB. El identificador de tu canal original de AxoScope solo lo debes introducir cuando el programa te pregunte por el numeroCanalReal, ya que ese dato sirve exclusivamente para armar el texto con el nombre de tu archivo final.

```
Index in position 2 exceeds array bounds. Index must not exceed 2.
	Error in axoscopedata (line 19)
	data = registro(:,numeroCanal);
```


![[Pasted image 20260930220726.png]]

 Es vital realizar el paso de añadir las carpetas correctamente para evitar el error donde MATLAB no encuentra `wave_clus.fig` (`assets/error-waveclus.png`). Este problema ocurre porque el código cambia de directorio hacia la carpeta `raw` para guardar los archivos, por lo que MATLAB pierde de vista dónde está la interfaz gráfica de wave_clus. Si intentas usar el botón de solución automática que sugiere MATLAB, el programa solo añade la carpeta principal y no las subcarpetas, dejándote atrapado en un bucle infinito de errores. Para solucionar esto permanentemente, debes ir a la pestaña _Home_ en la parte superior, hacer clic en _Set Path_, elegir forzosamente la opción _Add with Subfolders_, seleccionar la carpeta contenedora de `wave_clus`, guardar los cambios y cerrar la ventana. 

![[Pasted image 20260930213118.png]]

![[Pasted image 20260930213145.png]]

![[Pasted image 20260930213219.png]]


![[Pasted image 20260930213236.png]]


9. Revisa las gráficas para confirmar que el programa separó bien las señales de las neuronas. Tienes que fijarte que la línea negra gruesa que pasa por el medio tenga una forma consistente y que las líneas de colores no estén totalmente desordenadas como si fueran estática. En la fila de abajo están los histogramas que miden el tiempo de descanso entre cada disparo de la neurona. Como las neuronas reales necesitan una fracción de tiempo para recargarse, debes revisar el texto sobre estas gráficas; el clúster 4 indica tener solo 1 disparo en menos de 3 milisegundos y el clúster 5 tiene 0. Estos números son excelentes e indican que efectivamente son neuronas y no ruido.

Para saber si una neurona te servirá o no tienes que fijarte en: 

Primero debes observar la silueta central de la onda. La línea negra promedio tiene que mostrar la forma clásica de un potencial de acción: un pico muy pronunciado y estrecho, ya sea hacia arriba o hacia abajo dependiendo del electrodo, que dura apenas entre 1 y 2 milisegundos antes de regresar a su línea base. Si la onda se ve muy ancha, lenta, o tiene múltiples picos erráticos, estás viendo ruido mecánico o eléctrico.

Segundo, tienes que fijarte en la dispersión de las líneas de colores. Todas las ondas individuales de color deben abrazar apretadamente a la línea negra central, formando una banda definida. Si las líneas de colores están dispersas por toda la cuadrícula formando una mancha gruesa o garabatos sin sentido, el programa está mezclando estática o combinó por accidente los disparos de dos neuronas diferentes en un mismo grupo.

Tercero y más importante, debes revisar los errores de tiempo en el histograma de la parte inferior. Por biología básica, una neurona real entra en un periodo refractario donde necesita tiempo para recargar sus canales iónicos antes de volver a activarse. Si el texto del clúster te indica que tienes decenas o cientos de disparos ocurriendo en un intervalo menor a 3 milisegundos, es físicamente imposible que vengan de la misma célula. Un clúster de buena calidad debe tener cero o un número extremadamente bajo de eventos en esa categoría.


10. Deja marcadas las opciones de Accept en la parte inferior de cada clúster para indicarle al programa que conservas ambas neuronas. 

![[Pasted image 20260930212654.png]]

11. Ahora solo regresa a la ventana principal de wave_clus, presiona el botón para guardar los clústeres y espera a que salgan las letras naranjas en la pantalla. 


![[Pasted image 20260930212729.png]]

12. Una vez que las veas, ve a la consola de MATLAB y presiona Enter para que tu código cierre la interfaz y termine de acomodar los archivos extraídos en tu carpeta de neuronas.

![[Pasted image 20260930212825.png]]

13. Ve a `descargarNeuronas.m` y dale a correr. El resultado aparecerá en el workspace a la derecha. Si le das doble clic izquierdo y luego dos clics izquierdos en la columna de disparos, puedes verlo ya normalizado.

 ![[Pasted image 20260930214851.png]]
 
 ![[Pasted image 20260930214913.png]]
 
![[Pasted image 20260930214927.png]]