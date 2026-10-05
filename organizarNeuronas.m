function [neuronasOrdenadas, neuronasSimples] = organizarNeuronas(estructuraNeuronas)
    datosAgrupados = struct(); 
    porcentajeDeFlexion = struct();
    iteracionParaMedia = struct();
    for k = 1:length(estructuraNeuronas)
        %disp(length(estructuraNeuronas))
        nombreActual = estructuraNeuronas(k).nombre;
        tiemposDeActualidad = estructuraNeuronas(k).disparos;
        
        
        % disp(nombreActual)
        % disp(porcentajeDeFlexion)

        % buscar donde esta la iteracion
        posicionDelRegistroDondeSeMarcaLaIteracion = strfind(nombreActual, 'i');

        if isempty(posicionDelRegistroDondeSeMarcaLaIteracion)
            nombreDeLaNeuronaRecortadoSinLaIteracion = nombreActual; 
        else
            nombreDeLaNeuronaRecortadoSinLaIteracion = nombreActual(1:posicionDelRegistroDondeSeMarcaLaIteracion(end)-1); 
        end

        %disp(nombreDeLaNeuronaRecortadoSinLaIteracion)

        % cONFIRMA QUE LA NEURONA YA EXISTE 
        if isfield(datosAgrupados, nombreDeLaNeuronaRecortadoSinLaIteracion)
            datosAgrupados.(nombreDeLaNeuronaRecortadoSinLaIteracion) = [datosAgrupados.(nombreDeLaNeuronaRecortadoSinLaIteracion); tiemposDeActualidad];
            porcentajeDeFlexion.(nombreDeLaNeuronaRecortadoSinLaIteracion) = porcentajeDeFlexion.(nombreDeLaNeuronaRecortadoSinLaIteracion) + estructuraNeuronas(k).flexion;
            iteracionParaMedia.(nombreDeLaNeuronaRecortadoSinLaIteracion) = iteracionParaMedia.(nombreDeLaNeuronaRecortadoSinLaIteracion) + 1;
        else
            datosAgrupados.(nombreDeLaNeuronaRecortadoSinLaIteracion) = tiemposDeActualidad;
            porcentajeDeFlexion.(nombreDeLaNeuronaRecortadoSinLaIteracion) = estructuraNeuronas(k).flexion;
            iteracionParaMedia.(nombreDeLaNeuronaRecortadoSinLaIteracion) = 1;
        end
        %disp(datosAgrupados)
    end 
    %disp(porcentajeDeFlexion)
    listaDeNombresDeLaNeuronaRecortadoSinLaIteracion = fieldnames(datosAgrupados);
    neuronasOrdenadas = struct();
    neuronasSimples = struct();

    %crea dos registors

    for k = 1:length(listaDeNombresDeLaNeuronaRecortadoSinLaIteracion)
        nombreDeLaNeuronaEnEsteCiclo = listaDeNombresDeLaNeuronaRecortadoSinLaIteracion{k};
        tiemposTotales = datosAgrupados.(nombreDeLaNeuronaEnEsteCiclo);
        flexPorciento = porcentajeDeFlexion.(nombreDeLaNeuronaEnEsteCiclo) / iteracionParaMedia.(nombreDeLaNeuronaEnEsteCiclo);
        %ordenadas
        neuronasOrdenadas(k).nombre = nombreDeLaNeuronaEnEsteCiclo;
        neuronasOrdenadas(k).disparos = sort(tiemposTotales);
        neuronasOrdenadas(k).flexporcent = flexPorciento;
        %simples
        neuronasSimples(k).nombre = nombreDeLaNeuronaEnEsteCiclo;
        neuronasSimples(k).disparos = tiemposTotales;
        neuronasSimples(k).flexporcent = flexPorciento;
    end
    % guardar 
    
    %sacar direccion de programa
    [localizacionDePrograma, ~, ~] = fileparts(mfilename('fullpath'));
    resultadosAgrupadosSubfolder = fullfile(localizacionDePrograma, "resultados_agrupados");
    if ~exist(resultadosAgrupadosSubfolder, 'dir')
        mkdir('resultados_agrupados');
    end
    direccionCarpeta = fullfile(localizacionDePrograma, "resultados_agrupados");
    cd(direccionCarpeta)
    save neuronasAgrupadas.mat neuronasSimples neuronasOrdenadas
    cd(localizacionDePrograma)

    %{
    nombreRegistro = neuronasOrdenadas(1).nombre;
    rutaOrdenadas = ['resultados_agrupados\', nombreRegistro, '_neuronas_ordenadas.mat'];
    rutaSimples = ['resultados_agrupados\', nombreRegistro, '_neuronas_simples.mat'];
    save(rutaOrdenadas, 'neuronasOrdenadas');
    save(rutaSimples, 'neuronasSimples');
    cd(localizacionDePrograma)
    %}

end
