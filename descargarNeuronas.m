function neuronasStruct = descargarNeuronas()

    neuronasStruct = struct();
    disp("Cargue todos los archivos de las neuronas")

    [localizacionDePrograma, ~, ~] = fileparts(mfilename('fullpath'));
    neuronaFolder = fullfile(localizacionDePrograma, "neuronas/");
    cd(neuronaFolder)
    [nombreArchivo, direccion] = uigetfile('*.mat', "MultiSelect","on");
    cd(localizacionDePrograma)
    %disp(direccion)
    %disp(nombreArchivo)
    if isequal(nombreArchivo,0) || isequal(direccion, 0)
        neuronasStruct = 0;
        return 
    end
    contador = 1;
    for archivo = nombreArchivo
        if isequal(length(archivo{1}), 14)
            if ~(isequal(archivo{1}(1), 'n') && isequal(archivo{1}(3), 'r') && isequal(archivo{1}(7), 'c') && isequal(archivo{1}(9), 'i'))
                warning("El archivo %s no tiene el formato esperado, por lo tanto no se cargará para procesarla.", archivo{1});
                continue
            end
       
        elseif isequal(length(archivo{1}), 15)
            if ~(isequal(archivo{1}(1), 'n') && isequal(archivo{1}(4), 'r') && isequal(archivo{1}(8), 'c') && isequal(archivo{1}(10), 'i'))
                warning("El archivo %s no tiene el formato esperado, por lo tanto no se cargará para procesarla.", archivo{1});
                continue
            end
        end
        nombreDeNeurona = archivo{1}(1:end-4);
        rutaArchivo = fullfile(direccion, archivo{1});
        registroNeurona = load(rutaArchivo);
        %disp(registroNeurona)
        tiempoRegistro = registroNeurona.tiempoDeRegistro;
        %Normalizando el tiempo de las neuroans
        tiempos = registroNeurona.tiemposNeuronaSegundos * 100 / tiempoRegistro;
        %disp(registroNeurona.tiemposNeuronaSegundos)
        neuronasStruct(contador).nombre = nombreDeNeurona;
        neuronasStruct(contador).disparos = tiempos;
        contador = contador + 1;
    end

    %disp(neuronasStruct)
    
end
