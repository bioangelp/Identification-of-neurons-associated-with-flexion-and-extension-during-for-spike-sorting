clear;
clc
structDeNeuronas = descargarNeuronas();

[neuronasOrdenadas, neuronasSimples] = organizarNeuronas(structDeNeuronas);

structClasificado = organizarFlexExt(neuronasOrdenadas);

graficarNeuronas(structClasificado); 