function [flowc]=J_analysis_cortex_p(F,FV,M,cont_grad_v,grad_v,tangent_basis,tg_basis,aires,norm_faces,norm_vertices,index1,index2)
% Computes the optical flow of MEG/EEG activities on the cortical surface
%
% INPcont_grad_v,grad_v,tangent_basis,tg_basis,aires,norm_faces,norm_vertices,index1,index2UTS
% filename : directory name (complete path : "D:\...") with Channel and
% Data files. Can be [] if Channels and Data are given in PARAM
% PARAM : structure with fields :
% .t1,.t2 : limits for the study, default = Time(1), Time(end)
% .hornschunk : regularizing parameter, default = 0.1
% .VERBOSE : computation time at each step, default=0
% .SAVE : saves flows in filename directory, default=0
% .GRAPHE : flow visualization, default=0 
% .Compindex : computes the critical points of the flow (Poincar� index),
%  default=0
% .Name : flow file name for saving, default = '_CortexFlow'
% .MOVIE : produces a MGM movie, default=0
%%% DATA
% .MNE_name : keyword for the name of MNE file 
% .channel_name : keyword for the name of a channel file
% OR
% .F : MNE Activities
% .FV : brain tesselation
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
% .index : Poincar� index

%/---Script Authors---------------------\
%|                                      | 
%|   *** J.Lef�vre, PhD                 |  
%|   julien.lefevre@chups.jussieu.fr    |
%|                                      | 
%\--------------------------------------/

%%% Tesselation

PARAM.Time=1:size(F,2);
PARAM.FV=FV;

% if ~isfield(PARAM,'FV')
%     if ~isfield(PARAM,'keyword_tess')
%         disp('Need to specifiy a keyword for a tesselation file')
%         return
%     end
%     [DataDir,DataPopup,Leader] = find_brainstorm_files(PARAM.keyword_tess,filename);
%     tess=load([Leader,DataDir{1}]) ;
% 
%     PARAM.FV.faces=tess.Faces{1};
%     PARAM.FV.vertices=tess.Vertices{1};
%     clear tess
%     [s1,s2]=size(PARAM.FV.vertices);
%     if s1<s2
%         PARAM.FV.vertices=PARAM.FV.vertices';
%     end
% end

%%% MNE Inverse Problem

% if ~isfield(PARAM,'F')
%     if ~isfield(PARAM,'MNE_name')
%         disp('Need to specifiy a keyword for a MNE file')
%         return
%     end
%     [DataDir,DataPopup,Leader] = find_brainstorm_files(PARAM.MNE_name,filename);
%     if isempty(DataDir) 
%         % Need to compute the inverse solution
%         Results=J_MNE(filename,PARAM);
%     else
%         % Inverse solution already computed
%         Results=load([Leader,DataDir{1}]);
%     end
%     PARAM.Time=Results.ImageGridTime;
%     PARAM.F=double(Results.ImageGridAmp);
%     clear Results
% end

    
%%% Normalization to prevent numerical errors

% M=abs(max(F(:)));
% M=max(M);
PARAM.F=F/M;  

%%% Default Parameters

% Def_PARAM=struct('hornschunk',1e-1,...
%     'SAVE',0,...
%     'MOVIE',0,...
%     'Compindex',0,...
%     'GRAPHE',0,...
%     'VERBOSE',0,...
%     'Name','_CortexFlow',...
%     'keyword_tess','brain_10000V_tess',...
%     't1',PARAM.Time(1),...
%     't2',PARAM.Time(end));
%     
% DefFieldNames = fieldnames(Def_PARAM);
% for k=1:length(DefFieldNames)
%     if ~isfield(PARAM,DefFieldNames{k})
%         PARAM = setfield(PARAM,DefFieldNames{k},getfield(Def_PARAM,DefFieldNames{k}));
%     end
% end

%%% Temporal Limits
PARAM.SAVE=0;
PARAM.MOVIE=0;
PARAM.Compindex=0;
PARAM.Name='_CortexFlow';
PARAM.keyword_tess='brain_10000V_tess';
PARAM.t1=PARAM.Time(1);
PARAM.t2=PARAM.Time(end);
PARAM.VERBOSE=0;
PARAM.hornschunk=0.01;
PARAM.GRAPHE=0;
[m,intv1]=min(abs(PARAM.Time-PARAM.t1));
[m,intv2]=min(abs(PARAM.Time-PARAM.t2));
intv=[intv1:intv2];

%%% Geometrical parameters

dim=3; % 2 for projected maps

%%% Flow computation
% if PARAM.MOVIE
%     [flowc]=calcul_flot_ter([],PARAM.FV.faces,PARAM.FV.vertices,intv,PARAM.F,PARAM.Time,...
%         dim,PARAM.GRAPHE,PARAM.VERBOSE,PARAM.hornschunk,PARAM.Compindex,[filename,'\movie_flow_cortex',num2str(log(hornschunk)/log(10)),'.avi']);
% else
    [flowc]=calcul_flot_ter_p([],PARAM.FV.faces,PARAM.FV.vertices,intv,PARAM.F,PARAM.Time,...
        dim,PARAM.GRAPHE,PARAM.VERBOSE,PARAM.hornschunk,PARAM.Compindex,cont_grad_v,grad_v,tangent_basis,tg_basis,aires,norm_faces,norm_vertices,index1,index2);
% end

% flowc.M=M;

% if PARAM.SAVE
%     %     indice1=findstr(filename,'\');
%     %     indice2=findstr(filename(indice1(end)+1:end),'.');
%     %    save([Study,'\',filename(indice1(end)+1:indice1(end)+indice2-1),Def_PARAM.Name],'flowc')
%     save([filename,PARAM.Name],'flowc')
% end


