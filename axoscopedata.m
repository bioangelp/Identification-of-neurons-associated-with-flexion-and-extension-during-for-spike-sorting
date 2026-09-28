sr = 50000;
clc
disp(" Copie su segmento y posteriormente presione ENTER (no CTRL + V): ");
pause;
registroRaw = clipboard("paste");
registro = str2num(registroRaw);
%disp(registro)
numeroRegistro = input(" Ingrese los ultimos 3 digitos nombre del archivo\n ", "s");
clc
numeroCanal = input(" Ingrese el número de canal para la lectura, considerando que el canal 1 es correspondiente al tiempo\n ");
clc
numeroCanalReal = input(" Ingrese el número real del canal que corresponde al archivo\n ", "s");
clc
numeroIteracion = input(" Ingrese el numero de iteracion que corresponde a este registro y este canal\n ", "s");
clc
nombreArchivo = sprintf("r%sc%si%s", numeroRegistro, numeroCanalReal, numeroIteracion);
data = registro(:,numeroCanal);
%disp(nombreArchivo)


%% CREANDO CARPETAS PARA ORGANIZACION

%Creando una carpeta raw donde van a estar los archivos para correr por
%waveclus
[localizacionDePrograma, ~, ~] = fileparts(mfilename('fullpath'));

subCarpetaRaw = fullfile(localizacionDePrograma, "raw");
if ~exist(subCarpetaRaw, 'dir')
    mkdir(subCarpetaRaw);
end

save (nombreArchivo, 'data', 'sr');
cd(localizacionDePrograma)

%para las figuras que devuelve waveclus
subCarpetaFig = fullfile(localizacionDePrograma, "fig");
if ~exist(subCarpetaFig, 'dir')
    mkdir(subCarpetaFig);
end

%para los times
subCarpetaTimes = fullfile(localizacionDePrograma, "times_");
if ~exist(subCarpetaTimes, 'dir')
    mkdir(subCarpetaTimes);
end

%para lo que no necesitamos
subCarpetaNoNeed = fullfile(localizacionDePrograma, "data_");
if ~exist(subCarpetaNoNeed, 'dir')
    mkdir(subCarpetaNoNeed);
end

subCarpetaNoNeedIndividual = fullfile(subCarpetaNoNeed, nombreArchivo);
if ~exist(subCarpetaNoNeedIndividual, 'dir')
    mkdir(subCarpetaNoNeedIndividual);
end

%guaardar pre waveclus en raw

save (nombreArchivo, 'data', 'sr');
moverArchNombre = sprintf("%s.mat", nombreArchivo);
movefile(moverArchNombre, subCarpetaRaw)


%declarar tiempo de registro para la normalizacion
tiempoDeRegistro = length(data)/sr;

fprintf("Presione enter y cargue el archivo con el nombre %s.mat en wave clus ", nombreArchivo)
pause;
cd(subCarpetaRaw)
wave_clus
clc
disp("Presione enter una vez guardados los clusters, despues de las letras naranjas")
pause
pause(1)

%% MOVER TODOS LOS ARCHIVOS QUE CONSTRUYO WAVECLUS A SU CARPETA CORRESPONDIENTE 

%nombres de los archivos a mover
moverArchNombre = sprintf("fig2print_%s.png", nombreArchivo);
%direccionWaveClus = fullfile(subCarpetaRaw, nombreParaMover);
movefile(moverArchNombre, subCarpetaFig)

moverArchNombre = sprintf("times_%s.mat", nombreArchivo);
movefile(moverArchNombre, subCarpetaTimes)

% Mover a data lo que no necesitamos ahora 
moverArchNombre = sprintf("data_%s.dg_01", nombreArchivo);
movefile(moverArchNombre, subCarpetaNoNeedIndividual);
moverArchNombre = sprintf("data_%s.dg_01.lab", nombreArchivo);
movefile(moverArchNombre, subCarpetaNoNeedIndividual);
movefile("spc_log.txt", subCarpetaNoNeedIndividual);
%%

close wave_clus
cd(localizacionDePrograma)
% CONSTRUYENDO EL NOMBRE DEL ARCHIVO TIMES PARA CARGARLO Y EXTRAER DATOS
archivoTimes = sprintf("times_%s.mat", nombreArchivo);
archivoTimes = fullfile(subCarpetaTimes, archivoTimes);
registro = load(archivoTimes);

clustersNeuronas = registro.cluster_class(:,1);
tiemposNeuronas = registro.cluster_class(:,2);

numeroNeuronasEncontradas = transpose(unique(clustersNeuronas));

% para cada neurona encontrada se crea un elemento de un struct con el
% nombre del archivo + el numero de neurona y el tiempo que tomo la captura
% para normalizarlo en otro programa

clear miStruct
for contador = numeroNeuronasEncontradas 
    if contador > 0
        tiempoFiltrado = tiemposNeuronas(clustersNeuronas == contador);
        nombreNeurona = sprintf("n%d%s", contador, nombreArchivo);
        miStruct.(nombreNeurona) = tiempoFiltrado;
    end 
end

%proteccion por si no hayy nada
if ~exist("miStruct", "var")
    disp("No hubieron neuronas en el registro");
    return
end

% Definiendo la unicacion actual del programa con el fin de crear una
% carpeta llamada neuronas donde se van a guardar los archivos .mat de cada
% neurona extraida por registro
[localizacionDePrograma, ~, ~] = fileparts(mfilename('fullpath'));
subCarpetaNeurona = fullfile(localizacionDePrograma, "neuronas");
if ~exist(subCarpetaNeurona, 'dir')
    mkdir(subCarpetaNeurona);
end
%moverse a la subcarpeta para descargar los datos
cd(subCarpetaNeurona);

nombresNeuronas = transpose(fieldnames(miStruct));

% par cada neurona en el struct se guarda el tiempo en segundos de su disparo, se toma
% el nombre de archivo como el nombre del elemento del struct 
for neurona = nombresNeuronas
    tiemposNeuronaSegundos = miStruct.(neurona{1})/1000;
    nombreArchivoNeurona = neurona{1};
    save(nombreArchivoNeurona, "tiemposNeuronaSegundos", "tiempoDeRegistro")
end

%regresando a la ubicacion normal del programa
cd(localizacionDePrograma)
clc
fprintf("\n neurona(s) guardada(s) en %s\n", subCarpetaNeurona);

