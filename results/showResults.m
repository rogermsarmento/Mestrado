clear; close all; clc;

folder = 'goPro/Route/'; type = 8;
files = dir(sprintf('%s*.mat', folder));

% Sort by date
% dateFile = [files(:).datenum]';
% [~,indexFile] = sort(dateFile);
% namesFile = {files(indexFile).name};

% Sort by name
name = {files.name};
[~, index] = sort(name);
namesFile = name(index);

modelStr = '%0.2f$\\pm$%0.2f\t%0.2f$\\pm$%0.2f\t%0.2f$\\pm$%0.2f\t%0.2f$\\pm$%0.2f\t%0.2f$\\pm$%0.2f\t%0.2f$\\pm$%0.2f\t%0.3f$\\pm$%0.2f\t%0.3f$\\pm$%0.2f\t%s\n';
modelStr2 = '%0.2f$\\pm$%0.2f\t%0.2f$\\pm$%0.2f\t%0.2f$\\pm$%0.2f\t%0.2f$\\pm$%0.2f\t%0.2f$\\pm$%0.2f\t%0.2f$\\pm$%0.2f\t%s\n';
modelStr3 = '& %0.1f$\\pm$%0.1f & %0.1f$\\pm$%0.1f & %0.1f$\\pm$%0.1f & %0.1f$\\pm$%0.1f & %0.1f$\\pm$%0.1f & %0.1f$\\pm$%0.1f \\\\ %s\n';

if (type == 15)
    fprintf('\\begin{tabular}{c|c|c|cccccc}\n');
    fprintf('\\hline\n');
    fprintf('Feature\t\t\t\t& Classifier \t\t & Setup \t& Spe (\\%%) \t & Sen (\\%%) \t  & PPV (\\%%)  \t   & F-Score (\\%%)   & HM (\\%%)        & Acc (\\%%) \t \\\\ \\hline\n');
    %
end

for i = 1 : numel(files)
    name = namesFile{i};
    load(sprintf('%s%s', folder, name));
    
    if (type == 1 || type == 2 || type == 14)
        num = size(result.metricasGeralMedia,2);
    end
    
    if (type == 3 || type == 4 || type == 15)
        metricas(1:2:11) = result.metricasGeralMedia;
        metricas(2:2:12) = std(result.metricasGeral,0,1);
    end
    
    if (type >= 7 && type <= 13 && isfield(result, 'routes'))
        result = result.routes;
    end
    
    
    switch(type)
        case 1
            %% Only general metrics
            fprintf([repmat('%0.4f\t', 1, num) '\n'], result.metricasGeralMedia*100);
            
        case 2
            %% General metrics, times and names
            fprintf([repmat('%0.4f\t', 1, num) '%0.4f\t%0.4f\t%s\n'], result.metricasGeralMedia*100, mean(result.tempoTrein), 1000000*mean(result.tempoTeste), name);
            
        case 3
            %% General metrics (std), times (std) and Names
            fprintf(modelStr, metricas*100, mean(result.tempoTrein), std(result.tempoTrein), 1000000*mean(result.tempoTeste), 1000000*std(result.tempoTeste), name);
            
        case 4
            %% General metrics (std) and Names
            fprintf(modelStr2, metricas*100, name);
            
        case 5
            fprintf('%0.4f\t%0.4f\t%s\n', mean(result.tempoTrein), 1000000*mean(result.tempoTeste), name);
            
        case 6
            fprintf('%0.4f\t%0.4f\n', mean(result.tempoTrein), 1000000*mean(result.tempoTeste));
            
            
        case 7
            %% Only route
            num = length(result);
            metrcs = zeros(1,num);
            for j = 1 : num
                metrcs(j) = mean(result{j}.hit);
            end
            
            %General
            metrcs(num + 1) = mean(metrcs);
            fprintf([repmat('%0.2f\t', 1, num+1) '%s\n'], 100*metrcs, name)
            clear metrcs
            
            
        case 8
            %% Only route with std
            num = length(result);
            for j = 0 : num -1
                metrcs(j*2 + 1) = mean(result{j+1}.hit);
                metrcs(j*2 + 2) = std(result{j+1}.hit);
            end
            
            %General
            metrcs(num*2 + 1) = mean(metrcs(1:2:num*2));
            metrcs(num*2 + 2) = std(metrcs(1:2:num*2));
            fprintf([repmat('%0.2f$\\pm$%0.2f\t', 1, num+1) '%s\n'], 100*metrcs, name)
            clear metrcs
            
            
        case 9
            %% Only reject option
            num = length(result);
            for j = 1 : num
                metrcs(j) = mean(result{j}.hitRej);
            end
            
            %General
            metrcs(num + 1) = mean(metrcs);
            fprintf([repmat('%0.2f\t', 1, num+1) '%s\n'], 100*metrcs, name)
            clear metrcs
            
            
        case 10
            %% Only reject option with std
            num = length(result);
            for j = 0 : num -1
                metrcs(j*2 + 1) = mean(result{j+1}.hitRej);
                metrcs(j*2 + 2) = std(result{j+1}.hitRej);
            end
            
            %General
            metrcs(num*2 + 1) = mean(metrcs(1:2:num*2));
            metrcs(num*2 + 2) = std(metrcs(1:2:num*2));
            fprintf([repmat('%0.2f$\\pm$%0.2f\t', 1, num+1) '%s\n'], 100*metrcs, name)
            clear metrcs
            
            
        case 11
            %% Route with rejec option
            num = length(result);
            for j = 0 : num -1
                metrcs(j*2 + 1) = mean(result{j+1}.hit);
                metrcs(j*2 + 2) = mean(result{j+1}.hitRej);
            end
            
            %General
            metrcs(num*2 + 1) = mean(metrcs(1:2:num*2));
            metrcs(num*2 + 2) = mean(metrcs(2:2:num*2));
            fprintf([repmat('%0.2f/%0.2f\t', 1, num+1) '%s\n'], 100*metrcs, name)
            clear metrcs
            
        case 12
            %% Only route with std (II)
            num = length(result);
            for j = 0 : num -1
                metrcs(j*2 + 1) = mean(result{j+1}.hit);
                metrcs(j*2 + 2) = std(result{j+1}.hit);
            end
            
            %General
            metrcs(num*2 + 1) = mean(metrcs(1:2:num*2));
            metrcs(num*2 + 2) = std(metrcs(1:2:num*2));
            
            
            fprintf(repmat('%0.2f$\\pm$%0.2f\t', 1, num), 100*metrcs(1:num) );
            fprintf('\n');
            fprintf(repmat('%0.2f$\\pm$%0.2f\t', 1, num), 100*metrcs(num+1:num*2));
            fprintf('%0.2f$\\pm$%0.2f\t%s\n', 100*metrcs(num*2+1), 100*metrcs(num*2+2), name)
%             fprintf('$\\textbf{General result:}$ %0.2f$\\pm$%0.2f\n', 100*metrcs(num*2+1), 100*metrcs(num*2+2))
%             keyboard

            clear metrcs
            
        case 13
            %% Only reject option with std (II)
            num = length(result);
            for j = 0 : num -1
                metrcs(j*2 + 1) = mean(result{j+1}.hitRej);
                metrcs(j*2 + 2) = std(result{j+1}.hitRej);
            end
            
            %General
            metrcs(num*2 + 1) = mean(metrcs(1:2:num*2));
            metrcs(num*2 + 2) = std(metrcs(1:2:num*2));
            
            
            fprintf(repmat('%0.2f$\\pm$%0.2f\t', 1, num), 100*metrcs(1:num) );
            fprintf('\n');
            fprintf(repmat('%0.2f$\\pm$%0.2f\t', 1, num), 100*metrcs(num+1:num*2));
            fprintf('%0.2f$\\pm$%0.2f\t%s\n', 100*metrcs(num*2+1), 100*metrcs(num*2+2), name);
%             fprintf('$\\textbf{General result:}$ %0.2f$\\pm$%0.2f\n', 100*metrcs(num*2+1), 100*metrcs(num*2+2))
%             keyboard

            clear metrcs

            
        case 14
            %% O que isso imprimi???
            
            fprintf(' %s \n', name)
            fprintf([repmat('%0.2f\t', 1, num) '\n'], mean(result.metricas, 3)*100);
            fprintf([repmat('%0.2f\t', 1, num) '\n'], result.metricasGeralMedia*100);
            
        case 15
            %% Create the table
            if(not(isempty(strfind(name, 'central'))))
                nameExt = 'Central M.';
            elseif (not(isempty(strfind(name, 'haralick'))))
                nameExt = 'GLCM';
            elseif (not(isempty(strfind(name, 'hu'))))
                nameExt = 'Hu';
            elseif (not(isempty(strfind(name, 'lbp'))))
                nameExt = 'LBP';
            elseif (not(isempty(strfind(name, 'statistic'))))
                nameExt = 'Statistics M.';
            end
            
            if(not(isempty(strfind(name, 'bayes'))))
                nameClassifier = sprintf('\\multirow{12}{*}{%s}\t& Bayes\t\t\t & Normal\t', nameExt);
                line = '\cline{2-9}';
                
            elseif (not(isempty(strfind(name, 'lssvm-linear'))))
                nameClassifier = sprintf('\t\t\t\t& \\multirow{2}{*}{LSSVM} & Linear\t');
                line = '';
                
            elseif (not(isempty(strfind(name, 'lssvm-rbf'))))
                nameClassifier = sprintf('\t\t\t\t& \t\t\t & RBF\t\t');
                line = '\cline{2-9}';
                
            elseif (not(isempty(strfind(name, 'mlm-D-cityblock'))))
                nameClassifier = sprintf('\t\t\t\t& \\multirow{3}{*}{MLM}\t & City Block\t');
                line = '';
                
            elseif (not(isempty(strfind(name, 'mlm-D-euclidean'))))
                nameClassifier = sprintf('\t\t\t\t& \t\t\t & Euclidean\t');
                line = '';

            elseif (not(isempty(strfind(name, 'mlm-D-mahalanobis'))))
                nameClassifier = sprintf('\t\t\t\t& \t\t\t & Mahalanobis\t');
                line = '\cline{2-9}';
                
            elseif (not(isempty(strfind(name, 'mlmNN'))) && not(isempty(strfind(name, 'cityblock'))))
                nameClassifier = sprintf('\t\t\t\t& \\multirow{3}{*}{MLM-NN} & City Block\t');
                line = '';
                
            elseif (not(isempty(strfind(name, 'mlmNN'))) && not(isempty(strfind(name, 'euclidean'))))
                nameClassifier = sprintf('\t\t\t\t& \t\t\t  & Euclidean\t');
                line = '';

            elseif (not(isempty(strfind(name, 'mlmNN'))) && not(isempty(strfind(name, 'mahalanobis'))))
                nameClassifier = sprintf('\t\t\t\t& \t\t\t  & Mahalanobis\t');
                line = '\cline{2-9}';
                
            elseif (not(isempty(strfind(name, 'mlp'))))
                nameClassifier = sprintf('\t\t\t\t& \\multicolumn{2}{c|}{MLP} \t\t');
                line = '\cline{2-9}';
                
            elseif (not(isempty(strfind(name, 'svm-linear'))))
                nameClassifier = sprintf('\t\t\t\t& \\multirow{2}{*}{SVM}\t & Linear\t');
                line = '';
                
            elseif (not(isempty(strfind(name, 'svm-rbf'))))
                nameClassifier = sprintf('\t\t\t\t& \t\t\t & RBF\t\t');
                line = '\hline';

            elseif (not(isempty(strfind(name, 'sift'))))
                nameClassifier = sprintf('\\multicolumn{3}{c|}{SIFT}\t\t\t\t\t\t');
                line = '\hline';
                
            elseif (not(isempty(strfind(name, 'surf'))))
                nameClassifier = sprintf('\\multicolumn{3}{c|}{SURF}\t\t\t\t\t\t');
                line = '\hline';
            end

            fprintf('%s%s', nameClassifier, sprintf(modelStr3, metricas*100, line));
            
            
        case 16
            %% Acc, test and train time            
            fprintf('& %0.1f\t& %0.2f$\\pm$%0.1f\t& %0.1f$\\pm$%0.1f\t %s\n', result.metricasGeralMedia(end)*100, ...
                mean(result.tempoTrein), std(result.tempoTrein), 1000000*mean(result.tempoTeste), 1000000*std(result.tempoTeste), name);
    end
    
end