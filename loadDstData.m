% dst = 'duke'
if strcmp(dst, 'market1501')
    loadMarket1501Data;
else
    if strcmp(dst, 'duke')
        loadDukeData;
    else
        if strcmp(dst, 'underground')
            ntrials = t;
            loadUndergroundData;
        end
    end
end

