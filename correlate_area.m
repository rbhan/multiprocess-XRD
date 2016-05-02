function correlate_area

area = xlsread('growth_SFR.xlsx','peak_area');

% [pc_pos,score_pos,latent_pos,tsquare_pos] = princomp(pos);
% [pc_int,score_int,latent_int,tsquare_int] = pca(int);
% [pc_fwhm,score_fwhm,latent_fwhm,tsquare_fwhm] = princomp(fwhm);
% [pc_area,score_area,latent_area,tsquare_area] = princomp(area);

r1 = [1, 4, 5, 6];
r2 = [3, 3, 3, 7];
% mapcaplot(scored_XRD)

n = length(area)/10; % # of SFRs
SFR = zeros(n,1);
avg = zeros(n,11);
for i = 1:n
    SFR(i) = area(i*10,1); % SFR
    avg(i,:) = sum(area((1+(i-1)*10):(i*10),:))./10; % average of 10 SFR
end
avg = avg(:,2:end); % 12x10 matrix

perfect_scores = xlsread('perfect_scores.xlsx');
perf_area = perfect_scores(:,4)'; % 1x10 row of peak intensities

perf_pars = [perf_area(1,r1(1))/perf_area(1,r2(1));...
             perf_area(1,r1(2))/perf_area(1,r2(2));...
             perf_area(1,r1(3))/perf_area(1,r2(3));...
             perf_area(1,r1(4))/perf_area(1,r2(4))];

pars = zeros(4,n);
for i = 1:n
    pars(1,i) = avg(i,r1(1))/avg(i,r2(1));
    pars(2,i) = avg(i,r1(2))/avg(i,r2(2));
    pars(3,i) = avg(i,r1(3))/avg(i,r2(3));
	pars(4,i) = avg(i,r1(4))/avg(i,r2(4));
end

area = area(:,2:end);
raws = zeros(4,length(area));
for i = 1:length(area)
    raws(1,i) = area(i,r1(1))/area(i,r2(1));
    raws(2,i) = area(i,r1(2))/area(i,r2(2));
    raws(3,i) = area(i,r1(3))/area(i,r2(3));
    raws(4,i) = area(i,r1(4))/area(i,r2(4));
end

stds = zeros(4,n);
for i = 1:n
    var = zeros(4,1);
    for j = (1+(i-1)*10):(i*10)
        var(:,1) = var(:,1) + (raws(:,j)-pars(:,i)).^2;
    end
    stds(:,i) = sqrt(var(:,1)./(1*n));
end

SFR = [0 SFR'];
PAR1 = [perf_pars(1) pars(1,:)]; STD1 = [0 stds(1,:)];
PAR2 = [perf_pars(2) pars(2,:)]; STD2 = [0 stds(2,:)];
PAR3 = [perf_pars(3) pars(3,:)]; STD3 = [0 stds(3,:)];
PAR4 = [perf_pars(4) pars(4,:)]; STD4 = [0 stds(4,:)];

figure
subplot(2,2,1);
errorbar(SFR, PAR1, STD1, 'rx')
title('(Area at 6.66)/(Area at 8.29)')
xlabel('Stacking Fault Ratio (SFR)')
% axis([0 30 0 0.2])


subplot(2,2,2);
errorbar(SFR, PAR2, STD2, 'rx')
title('(Area at 9.26)/(Area at 8.29)')
xlabel('Stacking Fault Ratio (SFR)')
% axis([0 30 0 0.9])

subplot(2,2,3);
errorbar(SFR, PAR3, STD3, 'rx')
title('(Area at 10.64)/(Area at 8.29)')
xlabel('Stacking Fault Ratio (SFR)')
% axis([0 30 0 0.3])

subplot(2,2,4);
errorbar(SFR, PAR4, STD4, 'rx')
title('(Area at 11.92)/(Area at 12.95)')
xlabel('Stacking Fault Ratio (SFR)')
% axis([0 30 0 8])

end
