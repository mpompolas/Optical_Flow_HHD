function [Results]=J_MNE(filename,PARAM);
 
% Forward modelling -----------------------------------------------

% Store arguments to be passed to main script in fwOPTIONS structure
Study=[filename,'\Study'];
Subject=[filename,'\Subject\'];
% subfolders=ls(Subject);
% Subject=[Subject,subfolders(3,:)];

User.STUDIES = Study; % EDIT
User.SUBJECTS = Subject; % EDIT

% Store this information in Matlab's preferences
setpref('BrainStorm','UserDataBase',User);
setpref('BrainStorm','iUserDataBase',1);

fwOPTIONS.Method = {'meg_sphere'}; % MEG spherical head model

% Use scalp tessellation to fit sphere to head
% [DataDir,DataPopup,Leader] = find_brainstorm_files('_channel',Subject);
% fwOPTIONS.Scalp.FileName =[Leader,DataDir{1}];
% fwOPTIONS.Scalp.iGrid = 1; % Location of head envelope in .FileName tessellation cell arrays % EDIT % 

% Use cortex or white/gray interface to distribute sphere to distribute source models


[DataDir,DataPopup,Leader] = find_brainstorm_files('_tess',Subject);
fwOPTIONS.Cortex.FileName = [Leader,DataDir{1}] ;
fwOPTIONS.Cortex.iGrid = 1; % WARNING : for all subjects in this study but S7 where .iGrid = 10 % EDIT % 

% Type HELP BST_HEADMODELER.M for further info on the following arguments 
fwOPTIONS.VolumeSourceGrid = 0;
fwOPTIONS.HeadModelFile = 'default';
fwOPTIONS.ImageGridFile = 'default';
fwOPTIONS.Verbose = 1;
[DataDir,DataPopup,Leader] = find_brainstorm_files('_channel',Study);
fwOPTIONS.ChannelFile = [Leader,DataDir{1}];

% Call main function
[OPTIONS.HeadModelFile, tmp] = bst_headmodeler(fwOPTIONS);
% -> Done with Forward modelling 


% Inverse modelling ------------------------------------------------------

% Store arguments to be passed to main script in invOPTIONS structure
[DataDir,DataPopup,Leader] = find_brainstorm_files('data_trial',Study);
invOPTIONS.DataFile = 'datafile' ; % EDIT % Store MEG-EEG datafile(s) to be processed in a cell array of strings
if ~isfield(PARAM,'t1')
    invOPTIONS.TimeSegment = []; % Time segment to be processed, in seconds
else
    invOPTIONS.TimeSegment=[PARAM.t1 PARAM.t2];
end
invOPTIONS.DataTypes = 1; % Process MEG (1); EEG (2) or Fusion of MEG with EEG (3)
invOPTIONS.HeadModelFile = 'somDemo_av_headmodelSurfGrid_CD_10.mat';
invOPTIONS.Method = 'Minimum-Norm Imaging';
invOPTIONS.Verbose = 1;
invOPTIONS.GridLoc='imp.mat';
% Call main function

[Results, tmp] = bst_sourceimaging(invOPTIONS);

return 

% -> Done with inverse estimation


% --- DONE with calls to higher-level functions; 
%now let's move to basics and low-level access to data and result files
% Note these calls necessitate that actions above are completed and that
% the Results structure is loaded in memory.

%Working data folder 
cd('D:\users\Experiences\Trauma\Moyenne\Study')

% How to know which channel is MEG, which channel is EEG
load('Moyenne_channel.mat') % Load a BrainStorm channel file
load('Moyenne_data_trial_1.mat','ChannelFlag') % Load 'good channel' information from a data file 


% by default ChannelFlag = [] or ones(length(Channel),1) (assume all
% channels are good (type HELP_DATA_DATA for more info about ChannelFlag
% and HELP_DATA_CHANNEL for BrainStorm Channel structure
imeg = good_channel(Channel,ChannelFlag,'MEG'); % Set of indices of MEG channels in the Channel structure
ieeg = good_channel(Channel,ChannelFlag,'EEG'); % Same for EEG channels

% How to read the gain matrix file ? ---------------------------------------
G = read_gain(Results.ModelGain,imeg,[]);

% How to run basic Results visualization 
% Load tessellation of cortical envelope
load(fwOPTIONS.Cortex.FileName) % Faces, Vertices (type HELP_DATA_TESS for more information about tessellation files in BrainStorm)
Faces = Faces{fwOPTIONS.Cortex.iGrid}; % Vertex connections
Vertices = Vertices{fwOPTIONS.Cortex.iGrid}; % Vertex locations

Results.ImageGridAmp = double(Results.ImageGridAmp); % Convert current amplitudes to double for further manipulation 

% Make a movie of cortical current maps !
for t = 1:size(Results.ImageGridAmp,2)
    if t == 1
        [hf,hs,hl] = view_surface('essai',Faces,Vertices,Results.ImageGridAmp(:,1)); % This is the main 3D viewing function in BrainStorm (see its help)
        maxx = max(abs(Results.ImageGridAmp(:)));
        caxis([-maxx maxx])  % Normaize colormapping to global maximum of the current maps, across time
        colorbar    % Display colorbar in figure window
        
    else
        set(hf,'Name',sprintf('essai t = %d',t)) % Alter figure name, showing running time instant
        set(hs,'FaceVertexCData',Results.ImageGridAmp(:,t)) % Alter surface texture, displaying running current map
    end
    
    drawnow % force display for refreshing at each time instant
    
end










