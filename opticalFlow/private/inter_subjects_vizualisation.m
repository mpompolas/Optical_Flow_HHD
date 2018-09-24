function []=inter_subjects_vizualisation(ZZ,XX,nsamp,Z,cardinal)

for tt=1:nsamp
    for vv=1:nsamp
        statZZ=ZZ{tt,vv};
        statZZ1(tt,vv)=mean(statZZ);
        statZZ2(tt,vv)=std(statZZ);
    end
end

ind0=find(XX<0); % index of the end of the baseline
ind0=ind0(end);
bstat=Z(1:ind0,1:ind0)./cardinal(1:ind0,1:ind0);
mu=mean(bstat(~isnan(bstat))); % statistics of the correlations in the baseline
sig=std(bstat(~isnan(bstat))); 

figure
Zscore=(Z./cardinal-mu)/sig;
imagesc(XX,XX,Zscore)
axis xy
xlim([-0.3 0.6])
ylim([-0.3 0.6])
hold on
rectangle('Position',[0,0,0.6,0.6],'LineStyle','--','LineWidth',3)

figure
seuilZ=zeros(nsamp,nsamp);
seuilZ(find(abs(Zscore)>=3))=Zscore(find(abs(Zscore)>=3));
imagesc(XX,XX,seuilZ)
axis xy
xlim([-0.3 0.6])
ylim([-0.3 0.6])
hold on
rectangle('Position',[0,0,0.6,0.6],'LineStyle','--','LineWidth',3)