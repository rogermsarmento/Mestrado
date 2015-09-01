close all; clear; clc; addpath('../img/');

% coins
% hubble
% bandeiras
% letras
% quadrinhos
% lenna
% girafa
% moedas
% - 'replicate' or 0


%% Filtro da M�dia
% Kernels de v�rios tamanhos
% img = imread('quadrinho3.jpg');
% img = rgb2gray(img);
% subplot(2, 3, 1)
% imshow(img)
% j = 2 ;
% for i = [5 15 25 35 45]
%     mask = fspecial('average', i);
%     h = imfilter(img,mask);
%     subplot(2, 3, j)
%     imshow(h)
%     j = j + 1;
% end
% figure

% Filtro da M�dia aplicado v�rias vezes
% img = imread('quadrinho3.jpg');
% img = rgb2gray(img);
% mask = fspecial('average', 5);
% subplot(2, 3, 1)
% imshow(img)
% j = 2;
% for i = 1 : 25
%     img = imfilter(img,mask);
%     if mod(i, 5) == 0
%         subplot(2, 3, j)
%         imshow(img)
%         j = j + 1;
%     end    
% end


% Comparacao entre filtro da media aritm�tica e ponderada
% img = imread('alfabet.jpg');
% num = 99;
% 
% mask = fspecial('average', 3);
% imgF = imfilter(img,mask);
% for i = 1 : num
%     imgF = imfilter(imgF,mask);
% end
% subplot(1, 2, 1)
% imshow(imgF)
% 
% mask = [1 2 1; 2 4 2; 1 2 1]/16;
% imgF2 = imfilter(img,mask);
% for i = 1 : num
%     imgF2 = imfilter(imgF2,mask);
% end
% subplot(1, 2, 2)
% imshow(imgF2)
% figure, imhist(imgF), figure, imhist(imgF2)


% M�dia com Limiariza��o
% img = imread('texto_quadrinho3.jpg');
% img = rgb2gray(img);
% 
% mask = fspecial('average', 9);
% imgF = imfilter(img,mask, 'replicate');
% imgT = thresholding(imgF, 200);
% 
% [labelComp totalComp] = bwlabel(imgT);
% imshow(img), figure, imshow(imgT)



%% Filtro da Mediana
% Comparacao entre filtro da media da mediana (ru�do sal e pimenta)
% I = imread('coins.png');
% img = imnoise(I,'salt & pepper', 0.02);
% 
% mask = fspecial2('average', 3);
% imgA = imfilter2(img,mask);
% 
% imgM = medianFilt(img,3);
% 
% subplot(1, 3, 1)
% imshow(I)
% subplot(1, 3, 2)
% imshow(imgA)
% subplot(1, 3, 3)
% imshow(imgM)


% Kernels de v�rios tamanhos
img = imread('couple.png');
img = rgb2gray(img);

% j = 1;
% subplot(2, 3, j)
% imshow(img);
% for i = [3 5 15 25 35]
%     imgM = medianFilt(img,i);
%     
%     j = j + 1;
%     subplot(2, 3, j)
%     imshow(imgM);
% end
% figure


% Filtro da Mediana aplicado v�rias vezes
img = imread('couple.png');
img = rgb2gray(img);

j = 1;
subplot(2, 3, j)
imshow(img);
imgsHist{j} = img;
for i = 1 : 10    
    
    img = medianFilt(img,3);
    if mod(i, 2) == 0
        j = j + 1;
        subplot(2, 3, j)
        imshow(img);
        
        imgsHist{j} = img;
    end
end

% Mostra os histogramas das imagens anteriores
for i = 1:j
   figure, imhist(imgsHist{i})
end


%% Filtro Gaussiano
% Variando o sigma

% Kernels de v�rios tamanhos

% Filtro Gaussiano aplicado v�rias vezes

% Comparando com o da m�dia



%% Laplaciano
% Diferen�a entre as duas m�scaras

% Filtro Laplaciano aplicado v�rias vezes



%% Prewitt
% Compara o gradiente da dire��o x, y e a magnitude

% Compara as 2 maneiras de calcular a magnitude da imagem anterior

% Diferen�a diferen�a nas duas maneiras de calcular o Prewitt


%% Sobel
% Compara o gradiente da dire��o x, y e a magnitude (mesma imagem do
% Prewitt)

% Bordas em 45�

% Filtro da M�dia antes de detectar borda

% Sobel com Limiariza��o

% Compara Laplaciano, Prewitt e Sobel


%% Equaliza��o de histograma
% arroz menina seeds


%moedas
%% Limiariza��o
% Limiares fixos


% Limiares autom�ticos
%125 fingerprint

%% Multilimiariza��o
%[84 124] ice - melhor rgb
%[49 140] alemanha
%[0.4 0.59] floresta - melhor hsv

