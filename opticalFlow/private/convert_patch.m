function [PFV,PF]=convert_patch(P,FV,F)
% function [PFV]=convert_patch(P,FV)
% -------------------------------------------------------------
% Given a list of connected nodes (P), gives the structure Faces Vertices of the
% patch
% --------------------------------------------------------------
% 
% INPUTS :
% - P : indices of connected nodes
% - FV : structure with fields faces, vertices ,i.e. corresponding to a
% tesselation
% - F : scalar field defined on nodes of FV
% OUTPUTS :
% - PFV : subtesselation of FV based on the nodes P with fields faces,
% vertices
% - PF : scalar field defined on the resulting submesh
% -------------------------------------------------------------------


PFV.vertices=FV.vertices(P,:);
PF=zeros(length(P),size(F,2));
T=[];
nT=1;
for ii=1:size(P,1)
   [ind_i,ind_j]=find(FV.faces==P(ii)); 
    for k=1:length(ind_i)
        if ismember(ind_i(k),T)
        else
            convtri=convert(FV.faces(ind_i(k),:),P);
            if length(convtri)<=2
            else
            PFV.faces(nT,:)=convtri;
            T=[ind_i(k) T];
            nT=nT+1;
            end
        end
    end
    PF(ii,:)=F(P(ii),:);
end


function [convtri]=convert(tri,P)

ind1=find(P==tri(1));
ind2=find(P==tri(2));
ind3=find(P==tri(3));

convtri=[ind1 ind2 ind3];