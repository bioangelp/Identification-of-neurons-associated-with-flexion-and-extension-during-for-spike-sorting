function graficarNeuronas(structClasificado)
    % Separar neuronas por clase 
    clases = {structClasificado.class};
    flexoras = structClasificado(strcmp(clases, 'flexion'));
    extensoras = structClasificado(strcmp(clases, 'extension'));
    
    % Unir poniendo flexoras primero para que queden abajo en la gráfica
    neuronasGraficar = [flexoras, extensoras];
    cantidad = length(neuronasGraficar);
    
    if cantidad == 0
        disp('No hay neuronas clasificadas para graficar.');
        return;
    end
    
    % Figura de raster plot
    figure('Name', 'Raster Plot de Neuronas');
    hold on;
    for i = 1:cantidad
        tiempos = neuronasGraficar(i).tiempos;
        plot(tiempos, i * ones(length(tiempos), 1), 'k|', 'MarkerSize', 10);
    end
    hold off;
    
    ylim([0, cantidad + 1]);
    xlim([0, 100]);
    yticks(1:cantidad);
    yticklabels({neuronasGraficar.nombre});
    xlabel('Tiempo normalizado (%)');
    ylabel('Neuronas');
    title('Disparos (Abajo: Flexoras, Arriba: Extensoras)');
    
    % Figura de histogramas
    figure('Name', 'Histogramas de Frecuencia');
    
    subplot(2, 1, 1);
    hold on;
    for i = 1:length(flexoras)
        histogram(flexoras(i).tiempos, 20, 'BinLimits', [0, 100]);
    end
    hold off;
    title('Frecuencia en Neuronas Flexoras');
    xlabel('Tiempo normalizado (%)');
    ylabel('Disparos');
    
    subplot(2, 1, 2);
    hold on;
    for i = 1:length(extensoras)
        histogram(extensoras(i).tiempos, 20, 'BinLimits', [0, 100]);
    end
    hold off;
    title('Frecuencia en Neuronas Extensoras');
    xlabel('Tiempo normalizado (%)');
    ylabel('Disparos');
end