close all; clear all; clc;
addpath('..');
addpath('../SOM');

%% Pr�-processamento
dataset = carregaDados('iris.data', 0);

%% Configura��es gerais
ptrn = 0.75;
numRepet = 1;

% Topologia da rede
config.vizinhos = 1;
config.topologia = 'g'; %g grid; h hexagonal
config.dist = 'b'; % b boxdist; l linkdist
config.tamanho = [4 4];
config.epocas = 50;
config.K = 2;

result = som_knn(dataset, ptrn, numRepet, config)


%% Plotando o boxplot
% rotulos = [];
% for i = 1:numRepet
%     rotulos = [rotulos; 'SOM Teste'];
% end
% for i = 1:numRepet
%     rotulos = [rotulos; 'SOM Train'];
% end
% valores = [result.erroTeste result.erroTrain];
% boxplot(valores', rotulos);
% 
% ylabel('Erro de quantiza��o', 'FontSize', 12)