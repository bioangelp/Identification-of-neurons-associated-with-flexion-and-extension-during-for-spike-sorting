function structClasificado = organizarFlexExt(neuronasOrdenadas)
    clc
    %nombre del structure final
    structClasificado = struct();
    fprintf("\t\tNeuronas clasificadas:\n")
    %bucle para recorrer todas las neuronas ya ordenadas
    for k = 1:length(neuronasOrdenadas)
        nombreActual = neuronasOrdenadas(k).nombre;
        datos = neuronasOrdenadas(k).disparos;
               
        %contar la cantidad de disparos totales
        total = length(datos);
        
        % Si la neurona no tiene datos
          if total == 0
              fprintf("Neurona <%s>: Sin datos \n", nombreActual);
              structClasificado(k).class = 'NA';
            continue;
          end
        
        %menor a mayor (ascend) maybe se puede quitar
        datosOrdenados = sort(datos, 'ascend');

        %disp(datosOrdenados)
        
        % Contar cuántos datos caen en flexión (0-porcentaje flex) y en extensión (porcentaje flex-100)
        %disp(neuronasOrdenadas(k).flexporcent)
        cuentaFlex = sum(datosOrdenados >= 0 & datosOrdenados <= neuronasOrdenadas(k).flexporcent);
        cuentaExt  = sum(datosOrdenados > neuronasOrdenadas(k).flexporcent & datosOrdenados <= 100);
        
        %porcentajes 
        porcentajeFlex = (cuentaFlex / total) * 100;
        porcentajeExt  = (cuentaExt / total) * 100;
        
        %{
        disp("Total de datos: " + total);
        disp("Flexión: " + porcentajeFlex + "%");
        disp("Extensión: " + porcentajeExt + "%");      
        %}

        % Clasificacion flex  ext o NA en base a 60 +-2% o mas de disparos
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
            % fprintf("Se elimino la neurona <%s> ya que no alcanza el umbral del 60%%.\n", nombreActual);
            %dis-p("Se elimino la neurona ya que no alcanza el umbral del 60%.");

            structClasificado(k).nombre = nombreActual;
            structClasificado(k).tiempos = datosOrdenados;
            structClasificado(k).class = 'NA';
            
        end
        disp("Neurona " + structClasificado(k).nombre + ": " + structClasificado(k).class)
    end
end