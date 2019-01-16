% srcs = {'CUHK', 'underground', 'VIPeR', 'market1501', 'duke'};
srcs = {'underground', 'VIPeR', 'market1501', 'duke'};
dsts = {'underground', 'market1501', 'duke'};
for src_i=1:length(srcs)
    src = srcs{src_i};
    for dst_j=1:length(dsts)
        dst = dsts{dst_j};
        keep_vars = {'srcs', 'dsts', 'src_i', 'dst_j', 'src', 'dst'};
        if not(strcmp(src, dst))
%             clc;
            
            disp([src,dst]);
            demoUMDL;
            clearvars('-except', keep_vars{:});
        end
    end
end
