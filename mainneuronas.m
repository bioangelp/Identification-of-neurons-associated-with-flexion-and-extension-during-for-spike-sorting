
%{
%
% Analisis de neuronas
% main
% Programado por:
%    Christopher Manzo Hernandez
%    Emiliano Marquez Fregoso
%    Sasha Abigail Lopez Garcia
%    Angel Paramo Quirarte  
%   
%}

%clear;
clc
structDeNeuronas = descargarNeuronas();
if structDeNeuronas(1).nombre== 0
    disp('No se cargaron archivos.');
    return
end

%% Funcion de angel:

%{
    -tomar el struct de neuronas 
    -unir a las neuronas que sean iguales basados en el registro, canal e
    iteracion
    -devolver un struct que contenga a las neuronas organizadas
%}

[neuronasOrdenadas, neuronasSimples] = organizarNeuronas(structDeNeuronas);

%% Funcion de sasha

%{
    -tomar el struct de angel (neuronasOrdenadas)
    -ver si el 60% de los puntos corresponden a fase flexora o extensora
        --si alguna no entra, eliminarla y anunciar su eliminacion
    -regresar un struct que contenga: tiempos de neurona y clasificacion
%}

structClasificado = organizarFlexExt(neuronasOrdenadas);


%% Funcion de emi:

%{
    -tomar el struct de sasha
    -graficar las n cantidad de neuronas (preferentemente acomodadas de
    abajo hacia arriba, primero flexoras y luego extensoras)
    -usar un proceso similar para los histogramas
%}
regFE = load("registroFE.mat");
graficarNeuronas(structClasificado, regFE.flexion, regFE.extension, regFE.tiempo, regFE.porcentajeflexion)
pause
close all;
