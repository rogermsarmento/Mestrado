close all; clear; clc; addpath('../img/');

% http://www.cs.uregina.ca/Links/class-info/425/Lab3/


% img = imread('tire.tif');
img = imread('seeds.png');
I2=im2double(img);
% imshow(img), figure
% imhist(img), figure

%%Negative
% nI = 255 - I;
% nI = imcomplement(img);
% imshow(nI), figure
% imhist(nI), figure
% imhist2(nI), figure


%% logarithmic Transformation 
% c = 5;
% imgLog=c*log(1+I2);
% imshow(imgLog), figure
% imhist(imgLog), figure


%% Gamma Transformation
% c = 1;
% gamma = .4;
% % imgGamma = c*I2.^gamma;
% imgGamma = imadjust(img,[],[],gamma);
% imshow(imgGamma), figure
% imhist(imgGamma), figure


%% Contrast stretching
% imgCont = imadjust(img,[.4 .55],[.12 .87]);
% imshow( imgCont ), figure
% imhist( imgCont), figure


%% Histogram Equalization
% I = imread('pout.tif');
% J = histeq(I);
% subplot(2,2,1);
% imshow( I );
% subplot(2,2,2);
% imhist(I)
% subplot(2,2,3);
% imshow( J );
% subplot(2,2,4);
% imhist(J)

% imshow(histeq2(img))


mask1 = (1/9)*[1 1 1; 1 1 1; 1 1 1];

tic
H = conv2_2(double(img),mask1);
toc

tic
H2 = conv2(double(img), mask1);
toc

tic
H3 = imfilter(img, mask1);
toc

subplot(2, 2, 1)
imshow(uint8(H))
subplot(2, 2, 2)
imshow(uint8(H2))
subplot(2, 2, 3)
imshow(uint8(H3))