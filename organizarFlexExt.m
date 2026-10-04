function structClasificado = organizarFlexExt(neuronasOrdenadas)

    %nombre del structure final
    structClasificado = struct();
    
    %bucle para recorrer todas las neuronas ya ordenadas
    for k = 1:length(neuronasOrdenadas)
        nombreActual = neuronasOrdenadas(k).nombre;
        datos = neuronasOrdenadas(k).disparos;
        
        %que neurona estamos checando
        disp("Neurona: " + nombreActual);
       
        %contar la cantidad de disparos totales
        total = length(datos);
        
        % Si la neurona no tiene datos
          if total == 0
              fprintf("Neurona <%s>: Sin datos \n", nombreActual);
              structClasificado.(nombreActual).tiempos = [];
              structClasificado.(nombreActual).class = 'NA';
            continue;
          end
        
        %menor a mayor (ascend) maybe se puede quitar
        datosOrdenados = sort(datos, 'ascend');

        %disp(datosOrdenados)
        
        % Contar cuántos datos caen en flexión (0-60) y en extensión (60-100)
        cuentaFlex = sum(datosOrdenados >= 0 & datosOrdenados <= 60);
        cuentaExt  = sum(datosOrdenados > 60 & datosOrdenados <= 100);
        
        %porcentajes 
        porcentajeFlex = (cuentaFlex / total) * 100;
        porcentajeExt  = (cuentaExt / total) * 100;
        
        %
        disp("Total de datos: " + total);
        disp("Flexión: " + porcentajeFlex + "%");
        disp("Extensión: " + porcentajeExt + "%");      
        %}

        % Clasificacion flex  ext o NA en base a 60% o mas de disparos
        if porcentajeFlex >= 58    
            structClasificado(k).nombre = nombreActual;
            structClasificado(k).tiempos = datosOrdenados;
            structClasificado(k).class = 'flexion';
            
        elseif porcentajeExt >= 58
            structClasificado(k).nombre = nombreActual;
            structClasificado(k).tiempos = datosOrdenados;
            structClasificado(k).class = 'extension';
            
        else

            % Si no alcanza el 60% en ninguna fase, se asigna NA
            fprintf("Se elimino la neurona <%s> ya que no alcanza el umbral del 60%%.\n", nombreActual);
            %dis-p("Se elimino la neurona ya que no alcanza el umbral del 60%.");

            structClasificado(k).nombre = nombreActual;
            structClasificado(k).tiempos = datosOrdenados;
            structClasificado(k).class = 'NA';
            
        end
    end
end