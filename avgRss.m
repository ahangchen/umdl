load Result.mat;
rssVIPeR2Grid=mean(rss);
save('Result.mat','rssVIPeR2Grid','-append');