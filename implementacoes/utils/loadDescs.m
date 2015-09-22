function [ batchData, inds ] = loadDescs( indImg, pathData )
%LOADDESCS Summary of this function goes here
%   indImg - index of the image
%   pathData - path to load Data
%   RERTURN the batchsData and the indexs

switch (pathData)
    case '../dados/SURF_real_gopro/desc_surf_real_gopro_'
        maxValue = 150;
        numPart = 4;
        n = 600;
        
    case '../dados/SURF_sim_gopro/desc_surf_sim_gopro_'
        maxValue = 753;
        numPart = 60;
        n = 3011;
        
    case '../dados/SIFT_real_gopro/desc_sift_real_gopro_'
        maxValue = 10;
        numPart = 60;
        n = 600;
end

i = 0;

for j = 1 : numPart
    inds = i + 1 : i + maxValue;
    if (max(inds) > n)
        inds = i + 1 : i + maxValue - (max(inds) - n);
    end
    
    if ( sum(inds == indImg) )
        load(sprintf('%s%.2d', pathData, j));
        %         descr = imgsDescr{inds == indImg};
        
        if (exist('imgsDescr', 'var'))
            batchData = imgsDescr;
        elseif (exist('imgsFrames', 'var'))
            batchData = imgsFrames;
        end
        break;
    end
    
    i = i + maxValue;
end

end
