function [ dados ] = img2Dados( imgs, withLabel, varargin )
%IMG2DADOS Convert image to data
%
%   data = img2Dados( imgs, withLabel)
%
%   image: a list of images (cell) or one image (uint8)
%   withLabel: with or withou label
%   data (output)

if isa(imgs, 'uint8')
    img = imgs; clear imgs;
    imgs{1} = img;
end

if not(exist('withLabel', 'var'))
    withLabel = false;
end

dados.x = [];
dados.y = [];
for i = 1 : size(imgs,2)
    
    [linhas colunas dim] = size(imgs{i});
    switch(dim)
        case 1
            x = [reshape(imgs{i}(:,:), [1 linhas*colunas])'];

        case 3
            x = [reshape(imgs{i}(:,:,1), [1 linhas*colunas])' ...
                reshape(imgs{i}(:,:,2), [1 linhas*colunas])' ...
                reshape(imgs{i}(:,:,3), [1 linhas*colunas])' ];

        otherwise
            erro('1 or 3 chanel only');
    end
    
        
    if withLabel
       x =  unique(x,'rows');
        dados.y = [dados.y; i*ones(size(x,1),1)];
        dados.x = [dados.x; x];
    else
         dados.x = [dados.x; x];        
    end
    
end

% 
% dados.x = [];
% dados.y = [];
% for i = 1 : size(imgs,2)
%     x = [];
%     
%     % Percorre cada pixel
%     [linhas colunas ~] = size(imgs{i});
%     for lin = 1 : linhas
%         for col = 1 : colunas
%             
%             x = [x; [imgs{i}(lin, col, 1) ...
%                 imgs{i}(lin, col, 2) imgs{i}(lin, col, 3)]];
%         end
%     end
%     
%     if (strcmp(tipo, 'teste') == 1)
%         dados.x = [dados.x; x];
%     else
%         x =  unique(x,'rows');
%         dados.y = [dados.y; i*ones(size(x,1),1)];
%         dados.x = [dados.x; x];
%     end
% end

dados.x =  double(dados.x);

if not(withLabel)
    [x, ~, ic] =  unique(dados.x,'rows');
    dados.x = x;
    dados.ic = ic;
end

end

