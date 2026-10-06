function graficarNeuronas(structClasificado, flexion, extension, tiempo, umbral)
    
    %% DATOS
    % separando las neuronas válidas en dos listas según su clase
    contadorFlex = 0;
    contadorExt = 0;
    datosFlex = struct('nombre', {}, 'tiempos', {});
    datosExt = struct('nombre', {}, 'tiempos', {});

    % Bucle para clasificar las neuronas
    for k = 1:length(structClasificado)
        if strcmp(structClasificado(k).class, 'flexion')
            contadorFlex = contadorFlex + 1;
            datosFlex(contadorFlex).nombre = structClasificado(k).nombre;
            datosFlex(contadorFlex).tiempos = structClasificado(k).tiempos;
        elseif strcmp(structClasificado(k).class, 'extension')
            contadorExt = contadorExt + 1;
            datosExt(contadorExt).nombre = structClasificado(k).nombre;
            datosExt(contadorExt).tiempos = structClasificado(k).tiempos;
        end
    end %for

    % primero Flexoras, luego Extensoras
    datosOrdenados = [datosFlex, datosExt];
    numNeuronas = length(datosOrdenados);

    if numNeuronas == 0 %proteccion
        disp("No hay neuronas válidas para graficar (Flexión o Extensión).");
        return;
    end

    %% FIGURA Y CONFIGURACION
    figure('Name', 'Análisis de Neuronas', 'MenuBar', 'none', "units", "normalized",'Position', [0, 0, 1, 1], 'Color', [0.90, 0.90, 0.90]);
    
    % Definición de colores (RGB)
    colorFlex = [0.4 0.2 0.6];   % Morado
    colorExt  = [1.0 0.5 0.0];   % Naranja
    colorLine = [0.5 0.5 0.5];   % Gris para la línea del 60%


    %% RASTER PLOT 
    subplot(5, 1, 1);
    hold on;
    
    if contadorFlex > 0
        patch([0, 100, 100, 0], [0, 0, contadorFlex + 0.5, contadorFlex + 0.5], ...
              [1.0, 0.5, 0.0], 'FaceAlpha', 0.15, 'EdgeColor', 'none');
    end

    if contadorExt > 0
        patch([0, 100, 100, 0], [contadorFlex + 0.5, contadorFlex + 0.5, numNeuronas + 0.99, numNeuronas + 0.99], ...
              [0.55, 0.25, 0.75], 'FaceAlpha', 0.15, 'EdgeColor', 'none');
    end
    
    for i = 1:numNeuronas
        tiempos = datosOrdenados(i).tiempos;
        
        % Determinar el color según la clase
        if i <= length(datosFlex)
            colorActual = colorFlex;
        else
            colorActual = colorExt;
        end
        
        % Graficar cada disparo como una línea vertical
        for t = 1:length(tiempos)
            plot([tiempos(t), tiempos(t)], [i-0.4, i+0.4], 'Color', colorActual, 'LineWidth', 1.5);
        end
    end % for
    
    % Línea vertical del fin de flexion
    xline(umbral, '--', 'Color', colorLine, 'LineWidth', 2);
    
    ylim([0, numNeuronas+1]);
    xlim([0, 100]);
    ylabel('Neuronas');
    xlabel('Unidades Arbitrarias (UA) - Tiempo normalizado');
    title('Pool de Neuronas Clasificadas');
    grid on;
    box on;
    hold off;

    %% FLEXIÓN 
    subplot(5, 1, 2);
    set(gca, 'Color', [1.0, 0.5, 0.0, 0.2]);
    hold on;
    
    plot(tiempo, flexion, '-','Color',colorFlex, 'LineWidth', 1.5);
    
    xline(umbral, '--', 'Color', colorLine, 'LineWidth', 2);
    ylabel('Amplitud (mV)');
    xlabel('Unidades Arbitrarias (UA) - Tiempo normalizado');
    title('Canal de flexión');
    legend('Flexión', 'Location', 'northeast');
    xlim([0, 100]);
    grid on;
    box on;
    hold off;

    %% EXTENSIÓN 
    subplot(5, 1, 3);
    
    set(gca, 'Color', [0.55, 0.25, 0.75, 0.08]);
    hold on;
  
    plot(tiempo, extension, '-','Color', colorExt, 'LineWidth', 1.5);
    
    xline(umbral, '--', 'Color', colorLine, 'LineWidth', 2);
    ylabel('Amplitud (mV)');
    xlabel('Unidades Arbitrarias (UA) - Tiempo normalizado');
    title('Canal de extensión');
    legend('Extensión', 'Location', 'northwest');
    xlim([0, 100]);
    ylim([-0.5,2])
    grid on;
    box on;
    hold off;

    %% HISTOGRAMA FLEXIÓN
    subplot(5, 1, 4); 
    set(gca, 'Color', [1.0, 0.5, 0.0, 0.2]);
    hold on;
    
    todosLosTiemposFlex = [];
    for i = 1:length(datosFlex)
        todosLosTiemposFlex = [todosLosTiemposFlex; datosFlex(i).tiempos];
    end 
    
    if ~isempty(todosLosTiemposFlex)
        histogram(todosLosTiemposFlex, 20, 'FaceColor', colorFlex, 'EdgeColor', 'k', 'FaceAlpha', 0.7);
    end
    
    xline(umbral, '--', 'Color', colorLine, 'LineWidth', 2);
    xlabel('Unidades Arbitrarias (UA) - Tiempo normalizado');
    ylabel('Frecuencia de Disparos');
    title('Histograma Flexión');
    xlim([0, 100]);
    grid on;
    box on;
    hold off;

    %% HISTOGRAMA EXTENSIÓN
    subplot(5, 1, 5); 
    set(gca, 'Color', [0.55, 0.25, 0.75, 0.08]);
    hold on;
    
    todosLosTiemposExt = [];
    for i = 1:length(datosExt)
        todosLosTiemposExt = [todosLosTiemposExt; datosExt(i).tiempos];
    end 
    
    if ~isempty(todosLosTiemposExt)
        histogram(todosLosTiemposExt, 20, 'FaceColor', colorExt, 'EdgeColor', 'k', 'FaceAlpha', 0.7);
    end
    
    xline(umbral, '--', 'Color', colorLine, 'LineWidth', 2);
    xlabel('Unidades Arbitrarias (UA) - Tiempo normalizado');
    ylabel('Frecuencia de Disparos');
    title('Histograma Extension');
    xlim([0, 100]);
    grid on;
    box on;
    hold off;

    %%titulo
    sgtitle('Analisis de actividad de neuronas flexoras y extensoras', 'FontSize', 14, 'FontWeight', 'bold');

end %funcn

