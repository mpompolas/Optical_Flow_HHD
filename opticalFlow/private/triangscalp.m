function [tri,coord]=triangscalp(Channel,imegsens);
% Extracts a tesselation from a Channel structure
% INPUTS :
% Channel : struct with fields .Loc, .Name etc
% imegsens : list of good sensors (e.g. only MEG or EEG)
% OUTPUTS :
% tri : list of triangles
% coord : coordinates of each sensor

chanloc =[Channel(imegsens).Loc];
chanloc=chanloc(:,1:2:end);
minn=min(chanloc')';
maxx=max(chanloc')';
coord=chanloc';
chanloc(3,:)=chanloc(3,:)-maxx(3);
[TH,PHI,R]=cart2sph(chanloc(1,:),chanloc(2,:),chanloc(3,:));
PHI2=zeros(size(PHI));
R2=R./cos(PHI).^.2;
[Y,X]=pol2cart(TH,R2);
bord=convhull(Y,X);
ncapt=size(coord,1);
[center,R]=bestfitsph(coord);
coordC=coord-(ones(ncapt,1)*center');
tri=convhulln(coordC./(norlig(coordC)'*ones(1,3)));
keep=find(~(ismember(tri(:,1),bord) & ismember(tri(:,2),bord)& ismember(tri(:,3),bord)));
tri=tri(keep,:);



