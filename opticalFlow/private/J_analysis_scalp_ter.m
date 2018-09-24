function [flows]=J_analysis_scalp_ter(filename,PARAM); 
% Computes the optical flow of MEG/EEG activities on the scalp surface
%
% INPUTS
% filename : directory name (complete path : "D:\...") with Channel and
% Data files. Can be [] if Channels and Data are given in PARAM
% PARAM : structure with fields :
% .t1,.t2 : limits for the study, default = Time(1), Time(end)
% .hornschunk : regularizing parameter, default = 0.1
% .VERBOSE : computation time at each step, default=0
% .SAVE : saves flows in filename directory, default=0
% .GRAPHE : flow visualization, default=0 
% .Compindex : computes the critical points of the flow (Poincaré index),
%  default=0
% .Name : flow file name for saving, default = '_ScalpFlow'
% .MOVIE : produces a MGM movie, default=0
%%% DATA
% .data_name : keyword for the name of a data file 
% .channel_name : keyword for the name of a channel file
% OR
% .F : Activities
% .Channel : Channel file
% .Time : Time instants
%
% OUTPUTS
% flows : struct with fields :
% .F : Activities
% .V : Optical flow
% .lambda : Regularizing parameter
% .cmin : Min of activities
% .cmax : Max of activities
% .tri : Triangles of tesselation
% .coord : Coordinates of tesselation
% .de : Displacement Energy
%%% Options
% .ind_dI : Constant term in variationnal formulation
% .rho : Fit to Data energy
% .eta : Regularization energy
% .index : Poincaré index

%/---Script Authors---------------------\
%|                                      | 
%|   *** J.Lefèvre, PhD                 |  
%|   julien.lefevre@chups.jussieu.fr    |
%|                                      | 
%\--------------------------------------/


%%% Scalp data and Time epochs

if ~isfield(PARAM,'F')
    if ~isfield(PARAM,'data_name')
        disp('Need to specifiy a keyword for a data file')
        return
    end
    [DataDir,DataPopup,Leader] = find_brainstorm_files(PARAM.data_name,filename);
    name=DataDir{1};
    data=load([Leader,name]);
    PARAM.F=data.F;
    PARAM.Time=data.Time;
    clear data name
else
    if ~isfield(PARAM,'Time')
        PARAM.Time=[1:length(F_scalp)];
        disp('Warning : No Time vectors')
    end
end

%%% Channels
if ~isfield(PARAM,'Channel')
    if ~isfield(PARAM,'channel_name')
        disp('Need to specifiy a keyword for a Channel file')
        return
    end
    [DataDir,DataPopup,Leader] = find_brainstorm_files(PARAM.channel_name,filename);
    load([Leader,DataDir{1}])
    PARAM.Channel=Channel;
end

%%% Default Parameters

Def_PARAM=struct('hornschunk',1e-1,...
    'SAVE',0,...
    'MOVIE',0,...
    'Compindex',0,...
    'GRAPHE',0,...
    'VERBOSE',0,...
    't1',PARAM.Time(1),...
    't2',PARAM.Time(end),...
    'normalized',0);
    
DefFieldNames = fieldnames(Def_PARAM);
for k=1:length(DefFieldNames)
    if ~isfield(PARAM,DefFieldNames{k})
        PARAM = setfield(PARAM,DefFieldNames{k},getfield(Def_PARAM,DefFieldNames{k}));
    end
end

%%% Good channels

validloc=good_channel(PARAM.Channel,[],'MEG');
if max(validloc)>size(PARAM.F,1)  
    M=max(abs(max(PARAM.F)));
    PARAM.F=PARAM.F/M;
else
    M=abs(max(PARAM.F(validloc,:)));
    M=max(M);
    PARAM.F(validloc,:)=PARAM.F(validloc,:)/M; 
end

if PARAM.normalized
   %PARAM.F(validloc,:)=PARAM.F(validloc,:)./repmat(max(PARAM.F(validloc,:)),length(validloc),1); 
   PARAM.F(validloc,:)=PARAM.F(validloc,:)./repmat(sqrt(sum(PARAM.F(validloc,:).^2,1)),length(validloc),1); 
end

%%% Temporal Limits
[m,intv1]=min(abs(PARAM.Time-PARAM.t1));
[m,intv2]=min(abs(PARAM.Time-PARAM.t2));
intv=[intv1:intv2];

%%% Geometrical parameters

dim=3; % 2 for projected maps

[tri_scalp,coord_scalp]=triangscalp(PARAM.Channel,validloc);

%%% Flow computation
if PARAM.MOVIE
    [flows]=calcul_flot_ter(validloc,tri_scalp,coord_scalp,intv,PARAM.F,PARAM.Time,...
        dim,PARAM.GRAPHE,PARAM.VERBOSE,PARAM.hornschunk,PARAM.Compindex,[filename,'\movie_flow_scalp',num2str(log(PARAM.hornschunk)/log(10)),'.avi']);
else
    [flows]=calcul_flot_ter(validloc,tri_scalp,coord_scalp,intv,PARAM.F,PARAM.Time,...
        dim,PARAM.GRAPHE,PARAM.VERBOSE,PARAM.hornschunk,PARAM.Compindex);
end

flows.M=M;
if PARAM.SAVE
    indice1=findstr(filename,'\');
    indice2=findstr(filename(indice1(end)+1:end),'.');
    save([filename,PARAM.Name],'flows')
end

function [de]=displacement_energy(flowjV,tri_scalp,aires) 
    for t=1:size(flowjV,3)
        v12=sum((flowjV(tri_scalp(:,1),:,t)+flowjV(tri_scalp(:,2),:,t)).^2,2)/4;
        v23=sum((flowjV(tri_scalp(:,2),:,t)+flowjV(tri_scalp(:,3),:,t)).^2,2)/4;
        v13=sum((flowjV(tri_scalp(:,1),:,t)+flowjV(tri_scalp(:,3),:,t)).^2,2)/4;
        de(t)=sum(aires.*(v12+v23+v13));
    end
    
