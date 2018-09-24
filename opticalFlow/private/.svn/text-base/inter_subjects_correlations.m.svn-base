function [ZZ,Z,cardinal,correlation]=inter_subjects_correlations(FlowScalp,XX,Time,stable,n_sub,nsamp,cond)

Z=zeros(nsamp,nsamp);
ZZ=cell(nsamp,nsamp);
cardinal=zeros(nsamp,nsamp);
correlation=cell(n_sub,n_sub);

tic
for ii=1:7
    sii=stable{ii,1};
    for jj=[[1:ii-1],[ii+1:7]]
        sjj=stable{jj,1};
        temp_coeff=zeros(length(sii),length(sjj));
        for kk=1:length(sii)
            for ll=1:length(sjj)
                indkk=find(XX>=Time(sii(kk)));
                indkk=indkk(1);
                indll=find(XX>=Time(sjj(ll)));
                indll=indll(1);
                
                C=corrcoef(FlowScalp{ii,cond}.F(:,sii(kk)),FlowScalp{jj,cond}.F(:,sjj(ll)));
                temp_coeff(kk,ll)=C(1,2);                
                Z(indkk,indll)=Z(indkk,indll)+C(1,2);
                ZZ{indkk,indll}=[ZZ{indkk,indll},C(1,2)];
                cardinal(indkk,indll)=cardinal(indkk,indll)+1;
            end
        end
        correlation{ii,jj}=temp_coeff;
    end
end
toc