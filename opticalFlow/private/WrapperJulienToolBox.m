function varargout = WrapperJulienToolBox(varargin)
% WRAPPERJULIENTOOLBOX M-file for WrapperJulienToolBox.fig
%      WRAPPERJULIENTOOLBOX, by itself, creates a new WRAPPERJULIENTOOLBOX or raises the existing
%      singleton*.
%
%      H = WRAPPERJULIENTOOLBOX returns the handle to a new WRAPPERJULIENTOOLBOX or the handle to
%      the existing singleton*.
%
%      WRAPPERJULIENTOOLBOX('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in WRAPPERJULIENTOOLBOX.M with the given input arguments.
%
%      WRAPPERJULIENTOOLBOX('Property','Value',...) creates a new WRAPPERJULIENTOOLBOX or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before WrapperJulienToolBox_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to WrapperJulienToolBox_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help WrapperJulienToolBox

% Last Modified by GUIDE v2.5 05-Feb-2008 11:11:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @WrapperJulienToolBox_OpeningFcn, ...
                   'gui_OutputFcn',  @WrapperJulienToolBox_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before WrapperJulienToolBox is made visible.
function WrapperJulienToolBox_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to WrapperJulienToolBox (see VARARGIN)

% Choose default command line output for WrapperJulienToolBox
handles.output = hObject;
handles.input=varargin;
%In the constructor we are just loading MNE information along with
%Tessalation Information (SK:: 10 Jan 2008)
File=handles.input{1}.file1;
load(File);


handles.LastFIle = File;
guidata(hObject,handles)


FV.faces=Faces{1};
FV.vertices=Vertices{1}';
[NFV,remove_vertices]=tessellation_redundancies(FV,1,1e-15);
PARAM.FV.faces=NFV.faces;
PARAM.FV.vertices=NFV.vertices;
handles.good_vertices=setdiff([1:length(FV.vertices)],remove_vertices);
handles.FV=PARAM.FV;

guidata(hObject,handles);



File=handles.input{1}.file2;
        handles.LastFIle = File;
        guidata(hObject,handles)

load(File,'ImageGridAmp','ImageGridTime');

        handles.ImageGridTime = ImageGridTime;
        handles.ImageGridAmp = ImageGridAmp;
        guidata(hObject,handles)
        
temp1=num2str(ImageGridTime(1));
temp2=num2str(ImageGridTime(end));


set( handles.txtStartTime, 'String', temp1);
set( handles.txtEndTime, 'String', temp2);
set( handles.txtStartTimeSampleNumber, 'String', num2str(1));
set( handles.txtEndTimeSampleNumber, 'String', num2str(length(ImageGridTime)));





PARAM.FV=handles.FV;
PARAM.F=double(ImageGridAmp(handles.good_vertices,:));
PARAM.VERBOSE=1;
PARAM.hornschunk=str2num(get(handles.texReguParam,'String'));
PARAM.Time=ImageGridTime;
PARAM.GRAPHE=0;
        handles.PARAM = PARAM;
        set( handles.btnCalculation, 'Enable', 'on');
        guidata(hObject,handles)





% UIWAIT makes WrapperJulienToolBox wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = WrapperJulienToolBox_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in selectTessalation. (Not use any more)
function selectTessalation_Callback(hObject, eventdata, handles)
% hObject    handle to selectTessalation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% [filename, pathname] = uigetfile( ...
%     {'*.mat', 'All MAT-Files (*.mat)'; ...
%         '*.*','All Files (*.*)'}, ...
%     'Select Tessalation data');
% % If "Cancel" is selected then return
% if isequal([filename,pathname],[0,0])
%     return
%     % Otherwise construct the fullfilename and Check and load the file.
% else
%     File = fullfile(pathname,filename);
File=handles.input{1}.file1;
    load(File);
    % if the MAT-file is not valid, do not save the name

        handles.LastFIle = File;
        guidata(hObject,handles)
set( handles.txtTessalation, 'String', File);

FV.faces=Faces{1};
FV.vertices=Vertices{1}';
[NFV,remove_vertices]=tessellation_redundancies(FV,1,1e-15);
PARAM.FV.faces=NFV.faces;
PARAM.FV.vertices=NFV.vertices;
handles.good_vertices=setdiff([1:length(FV.vertices)],remove_vertices);
handles.FV=PARAM.FV;
set( handles.selectMNEData, 'Enable', 'on');
guidata(hObject,handles);




function txtTessalation_Callback(hObject, eventdata, handles)
% hObject    handle to txtTessalation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtTessalation as text
%        str2double(get(hObject,'String')) returns contents of txtTessalation as a double


% --- Executes during object creation, after setting all properties.
function txtTessalation_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtTessalation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in selectMNEData. Not use any more
function selectMNEData_Callback(hObject, eventdata, handles)
% hObject    handle to selectMNEData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% [filename, pathname] = uigetfile( ...
%     {'*.mat', 'All MAT-Files (*.mat)'; ...
%         '*.*','All Files (*.*)'}, ...
%     'Select MNE data');
% % If "Cancel" is selected then return
% if isequal([filename,pathname],[0,0])
%     return
%     % Otherwise construct the fullfilename and Check and load the file.
% else
%     File = fullfile(pathname,filename);
    % if the MAT-file is not valid, do not save the name
File=handles.input{1}.file2;
        handles.LastFIle = File;
        guidata(hObject,handles)
set( handles.txtMNE, 'String', File);
load(File,'ImageGridAmp','ImageGridTime');

        handles.ImageGridTime = ImageGridTime;
        handles.ImageGridAmp = ImageGridAmp;
        guidata(hObject,handles)
        
temp1=num2str(ImageGridTime(1));
temp2=num2str(ImageGridTime(end));


set( handles.txtStartTime, 'String', temp1);
set( handles.txtEndTime, 'String', temp2);
set( handles.txtStartTimeSampleNumber, 'String', num2str(1));
set( handles.txtEndTimeSampleNumber, 'String', num2str(length(ImageGridTime)));





PARAM.FV=handles.FV;
PARAM.F=double(ImageGridAmp(handles.good_vertices,:));
PARAM.VERBOSE=1;
PARAM.hornschunk=str2num(get(handles.texReguParam,'String'));
PARAM.Time=ImageGridTime;
PARAM.GRAPHE=0;
        handles.PARAM = PARAM;
        set( handles.btnCalculation, 'Enable', 'on');
        guidata(hObject,handles)




function txtMNE_Callback(hObject, eventdata, handles)
% hObject    handle to txtMNE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtMNE as text
%        str2double(get(hObject,'String')) returns contents of txtMNE as a double


% --- Executes during object creation, after setting all properties.
function txtMNE_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtMNE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function texReguParam_Callback(hObject, eventdata, handles)
% hObject    handle to texReguParam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of texReguParam as text
%        str2double(get(hObject,'String')) returns contents of texReguParam as a double


% --- Executes during object creation, after setting all properties.
function texReguParam_CreateFcn(hObject, eventdata, handles)
% hObject    handle to texReguParam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtStartTime_Callback(hObject, eventdata, handles)
% hObject    handle to txtStartTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtStartTime as text
%        str2double(get(hObject,'String')) returns contents of txtStartTime as a double


% --- Executes during object creation, after setting all properties.
function txtStartTime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtStartTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtEndTimeSampleNumber_Callback(hObject, eventdata, handles)
% hObject    handle to txtEndTimeSampleNumber (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtEndTimeSampleNumber as text
%        str2double(get(hObject,'String')) returns contents of txtEndTimeSampleNumber as a double
a=str2num(get(hObject,'String'));
set( handles.txtEndTime, 'String', num2str(handles.ImageGridTime(a)));

% --- Executes during object creation, after setting all properties.
function txtEndTimeSampleNumber_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtEndTimeSampleNumber (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtEndTime_Callback(hObject, eventdata, handles)
% hObject    handle to txtEndTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtEndTime as text
%        str2double(get(hObject,'String')) returns contents of txtEndTime as a double


% --- Executes during object creation, after setting all properties.
function txtEndTime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtEndTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtStartTimeSampleNumber_Callback(hObject, eventdata, handles)
% hObject    handle to txtStartTimeSampleNumber (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtStartTimeSampleNumber as text
%        str2double(get(hObject,'String')) returns contents of txtStartTimeSampleNumber as a double
a=str2num(get(hObject,'String'));
set( handles.txtStartTime, 'String', num2str(handles.ImageGridTime(a)));

% --- Executes during object creation, after setting all properties.
function txtStartTimeSampleNumber_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtStartTimeSampleNumber (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnCalculation.
function btnCalculation_Callback(hObject, eventdata, handles)
% hObject    handle to btnCalculation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Just passing 
a=str2num(get(handles.txtStartTimeSampleNumber,'String'));
b=str2num(get(handles.txtEndTimeSampleNumber,'String'));




PARAM=handles.PARAM;
PARAM.Time=PARAM.Time(a:b);
Jflowc=J_analysis_cortex([],PARAM);


PARAM=handles.PARAM;
PARAM.Time=tempTIME(a:b);
Jflowc=J_analysis_cortex([],PARAM);
handles.Jflowc=Jflowc;
handles.Duration=length(PARAM.Time);
guidata(hObject,handles)
% OPTIO900NS.seuilA=0.1;
% OPTIONS.seuilV=0.1;
% OPTIONS.fleche=1;
% OPTIONS.filename='new';
% vizualisation(Jflowc,1:length(PARAM.Time),OPTIONS)
if (get(handles.checKVisualFlow,'Value') == get(handles.checKVisualFlow,'Max'))
[hf,hs,hl]=view_surface('Cortex',PARAM.FV.faces,PARAM.FV.vertices);
hold on
for ii=1:length(PARAM.Time)
    view_surface('Cortex',PARAM.FV.faces,PARAM.FV.vertices,PARAM.F(:,ii));
    hq=quiver3(PARAM.FV.vertices(:,1),PARAM.FV.vertices(:,2),PARAM.FV.vertices(:,3),Jflowc.V(:,1,ii),Jflowc.V(:,2,ii),Jflowc.V(:,3,ii),'g');
    pause(1)
    delete(hq)
end
end
set( handles.btnCalAdvection, 'Enable', 'on');
        guidata(hObject,handles)

function txtAdveciteration_Callback(hObject, eventdata, handles)
% hObject    handle to txtAdveciteration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtAdveciteration as text
%        str2double(get(hObject,'String')) returns contents of txtAdveciteration as a double


% --- Executes during object creation, after setting all properties.
function txtAdveciteration_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtAdveciteration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtAdvecCoff_Callback(hObject, eventdata, handles)
% hObject    handle to txtAdvecCoff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtAdvecCoff as text
%        str2double(get(hObject,'String')) returns contents of txtAdvecCoff as a double


% --- Executes during object creation, after setting all properties.
function txtAdvecCoff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtAdvecCoff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtAdvecStepSize_Callback(hObject, eventdata, handles)
% hObject    handle to txtAdvecStepSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtAdvecStepSize as text
%        str2double(get(hObject,'String')) returns contents of txtAdvecStepSize as a double


% --- Executes during object creation, after setting all properties.
function txtAdvecStepSize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtAdvecStepSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnCalAdvection.
function btnCalAdvection_Callback(hObject, eventdata, handles)
% hObject    handle to btnCalAdvection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
flowc.V=handles.Jflowc.V(:,:,1);
flowc.faces=handles.FV.faces;
flowc.vertices=handles.FV.vertices;
a=str2num(get(handles.txtStartTimeSampleNumber,'String'));
[I_pred,M,R,A1,A2,A3]=calcul_advection2(handles.PARAM.F(:,a),flowc,str2num(get(handles.txtAdveciteration,'String')),str2num(get(handles.txtAdvecStepSize,'String')),str2num(get(handles.txtAdvecCoff,'String')));


%visualization
if (get(handles.checkvisuadvec,'Value') == get(handles.checkvisuadvec,'Max'))
[hf,hs,hl]=view_surface('Advection',handles.FV.faces,handles.FV.vertices,handles.PARAM.F(:,a));
hold on
quiver3(handles.FV.vertices(:,1),handles.FV.vertices(:,2),handles.FV.vertices(:,3),flowc.V(:,1),flowc.V(:,2),flowc.V(:,3),'g')
h=text(30,50,'Step 1');
for ii=1:str2num(get(handles.txtAdveciteration,'String'))
    set(hs,'FaceVertexCData',I_pred(:,ii))
    if mod(ii,5)==0
        set(h,'String',['Step ', num2str(ii)])
    end
    pause(1)
end
end

% --- Executes on button press in tabOpticalFlow.
function tabOpticalFlow_Callback(hObject, eventdata, handles)
% hObject    handle to tabOpticalFlow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set( handles.panFlow, 'Visible', 'on');
set( handles.panAdvec, 'Visible', 'off');
set( handles.panMicro, 'Visible', 'off');

% --- Executes on button press in tabAdvection.
function tabAdvection_Callback(hObject, eventdata, handles)
% hObject    handle to tabAdvection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set( handles.panFlow, 'Visible', 'off');
set( handles.panAdvec, 'Visible', 'on');
set( handles.panMicro, 'Visible', 'off');

% --- Executes on button press in tabMicrostates.
function tabMicrostates_Callback(hObject, eventdata, handles)
% hObject    handle to tabMicrostates (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set( handles.panFlow, 'Visible', 'off');
set( handles.panAdvec, 'Visible', 'off');
set( handles.panMicro, 'Visible', 'on');




% --- Executes on button press in btnCalcMicroState.
function btnCalcMicroState_Callback(hObject, eventdata, handles)
% hObject    handle to btnCalcMicroState (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[ord,thres2b,stablestate,stable_borders,diffMm]=microstate_seg4(handles.Jflowc,str2double(get(handles.txtthrehmicro,'String')),'old');


% --- Executes on button press in btnSelectMicrostate.
function btnSelectMicrostate_Callback(hObject, eventdata, handles)
% hObject    handle to btnSelectMicrostate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uigetfile( ...
    {'*.mat', 'All MAT-Files (*.mat)'; ...
        '*.*','All Files (*.*)'}, ...
    'Select Tessalation data');
% If "Cancel" is selected then return
if isequal([filename,pathname],[0,0])
    return
    % Otherwise construct the fullfilename and Check and load the file.
else
    File = fullfile(pathname,filename);
    load(File);
    % if the MAT-file is not valid, do not save the name

        handles.LastFIle = File;
         handles.FlowScalp=FlowScalp;
        guidata(hObject,handles)
set( handles.txtMicroState, 'String', filename);
end


function txtMicroState_Callback(hObject, eventdata, handles)
% hObject    handle to txtMicroState (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtMicroState as text
%        str2double(get(hObject,'String')) returns contents of txtMicroState as a double


% --- Executes during object creation, after setting all properties.
function txtMicroState_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtMicroState (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on slider movement.
function sliderMicroSmothing_Callback(hObject, eventdata, handles)
% hObject    handle to sliderMicroSmothing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

slider_value_Amplitude = get(handles.sliderMicroAmplitude,'Value')/10
slider_value_Smothing = get(handles.sliderMicroSmothing,'Value')
y=sqrt(handles.FlowScalp{1,2}.de).*100000;
x=y;
len_x = length(x);
fltr=[1 1 1]/3;
x1=x(1); x2=x(len_x); 

	for jj=1:slider_value_Smothing+1,
	c=conv(fltr,x);
	x=c(2:len_x+1);
	x(1)=x1;  
        x(len_x)=x2; 
	end

microplot=plot(x);
[maxtab, mintab] = peakdet(x, slider_value_Amplitude+0.0000000001);
hold on; plot(mintab(:,1), mintab(:,2), 'g*');
hold off
set( handles.txtMicroNumber, 'String', num2str(length(mintab)));

% --- Executes during object creation, after setting all properties.
function sliderMicroSmothing_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderMicroSmothing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function sliderMicroAmplitude_Callback(hObject, eventdata, handles)
% hObject    handle to sliderMicroAmplitude (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

slider_value_Amplitude = get(handles.sliderMicroAmplitude,'Value')/10
slider_value_Smothing = get(handles.sliderMicroSmothing,'Value')
y=sqrt(handles.FlowScalp{1,2}.de).*100000;
x=y;
len_x = length(x);
fltr=[1 1 1]/3;
x1=x(1); x2=x(len_x); 

	for jj=1:slider_value_Smothing+1,
	c=conv(fltr,x);
	x=c(2:len_x+1);
	x(1)=x1;  
        x(len_x)=x2; 
	end

microplot=plot(x);
[maxtab, mintab] = peakdet(x, slider_value_Amplitude+0.0000000001);
hold on; plot(mintab(:,1), mintab(:,2), 'g*');
hold off
set( handles.txtMicroNumber, 'String', num2str(length(mintab)));

% --- Executes during object creation, after setting all properties.
function sliderMicroAmplitude_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderMicroAmplitude (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end





function txtMicroNumber_Callback(hObject, eventdata, handles)
% hObject    handle to txtMicroNumber (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtMicroNumber as text
%        str2double(get(hObject,'String')) returns contents of txtMicroNumber as a double


% --- Executes during object creation, after setting all properties.
function txtMicroNumber_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtMicroNumber (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





function txtthrehmicro_Callback(hObject, eventdata, handles)
% hObject    handle to txtthrehmicro (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtthrehmicro as text
%        str2double(get(hObject,'String')) returns contents of txtthrehmicro as a double


% --- Executes during object creation, after setting all properties.
function txtthrehmicro_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtthrehmicro (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on button press in checKVisualFlow.
function checKVisualFlow_Callback(hObject, eventdata, handles)
% hObject    handle to checKVisualFlow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checKVisualFlow




% --- Executes on button press in checkvisuadvec.
function checkvisuadvec_Callback(hObject, eventdata, handles)
% hObject    handle to checkvisuadvec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkvisuadvec


