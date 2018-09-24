function varargout = HHD_GUI(varargin)
% HHD_GUI M-file for HHD_GUI.fig
%      HHD_GUI, by itself, creates a new HHD_GUI or raises the existing
%      singleton*.
%
%      H = HHD_GUI returns the handle to a new HHD_GUI or the handle to
%      the existing singleton*.
%
%      HHD_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in HHD_GUI.M with the given input arguments.
%
%      HHD_GUI('Property','Value',...) creates a new HHD_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before HHD_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to HHD_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help HHD_GUI

% Last Modified by GUIDE v2.5 15-Oct-2008 14:38:49

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @HHD_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @HHD_GUI_OutputFcn, ...
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


% --- Executes just before HHD_GUI is made visible.
function HHD_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to HHD_GUI (see VARARGIN)

% Choose default command line output for HHD_GUI

handles.output = hObject;
handles.input=varargin;
File=handles.input{1}.file2;
handles.ImagingFIle = File;
guidata(hObject,handles)
% Update handles structure


% UIWAIT makes HHD_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);
% [filename, pathname] = uigetfile( ...
%     {'*.mat', 'All MAT-Files (*.mat)'; ...
%         '*.*','All Files (*.*)'}, ...
%     'Select Imaging data e.g. Minimum norm data');
% % If "Cancel" is selected then return
% if isequal([filename,pathname],[0,0])
%     return
%     % Otherwise construct the fullfilename and Check and load the file.
% else
%     File = fullfile(pathname,filename);
% end
%         handles.ImagingFIle = File;
%         guidata(hObject,handles)
% set( handles.editImgData, 'String', filename);
load(File, 'ImageGridTime');

set( handles.editdur1, 'String', num2str(1));
set( handles.editdur2, 'String', num2str(length(ImageGridTime)));
        handles.check= 0;
        handles.Time1= 1;
        handles.Time2= length(ImageGridTime);
        guidata(hObject,handles)


set( handles.editTime1, 'String', num2str((ImageGridTime(1))));
set( handles.editTime2, 'String', num2str((ImageGridTime(end))));
clear ImageGridTime
set(handles.btnOpticalFlow,'Enable','on')
set(handles.btnHHD,'Enable','on')
set(handles.btnVisulization,'Enable','on')
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
% end
     File=handles.input{1}.file1;   
handles.TessFIle = File;
        guidata(hObject,handles)
% set( handles.editIMGsupport, 'String', filename);
guidata(hObject, handles);
% --- Outputs from this function are returned to the command line.
function varargout = HHD_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function editIMGsupport_Callback(hObject, eventdata, handles)
% hObject    handle to editIMGsupport (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editIMGsupport as text
%        str2double(get(hObject,'String')) returns contents of editIMGsupport as a double


% --- Executes during object creation, after setting all properties.
function editIMGsupport_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editIMGsupport (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btIMGsupport.
function btIMGsupport_Callback(hObject, eventdata, handles)
% hObject    handle to btIMGsupport (see GCBO)
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
% end
%         handles.TessFIle = File;
%         guidata(hObject,handles)
% set( handles.editIMGsupport, 'String', filename);

function editImgData_Callback(hObject, eventdata, handles)
% hObject    handle to editImgData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editImgData as text
%        str2double(get(hObject,'String')) returns contents of editImgData as a double


% --- Executes during object creation, after setting all properties.
function editImgData_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editImgData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in bttImgData.
function bttImgData_Callback(hObject, eventdata, handles)
% hObject    handle to bttImgData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% [filename, pathname] = uigetfile( ...
%     {'*.mat', 'All MAT-Files (*.mat)'; ...
%         '*.*','All Files (*.*)'}, ...
%     'Select Imaging data e.g. Minimum norm data');
% % If "Cancel" is selected then return
% if isequal([filename,pathname],[0,0])
%     return
%     % Otherwise construct the fullfilename and Check and load the file.
% else
%     File = fullfile(pathname,filename);
% end
%         handles.ImagingFIle = File;
%         guidata(hObject,handles)
% set( handles.editImgData, 'String', filename);
% load(File, 'ImageGridTime');
% 
% set( handles.editdur1, 'String', num2str(1));
% set( handles.editdur2, 'String', num2str(length(ImageGridTime)));
%         handles.check= 0;
%         handles.Time1= 1;
%         handles.Time2= length(ImageGridTime);
%         guidata(hObject,handles)
% 
% 
% set( handles.editTime1, 'String', num2str((ImageGridTime(1))));
% set( handles.editTime2, 'String', num2str((ImageGridTime(end))));
% clear ImageGridTime


% --- Executes on button press in btnFlow.
function btnFlow_Callback(hObject, eventdata, handles)
% hObject    handle to btnFlow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanelHHD,'Visible','off')
set(handles.uipanelFlow,'Visible','on')
set(handles.uipanelVisulization1,'Visible','off')

% --- Executes on button press in btnHHD.
function btnHHD_Callback(hObject, eventdata, handles)
% hObject    handle to btnHHD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanelHHD,'Visible','on')
set(handles.uipanelFlow,'Visible','off')
set(handles.uipanelVisulization1,'Visible','off')
% --- Executes on button press in btnVisulization.
function btnVisulization_Callback(hObject, eventdata, handles)
% hObject    handle to btnVisulization (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanelHHD,'Visible','off')
set(handles.uipanelFlow,'Visible','off')
set(handles.uipanelVisulization1,'Visible','on')

% --------------------------------------------------------------------
function File_Callback(hObject, eventdata, handles)
% hObject    handle to File (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Help_Callback(hObject, eventdata, handles)
% hObject    handle to Help (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msgbox('Comming soon')

% --------------------------------------------------------------------
function Select_Tessalation_Callback(hObject, eventdata, handles)
% hObject    handle to Select_Tessalation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
btIMGsupport_Callback(hObject, eventdata, handles);

% --------------------------------------------------------------------
function Select_Imaging_Callback(hObject, eventdata, handles)
% hObject    handle to Select_Imaging (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
bttImgData_Callback(hObject, eventdata, handles)

% --------------------------------------------------------------------
function Exit_Callback(hObject, eventdata, handles)
% hObject    handle to Exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
   ButtonName = questdlg('Are you sure to Exit?', ...
                         'Exit', ...
                         'Yes', 'No','No');
   switch ButtonName,
     case 'Yes',
      clear all
      clc
      close all
     case 'No',
      return;
   end % switch


function edithornschunk_Callback(hObject, eventdata, handles)
% hObject    handle to edithornschunk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edithornschunk as text
%        str2double(get(hObject,'String')) returns contents of edithornschunk as a double


% --- Executes during object creation, after setting all properties.
function edithornschunk_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edithornschunk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editdur1_Callback(hObject, eventdata, handles)
% hObject    handle to editdur1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editdur1 as text
%        str2double(get(hObject,'String')) returns contents of editdur1 as a double
load(handles.ImagingFIle, 'ImageGridTime');
        handles.Time1= str2double(get( handles.editdur1, 'String'));
        guidata(hObject,handles)
if str2double(get( handles.editdur1, 'String'))<= length(ImageGridTime) && str2double(get( handles.editdur1, 'String')) >0
set( handles.editTime1, 'String', num2str((ImageGridTime(str2double(get( handles.editdur1, 'String'))))));
end
clear ImageGridTime

% --- Executes during object creation, after setting all properties.
function editdur1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editdur1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editdur2_Callback(hObject, eventdata, handles)
% hObject    handle to editdur2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editdur2 as text
%        str2double(get(hObject,'String')) returns contents of editdur2 as a double
load(handles.ImagingFIle, 'ImageGridTime');
        handles.Time2= str2double(get( handles.editdur2, 'String'));
        guidata(hObject,handles)
if str2double(get( handles.editdur2, 'String'))<= length(ImageGridTime) && str2double(get( handles.editdur2, 'String')) >0
set( handles.editTime2, 'String', num2str((ImageGridTime(str2double(get( handles.editdur2, 'String'))))));
end
clear ImageGridTime


% --- Executes during object creation, after setting all properties.
function editdur2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editdur2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on button press in btnOpticalFlow.
function btnOpticalFlow_Callback(hObject, eventdata, handles)
% hObject    handle to btnOpticalFlow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global flow

load(handles.TessFIle,'Faces', 'Vertices')
load(handles.ImagingFIle,'ImageGridAmp', 'ImageGridTime')
% check=1;
% for i=1:length(Vertices)
% if size(Vertices{1},2)==size(ImageGridAmp,1)
% check=0;
FV.faces=Faces{1};
FV.vertices=Vertices{1}';
clear Faces vertices
[NFV,remove_vertices]=tessellation_redundancies(FV,1,1e-15);
PARAM.FV.faces=NFV.faces;
PARAM.FV.vertices=NFV.vertices;
clear NFV
good_vertices=setdiff([1:length(FV.vertices)],remove_vertices);
ImageGridAmp=ImageGridAmp(good_vertices,:);
clear FV good_vertices remove_vertices
PARAM.F=abs(double(ImageGridAmp));
clear ImageGridAmp 
PARAM.VERBOSE=1;
PARAM.hornschunk=0.01;
% PARAM.Time=[1 2 3 4 5 6 7 8];
PARAM.Time=str2double(get( handles.editdur1, 'String')):str2double(get( handles.editdur2, 'String'));

PARAM.GRAPHE=0;
% clear ImageGridAmp tess2mri_interp

Jflowc=J_analysis_cortex([],PARAM);  
clear PARAM

flow.t=Jflowc.t;
flow.vertices=Jflowc.vertices;
flow.faces=Jflowc.faces;
flow.V=Jflowc.V;
flow.de=Jflowc.de;
flow.F=Jflowc.F;
clear Jflowc
% handles.flow=flow;
% guidata(hObject,handles)
% clear flow



% end
% end
% if check
% msgbox('Imaging Data and Imaging Support do not match, select different files')
% end

set( handles.editStepHHD1, 'String', num2str((flow.t(1))));
set( handles.editStepHHD2, 'String', num2str((flow.t(end))));

set( handles.editTimeHHD1, 'String', num2str(ImageGridTime(flow.t(1))));
set( handles.editTimeHHD2, 'String', num2str(ImageGridTime(flow.t(end))));
clear ImageGridTime
load(handles.ImagingFIle, 'ImageGridTime');
index=str2double(get( handles.editdur1, 'String')):str2double(get( handles.editdur2, 'String'));
set( handles.editStepVisu1, 'String', num2str(index(1)));
set( handles.editStepVisu2, 'String', num2str(index(end)));
set( handles.editTimeVisu1, 'String', num2str((ImageGridTime(index(1)))));
set( handles.editTimeVisu2, 'String', num2str((ImageGridTime(index(end)))));
set( handles.editVisuStep, 'String', num2str(index(1)));
set( handles.editVisuTime, 'String', num2str((ImageGridTime(index(1)))));
set(handles.btnOpticalFlow,'Enable','on')
set(handles.btnHHD,'Enable','on')
set(handles.btnVisulization,'Enable','on')






function editTime1_Callback(hObject, eventdata, handles)
% hObject    handle to editTime1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editTime1 as text
%        str2double(get(hObject,'String')) returns contents of editTime1 as a double


% --- Executes during object creation, after setting all properties.
function editTime1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editTime1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editTime2_Callback(hObject, eventdata, handles)
% hObject    handle to editTime2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editTime2 as text
%        str2double(get(hObject,'String')) returns contents of editTime2 as a double


% --- Executes during object creation, after setting all properties.
function editTime2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editTime2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editRecur_Callback(hObject, eventdata, handles)
% hObject    handle to editRecur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editRecur as text
%        str2double(get(hObject,'String')) returns contents of editRecur as a double


% --- Executes during object creation, after setting all properties.
function editRecur_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editRecur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editStepHHD1_Callback(hObject, eventdata, handles)
% hObject    handle to editStepHHD1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editStepHHD1 as text
%        str2double(get(hObject,'String')) returns contents of editStepHHD1 as a double
global flow
load(handles.ImagingFIle, 'ImageGridTime');

if str2double(get( handles.editStepHHD1, 'String'))<= flow.t(end) && str2double(get( handles.editStepHHD1, 'String')) >=flow.t(1)
set( handles.editTimeHHD1, 'String', num2str((ImageGridTime(str2double(get( handles.editStepHHD1, 'String'))))));
else
    msgbox(strcat('Select Steps Between','...',num2str(flow.t(1)),'-',num2str(flow.t(end))));
end
clear ImageGridTime

% --- Executes during object creation, after setting all properties.
function editStepHHD1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editStepHHD1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editStepHHD2_Callback(hObject, eventdata, handles)
% hObject    handle to editStepHHD2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editStepHHD2 as text
%        str2double(get(hObject,'String')) returns contents of editStepHHD2 as a double
global flow
load(handles.ImagingFIle, 'ImageGridTime');
if str2double(get( handles.editStepHHD2, 'String'))<= flow.t(end) && str2double(get( handles.editStepHHD2, 'String')) >=flow.t(1)
set( handles.editTimeHHD2, 'String', num2str((ImageGridTime(str2double(get( handles.editStepHHD2, 'String'))))));
else
    msgbox(strcat('Select Steps Between','...',num2str(flow.t(1)),'-',num2str(flow.t(end))));
end
clear ImageGridTime

% --- Executes during object creation, after setting all properties.
function editStepHHD2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editStepHHD2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnCalcHHD.
function btnCalcHHD_Callback(hObject, eventdata, handles)
% hObject    handle to btnCalcHHD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% set(handles.btnCalcHHD,'Enable','off')
global flow
global U V H Vcurl Vdiv index
[U V H Vcurl Vdiv index]=hhdr_recursive(flow,str2double(get( handles.editRecur, 'String')),str2double(get( handles.editStepHHD1, 'String')):str2double(get( handles.editStepHHD2, 'String')));
%         handles.U= U;
%         handles.V= V;
%         handles.H= H;
%         handles.Vcurl= Vcurl;
%         handles.Vdiv= Vdiv;
% 
%         guidata(hObject,handles)
msgbox('HHD calculation Finished :)')
set(handles.btnCalcHHD,'Enable','on')


load(handles.ImagingFIle, 'ImageGridTime');

set( handles.editStepVisu1, 'String', num2str(index(1)));
set( handles.editStepVisu2, 'String', num2str(index(end)));
set( handles.editTimeVisu1, 'String', num2str((ImageGridTime(index(1)))));
set( handles.editTimeVisu2, 'String', num2str((ImageGridTime(index(end)))));
set( handles.editVisuStep, 'String', num2str(index(1)));
set( handles.editVisuTime, 'String', num2str((ImageGridTime(index(1)))));
clear ImageGridTime




function editTimeHHD1_Callback(hObject, eventdata, handles)
% hObject    handle to editTimeHHD1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editTimeHHD1 as text
%        str2double(get(hObject,'String')) returns contents of editTimeHHD1 as a double


% --- Executes during object creation, after setting all properties.
function editTimeHHD1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editTimeHHD1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editTimeHHD2_Callback(hObject, eventdata, handles)
% hObject    handle to editTimeHHD2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editTimeHHD2 as text
%        str2double(get(hObject,'String')) returns contents of editTimeHHD2 as a double


% --- Executes during object creation, after setting all properties.
function editTimeHHD2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editTimeHHD2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit15_Callback(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit15 as text
%        str2double(get(hObject,'String')) returns contents of edit15 as a double


% --- Executes during object creation, after setting all properties.
function edit15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit16_Callback(hObject, eventdata, handles)
% hObject    handle to edit16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit16 as text
%        str2double(get(hObject,'String')) returns contents of edit16 as a double


% --- Executes during object creation, after setting all properties.
function edit16_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit17_Callback(hObject, eventdata, handles)
% hObject    handle to edit17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit17 as text
%        str2double(get(hObject,'String')) returns contents of edit17 as a double


% --- Executes during object creation, after setting all properties.
function edit17_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit18_Callback(hObject, eventdata, handles)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit18 as text
%        str2double(get(hObject,'String')) returns contents of edit18 as a double


% --- Executes during object creation, after setting all properties.
function edit18_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit19_Callback(hObject, eventdata, handles)
% hObject    handle to edit19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit19 as text
%        str2double(get(hObject,'String')) returns contents of edit19 as a double


% --- Executes during object creation, after setting all properties.
function edit19_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editStepVisu1_Callback(hObject, eventdata, handles)
% hObject    handle to editStepVisu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editStepVisu1 as text
%        str2double(get(hObject,'String')) returns contents of editStepVisu1 as a double


% --- Executes during object creation, after setting all properties.
function editStepVisu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editStepVisu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editStepVisu2_Callback(hObject, eventdata, handles)
% hObject    handle to editStepVisu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editStepVisu2 as text
%        str2double(get(hObject,'String')) returns contents of editStepVisu2 as a double


% --- Executes during object creation, after setting all properties.
function editStepVisu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editStepVisu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnVisu.
function btnVisu_Callback(hObject, eventdata, handles)
% hObject    handle to btnVisu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% switch get(handles.uipanelScalar,'Tag')   % Get Tag of selected object
%     case 'radiobuttonCurrent'
%         msgbox('1')
%     case 'radiobuttonU'
%         msgbox('2')
%     case 'radiobuttonV'
% msgbox('3')
%     otherwise
%       msgbox('4')
% end


function editTimeVisu1_Callback(hObject, eventdata, handles)
% hObject    handle to editTimeVisu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editTimeVisu1 as text
%        str2double(get(hObject,'String')) returns contents of editTimeVisu1 as a double


% --- Executes during object creation, after setting all properties.
function editTimeVisu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editTimeVisu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editTimeVisu2_Callback(hObject, eventdata, handles)
% hObject    handle to editTimeVisu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editTimeVisu2 as text
%        str2double(get(hObject,'String')) returns contents of editTimeVisu2 as a double


% --- Executes during object creation, after setting all properties.
function editTimeVisu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editTimeVisu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnLeftVisuMove.
function btnLeftVisuMove_Callback(hObject, eventdata, handles)
% hObject    handle to btnLeftVisuMove (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global U V H Vcurl Vdiv index flow

IndexNum=str2double(get( handles.editVisuStep, 'String'));
IndexNum=IndexNum-1;





if IndexNum  >=  index(1)
load(handles.ImagingFIle,'ImageGridTime')


set( handles.editVisuStep, 'String', num2str(IndexNum));
set( handles.editVisuTime, 'String', num2str((ImageGridTime(IndexNum))));


    
if (get(handles.radiobuttonCurrent,'Value') == get(hObject,'Max'))
	    
    if (get(handles.radiobuttonOpticalFlow,'Value') == get(hObject,'Max'))
        
        if handles.check && ishandle(handles.hq)
            delete(handles.hq)
        end
    H=view_surface('Surface',flow.faces,flow.vertices,flow.F(:,IndexNum-(index(1)-1)));
    hold on
    hq=quiver3(flow.vertices(:,1),flow.vertices(:,2),flow.vertices(:,3),flow.V(:,1,IndexNum-(index(1)-1)),flow.V(:,2,IndexNum-(index(1)-1)),flow.V(:,3,IndexNum-(index(1)-1)),3,'g');
    handles.check=1;             
    handles.hq= hq;
    guidata(hObject,handles)
        
      
    
    elseif (get(handles.radiobuttonVdiv,'Value') == get(hObject,'Max'))
       	           
        if handles.check
            delete(handles.hq)
        end
     H=view_surface('Surface',flow.faces,flow.vertices,flow.F(:,IndexNum-(index(1)-1)));
     hold on
     hq=quiver3(flow.vertices(:,1),flow.vertices(:,2),flow.vertices(:,3),Vdiv(:,1,IndexNum-(index(1)-1)),Vdiv(:,2,IndexNum-(index(1)-1)),Vdiv(:,3,IndexNum-(index(1)-1)),3,'g');
     handles.check=1;             
     handles.hq= hq;
     guidata(hObject,handles)

    elseif (get(handles.radiobuttonVcurl,'Value') == get(hObject,'Max'))
        
            
        if handles.check
            delete(handles.hq)
        end
     H=view_surface('Surface',flow.faces,flow.vertices,flow.F(:,IndexNum-(index(1)-1)));
     hold on
     hq=quiver3(flow.vertices(:,1),flow.vertices(:,2),flow.vertices(:,3),Vcurl(:,1,IndexNum-(index(1)-1)),Vcurl(:,2,IndexNum-(index(1)-1)),Vcurl(:,3,IndexNum-(index(1)-1)),3,'g');
     handles.check=1;             
     handles.hq= hq;
     guidata(hObject,handles)   
            
            
            
    elseif (get(handles.radiobuttonH,'Value') == get(hObject,'Max'))
        
        if handles.check
        delete(handles.hq)
        end
    H=view_surface('Surface',flow.faces,flow.vertices,flow.F(:,IndexNum-(index(1)-1)));
    hold on
    hq=quiver3(flow.vertices(:,1),flow.vertices(:,2),flow.vertices(:,3),H(:,1,IndexNum-(index(1)-1)),H(:,2,IndexNum-(index(1)-1)),H(:,3,IndexNum-(index(1)-1)),3,'g');
    handles.check=1;             
    handles.hq= hq;
    guidata(hObject,handles)   
            
           
   elseif (get(handles.radiobuttonVectorNone,'Value') == get(hObject,'Max'))
        
        if handles.check
        delete(handles.hq)
        end
    H=view_surface('Surface',flow.faces,flow.vertices,flow.F(:,IndexNum-(index(1)-1)));
    handles.check=0;             
    guidata(hObject,handles)  
            
            
            
    end % vector field
   
    
elseif (get(handles.radiobuttonU,'Value') == get(hObject,'Max'))
    if (get(handles.radiobuttonOpticalFlow,'Value') == get(hObject,'Max'))
        
        if handles.check
            delete(handles.hq)
        end
    H=view_surface('Surface',flow.faces,flow.vertices,U(:,IndexNum-(index(1)-1)));
    hold on
    hq=quiver3(flow.vertices(:,1),flow.vertices(:,2),flow.vertices(:,3),flow.V(:,1,IndexNum-(index(1)-1)),flow.V(:,2,IndexNum-(index(1)-1)),flow.V(:,3,IndexNum-(index(1)-1)),3,'g');
    handles.check=1;             
    handles.hq= hq;
    guidata(hObject,handles)
        
      
    
    elseif (get(handles.radiobuttonVdiv,'Value') == get(hObject,'Max'))
       	           
        if handles.check
            delete(handles.hq)
        end
     H=view_surface('Surface',flow.faces,flow.vertices,U(:,IndexNum-(index(1)-1)));
     hold on
     hq=quiver3(flow.vertices(:,1),flow.vertices(:,2),flow.vertices(:,3),Vdiv(:,1,IndexNum-(index(1)-1)),Vdiv(:,2,IndexNum-(index(1)-1)),Vdiv(:,3,IndexNum-(index(1)-1)),3,'g');
     handles.check=1;             
     handles.hq= hq;
     guidata(hObject,handles)

    elseif (get(handles.radiobuttonVcurl,'Value') == get(hObject,'Max'))
        
            
        if handles.check
            delete(handles.hq)
        end
     H=view_surface('Surface',flow.faces,flow.vertices,U(:,IndexNum-(index(1)-1)));
     hold on
     hq=quiver3(flow.vertices(:,1),flow.vertices(:,2),flow.vertices(:,3),Vcurl(:,1,IndexNum-(index(1)-1)),Vcurl(:,2,IndexNum-(index(1)-1)),Vcurl(:,3,IndexNum-(index(1)-1)),3,'g');
     handles.check=1;             
     handles.hq= hq;
     guidata(hObject,handles)   
            
            
            
    elseif (get(handles.radiobuttonH,'Value') == get(hObject,'Max'))
        
        if handles.check
        delete(handles.hq)
        end
    H=view_surface('Surface',flow.faces,flow.vertices,U(:,IndexNum-(index(1)-1)));
    hold on
    hq=quiver3(flow.vertices(:,1),flow.vertices(:,2),flow.vertices(:,3),H(:,1,IndexNum-(index(1)-1)),H(:,2,IndexNum-(index(1)-1)),H(:,3,IndexNum-(index(1)-1)),3,'g');
    handles.check=1;             
    handles.hq= hq;
    guidata(hObject,handles)   
            
           
   elseif (get(handles.radiobuttonVectorNone,'Value') == get(hObject,'Max'))
        
        if handles.check
        delete(handles.hq)
        end
    H=view_surface('Surface',flow.faces,flow.vertices,U(:,IndexNum-(index(1)-1)));
    handles.check=0;             
    guidata(hObject,handles)  
           
   end % vector field
   
   
elseif (get(handles.radiobuttonV,'Value') == get(hObject,'Max'))
    if (get(handles.radiobuttonOpticalFlow,'Value') == get(hObject,'Max'))
        
        if handles.check
            delete(handles.hq)
        end
    H=view_surface('Surface',flow.faces,flow.vertices,V(:,IndexNum-(index(1)-1)));
    hold on
    hq=quiver3(flow.vertices(:,1),flow.vertices(:,2),flow.vertices(:,3),flow.V(:,1,IndexNum-(index(1)-1)),flow.V(:,2,IndexNum-(index(1)-1)),flow.V(:,3,IndexNum-(index(1)-1)),3,'g');
    handles.check=1;             
    handles.hq= hq;
    guidata(hObject,handles)
        
      
    
    elseif (get(handles.radiobuttonVdiv,'Value') == get(hObject,'Max'))
       	           
        if handles.check
            delete(handles.hq)
        end
     H=view_surface('Surface',flow.faces,flow.vertices,V(:,IndexNum-(index(1)-1)));
     hold on
     hq=quiver3(flow.vertices(:,1),flow.vertices(:,2),flow.vertices(:,3),Vdiv(:,1,IndexNum-(index(1)-1)),Vdiv(:,2,IndexNum-(index(1)-1)),Vdiv(:,3,IndexNum-(index(1)-1)),3,'g');
     handles.check=1;             
     handles.hq= hq;
     guidata(hObject,handles)

    elseif (get(handles.radiobuttonVcurl,'Value') == get(hObject,'Max'))
        
            
        if handles.check
            delete(handles.hq)
        end
     H=view_surface('Surface',flow.faces,flow.vertices,V(:,IndexNum-(index(1)-1)));
     hold on
     hq=quiver3(flow.vertices(:,1),flow.vertices(:,2),flow.vertices(:,3),Vcurl(:,1,IndexNum-(index(1)-1)),Vcurl(:,2,IndexNum-(index(1)-1)),Vcurl(:,3,IndexNum-(index(1)-1)),3,'g');
     handles.check=1;             
     handles.hq= hq;
     guidata(hObject,handles)   
            
            
            
    elseif (get(handles.radiobuttonH,'Value') == get(hObject,'Max'))
        
        if handles.check && ishandle(handles.hq)
        delete(handles.hq)
        end
    H=view_surface('Surface',flow.faces,flow.vertices,V(:,IndexNum-(index(1)-1)));
    hold on
    hq=quiver3(flow.vertices(:,1),flow.vertices(:,2),flow.vertices(:,3),H(:,1,IndexNum-(index(1)-1)),H(:,2,IndexNum-(index(1)-1)),H(:,3,IndexNum-(index(1)-1)),3,'g');
    handles.check=1;             
    handles.hq= hq;
    guidata(hObject,handles)   
            
           
   elseif (get(handles.radiobuttonVectorNone,'Value') == get(hObject,'Max'))
        
        if handles.check && ishandle(handles.hq) && ishandle(handles.hq)
        delete(handles.hq)
        end
    H=view_surface('Surface',flow.faces,flow.vertices,V(:,IndexNum-(index(1)-1)));
    handles.check=0;             
    guidata(hObject,handles)  
            
            
            
    end % vector field
    
    
    
elseif (get(handles.radiobuttonScalarNone,'Value') == get(hObject,'Max'))
    if (get(handles.radiobuttonOpticalFlow,'Value') == get(hObject,'Max'))
        
        if handles.check && ishandle(handles.hq) && ishandle(handles.hq)
            delete(handles.hq)
        end
    H=view_surface('Surface',flow.faces,flow.vertices);
    hold on
    hq=quiver3(flow.vertices(:,1),flow.vertices(:,2),flow.vertices(:,3),flow.V(:,1,IndexNum-(index(1)-1)),flow.V(:,2,IndexNum-(index(1)-1)),flow.V(:,3,IndexNum-(index(1)-1)),3,'g');
    handles.check=1;             
    handles.hq= hq;
    guidata(hObject,handles)
        
      
    
    elseif (get(handles.radiobuttonVdiv,'Value') == get(hObject,'Max'))
       	           
        if handles.check && ishandle(handles.hq) && ishandle(handles.hq)
            delete(handles.hq)
        end
     H=view_surface('Surface',flow.faces,flow.vertices);
     hold on
     hq=quiver3(flow.vertices(:,1),flow.vertices(:,2),flow.vertices(:,3),Vdiv(:,1,IndexNum-(index(1)-1)),Vdiv(:,2,IndexNum-(index(1)-1)),Vdiv(:,3,IndexNum-(index(1)-1)),3,'g');
     handles.check=1;             
     handles.hq= hq;
     guidata(hObject,handles)

    elseif (get(handles.radiobuttonVcurl,'Value') == get(hObject,'Max'))
        
            
        if handles.check && ishandle(handles.hq) && ishandle(handles.hq)
            delete(handles.hq)
        end
     H=view_surface('Surface',flow.faces,flow.vertices);
     hold on
     hq=quiver3(flow.vertices(:,1),flow.vertices(:,2),flow.vertices(:,3),Vcurl(:,1,IndexNum-(index(1)-1)),Vcurl(:,2,IndexNum-(index(1)-1)),Vcurl(:,3,IndexNum-(index(1)-1)),3,'g');
     handles.check=1;             
     handles.hq= hq;
     guidata(hObject,handles)   
            
            
            
    elseif (get(handles.radiobuttonH,'Value') == get(hObject,'Max'))
        
        if handles.check && ishandle(handles.hq) && ishandle(handles.hq)
        delete(handles.hq)
        end
    H=view_surface('Surface',flow.faces,flow.vertices);
    hold on
    hq=quiver3(flow.vertices(:,1),flow.vertices(:,2),flow.vertices(:,3),H(:,1,IndexNum-(index(1)-1)),H(:,2,IndexNum-(index(1)-1)),H(:,3,IndexNum-(index(1)-1)),3,'g');
    handles.check=1;             
    handles.hq= hq;
    guidata(hObject,handles)   
            
           
   elseif (get(handles.radiobuttonVectorNone,'Value') == get(hObject,'Max'))
        
        if handles.check && ishandle(handles.hq) && ishandle(handles.hq)
        delete(handles.hq)
        end
    H=view_surface('Surface',flow.faces,flow.vertices);
    handles.check=0;             
    guidata(hObject,handles)  
            
            
            
    end % vector field

end
end
% --- Executes on button press in btnRightVisuMove.
function btnRightVisuMove_Callback(hObject, eventdata, handles)
% hObject    handle to btnRightVisuMove (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global U V H Vcurl Vdiv index flow

IndexNum=str2double(get( handles.editVisuStep, 'String'));
IndexNum=IndexNum+1;





if IndexNum  <=  index(end)
load(handles.ImagingFIle,'ImageGridTime')


set( handles.editVisuStep, 'String', num2str(IndexNum));
set( handles.editVisuTime, 'String', num2str((ImageGridTime(IndexNum))));


    
if (get(handles.radiobuttonCurrent,'Value') == get(hObject,'Max'))
	    
    if (get(handles.radiobuttonOpticalFlow,'Value') == get(hObject,'Max'))
        
        if handles.check && ishandle(handles.hq) && ishandle(handles.hq)
            delete(handles.hq)
        end
    H=view_surface('Surface',flow.faces,flow.vertices,flow.F(:,IndexNum-(index(1)-1)));
    hold on
    hq=quiver3(flow.vertices(:,1),flow.vertices(:,2),flow.vertices(:,3),flow.V(:,1,IndexNum-(index(1)-1)),flow.V(:,2,IndexNum-(index(1)-1)),flow.V(:,3,IndexNum-(index(1)-1)),2,'g');
    handles.check=1;             
    handles.hq= hq;
    guidata(hObject,handles)
        
      
    
    elseif (get(handles.radiobuttonVdiv,'Value') == get(hObject,'Max'))
       	           
        if handles.check && ishandle(handles.hq) && ishandle(handles.hq)
            delete(handles.hq)
        end
     H=view_surface('Surface',flow.faces,flow.vertices,flow.F(:,IndexNum-(index(1)-1)));
     hold on
     hq=quiver3(flow.vertices(:,1),flow.vertices(:,2),flow.vertices(:,3),Vdiv(:,1,IndexNum-(index(1)-1)),Vdiv(:,2,IndexNum-(index(1)-1)),Vdiv(:,3,IndexNum-(index(1)-1)),2,'g');
     handles.check=1;             
     handles.hq= hq;
     guidata(hObject,handles)

    elseif (get(handles.radiobuttonVcurl,'Value') == get(hObject,'Max'))
        
            
        if handles.check && ishandle(handles.hq) && ishandle(handles.hq)
            delete(handles.hq)
        end
     H=view_surface('Surface',flow.faces,flow.vertices,flow.F(:,IndexNum-(index(1)-1)));
     hold on
     hq=quiver3(flow.vertices(:,1),flow.vertices(:,2),flow.vertices(:,3),Vcurl(:,1,IndexNum-(index(1)-1)),Vcurl(:,2,IndexNum-(index(1)-1)),Vcurl(:,3,IndexNum-(index(1)-1)),2,'g');
     handles.check=1;             
     handles.hq= hq;
     guidata(hObject,handles)   
            
            
            
    elseif (get(handles.radiobuttonH,'Value') == get(hObject,'Max'))
        
        if handles.check && ishandle(handles.hq) && ishandle(handles.hq)
        delete(handles.hq)
        end
    H=view_surface('Surface',flow.faces,flow.vertices,flow.F(:,IndexNum-(index(1)-1)));
    hold on
    hq=quiver3(flow.vertices(:,1),flow.vertices(:,2),flow.vertices(:,3),H(:,1,IndexNum-(index(1)-1)),H(:,2,IndexNum-(index(1)-1)),H(:,3,IndexNum-(index(1)-1)),2,'g');
    handles.check=1;             
    handles.hq= hq;
    guidata(hObject,handles)   
            
           
   elseif (get(handles.radiobuttonVectorNone,'Value') == get(hObject,'Max'))
        
        if handles.check && ishandle(handles.hq) && ishandle(handles.hq)
        delete(handles.hq)
        end
    H=view_surface('Surface',flow.faces,flow.vertices,flow.F(:,IndexNum-(index(1)-1)));
    handles.check=0;             
    guidata(hObject,handles)  
            
            
            
    end % vector field
   
    
elseif (get(handles.radiobuttonU,'Value') == get(hObject,'Max'))
    if (get(handles.radiobuttonOpticalFlow,'Value') == get(hObject,'Max'))
        
        if handles.check && ishandle(handles.hq) && ishandle(handles.hq)
            delete(handles.hq)
        end
    H=view_surface('Surface',flow.faces,flow.vertices,U(:,IndexNum-(index(1)-1)));
    hold on
    hq=quiver3(flow.vertices(:,1),flow.vertices(:,2),flow.vertices(:,3),flow.V(:,1,IndexNum-(index(1)-1)),flow.V(:,2,IndexNum-(index(1)-1)),flow.V(:,3,IndexNum-(index(1)-1)),2,'g');
    handles.check=1;             
    handles.hq= hq;
    guidata(hObject,handles)
        
      
    
    elseif (get(handles.radiobuttonVdiv,'Value') == get(hObject,'Max'))
       	           
        if handles.check && ishandle(handles.hq) && ishandle(handles.hq)
            delete(handles.hq)
        end
     H=view_surface('Surface',flow.faces,flow.vertices,U(:,IndexNum-(index(1)-1)));
     hold on
     hq=quiver3(flow.vertices(:,1),flow.vertices(:,2),flow.vertices(:,3),Vdiv(:,1,IndexNum-(index(1)-1)),Vdiv(:,2,IndexNum-(index(1)-1)),Vdiv(:,3,IndexNum-(index(1)-1)),2,'g');
     handles.check=1;             
     handles.hq= hq;
     guidata(hObject,handles)

    elseif (get(handles.radiobuttonVcurl,'Value') == get(hObject,'Max'))
        
            
        if handles.check && ishandle(handles.hq) && ishandle(handles.hq)
            delete(handles.hq)
        end
     H=view_surface('Surface',flow.faces,flow.vertices,U(:,IndexNum-(index(1)-1)));
     hold on
     hq=quiver3(flow.vertices(:,1),flow.vertices(:,2),flow.vertices(:,3),Vcurl(:,1,IndexNum-(index(1)-1)),Vcurl(:,2,IndexNum-(index(1)-1)),Vcurl(:,3,IndexNum-(index(1)-1)),2,'g');
     handles.check=1;             
     handles.hq= hq;
     guidata(hObject,handles)   
            
            
            
    elseif (get(handles.radiobuttonH,'Value') == get(hObject,'Max'))
        
        if handles.check && ishandle(handles.hq) && ishandle(handles.hq)
        delete(handles.hq)
        end
    H=view_surface('Surface',flow.faces,flow.vertices,U(:,IndexNum-(index(1)-1)));
    hold on
    hq=quiver3(flow.vertices(:,1),flow.vertices(:,2),flow.vertices(:,3),H(:,1,IndexNum-(index(1)-1)),H(:,2,IndexNum-(index(1)-1)),H(:,3,IndexNum-(index(1)-1)),2,'g');
    handles.check=1;             
    handles.hq= hq;
    guidata(hObject,handles)   
            
           
   elseif (get(handles.radiobuttonVectorNone,'Value') == get(hObject,'Max'))
        
        if handles.check && ishandle(handles.hq) && ishandle(handles.hq)
        delete(handles.hq)
        end
    H=view_surface('Surface',flow.faces,flow.vertices,U(:,IndexNum-(index(1)-1)));
    handles.check=0;             
    guidata(hObject,handles)  
           
   end % vector field
   
   
elseif (get(handles.radiobuttonV,'Value') == get(hObject,'Max'))
    if (get(handles.radiobuttonOpticalFlow,'Value') == get(hObject,'Max'))
        
        if handles.check && ishandle(handles.hq) && ishandle(handles.hq)
            delete(handles.hq)
        end
    H=view_surface('Surface',flow.faces,flow.vertices,V(:,IndexNum-(index(1)-1)));
    hold on
    hq=quiver3(flow.vertices(:,1),flow.vertices(:,2),flow.vertices(:,3),flow.V(:,1,IndexNum-(index(1)-1)),flow.V(:,2,IndexNum-(index(1)-1)),flow.V(:,3,IndexNum-(index(1)-1)),2,'g');
    handles.check=1;             
    handles.hq= hq;
    guidata(hObject,handles)
        
      
    
    elseif (get(handles.radiobuttonVdiv,'Value') == get(hObject,'Max'))
       	           
        if handles.check && ishandle(handles.hq) && ishandle(handles.hq)
            delete(handles.hq)
        end
     H=view_surface('Surface',flow.faces,flow.vertices,V(:,IndexNum-(index(1)-1)));
     hold on
     hq=quiver3(flow.vertices(:,1),flow.vertices(:,2),flow.vertices(:,3),Vdiv(:,1,IndexNum-(index(1)-1)),Vdiv(:,2,IndexNum-(index(1)-1)),Vdiv(:,3,IndexNum-(index(1)-1)),2,'g');
     handles.check=1;             
     handles.hq= hq;
     guidata(hObject,handles)

    elseif (get(handles.radiobuttonVcurl,'Value') == get(hObject,'Max'))
        
            
        if handles.check && ishandle(handles.hq) && ishandle(handles.hq)
            delete(handles.hq)
        end
     H=view_surface('Surface',flow.faces,flow.vertices,V(:,IndexNum-(index(1)-1)));
     hold on
     hq=quiver3(flow.vertices(:,1),flow.vertices(:,2),flow.vertices(:,3),Vcurl(:,1,IndexNum-(index(1)-1)),Vcurl(:,2,IndexNum-(index(1)-1)),Vcurl(:,3,IndexNum-(index(1)-1)),2,'g');
     handles.check=1;             
     handles.hq= hq;
     guidata(hObject,handles)   
            
            
            
    elseif (get(handles.radiobuttonH,'Value') == get(hObject,'Max'))
        
        if handles.check && ishandle(handles.hq) && ishandle(handles.hq)
        delete(handles.hq)
        end
    H=view_surface('Surface',flow.faces,flow.vertices,V(:,IndexNum-(index(1)-1)));
    hold on
    hq=quiver3(flow.vertices(:,1),flow.vertices(:,2),flow.vertices(:,3),H(:,1,IndexNum-(index(1)-1)),H(:,2,IndexNum-(index(1)-1)),H(:,3,IndexNum-(index(1)-1)),2,'g');
    handles.check=1;             
    handles.hq= hq;
    guidata(hObject,handles)   
            
           
   elseif (get(handles.radiobuttonVectorNone,'Value') == get(hObject,'Max'))
        
        if handles.check && ishandle(handles.hq) && ishandle(handles.hq)
        delete(handles.hq)
        end
    H=view_surface('Surface',flow.faces,flow.vertices,V(:,IndexNum-(index(1)-1)));
    handles.check=0;             
    guidata(hObject,handles)  
            
            
            
    end % vector field
    
    
    
elseif (get(handles.radiobuttonScalarNone,'Value') == get(hObject,'Max'))
    if (get(handles.radiobuttonOpticalFlow,'Value') == get(hObject,'Max'))
        
        if handles.check && ishandle(handles.hq) && ishandle(handles.hq)
            delete(handles.hq)
        end
    H=view_surface('Surface',flow.faces,flow.vertices);
    hold on
    hq=quiver3(flow.vertices(:,1),flow.vertices(:,2),flow.vertices(:,3),flow.V(:,1,IndexNum-(index(1)-1)),flow.V(:,2,IndexNum-(index(1)-1)),flow.V(:,3,IndexNum-(index(1)-1)),2,'g');
    handles.check=1;             
    handles.hq= hq;
    guidata(hObject,handles)
        
      
    
    elseif (get(handles.radiobuttonVdiv,'Value') == get(hObject,'Max'))
       	           
        if handles.check && ishandle(handles.hq) && ishandle(handles.hq)
            delete(handles.hq)
        end
     H=view_surface('Surface',flow.faces,flow.vertices);
     hold on
     hq=quiver3(flow.vertices(:,1),flow.vertices(:,2),flow.vertices(:,3),Vdiv(:,1,IndexNum-(index(1)-1)),Vdiv(:,2,IndexNum-(index(1)-1)),Vdiv(:,3,IndexNum-(index(1)-1)),2,'g');
     handles.check=1;             
     handles.hq= hq;
     guidata(hObject,handles)

    elseif (get(handles.radiobuttonVcurl,'Value') == get(hObject,'Max'))
        
            
        if handles.check && ishandle(handles.hq) && ishandle(handles.hq)
            delete(handles.hq)
        end
     H=view_surface('Surface',flow.faces,flow.vertices);
     hold on
     hq=quiver3(flow.vertices(:,1),flow.vertices(:,2),flow.vertices(:,3),Vcurl(:,1,IndexNum-(index(1)-1)),Vcurl(:,2,IndexNum-(index(1)-1)),Vcurl(:,3,IndexNum-(index(1)-1)),2,'g');
     handles.check=1;             
     handles.hq= hq;
     guidata(hObject,handles)   
            
            
            
    elseif (get(handles.radiobuttonH,'Value') == get(hObject,'Max'))
        
        if handles.check && ishandle(handles.hq) && ishandle(handles.hq)
        delete(handles.hq)
        end
    H=view_surface('Surface',flow.faces,flow.vertices);
    hold on
    hq=quiver3(flow.vertices(:,1),flow.vertices(:,2),flow.vertices(:,3),H(:,1,IndexNum-(index(1)-1)),H(:,2,IndexNum-(index(1)-1)),H(:,3,IndexNum-(index(1)-1)),2,'g');
    handles.check=1;             
    handles.hq= hq;
    guidata(hObject,handles)   
            
           
   elseif (get(handles.radiobuttonVectorNone,'Value') == get(hObject,'Max'))
        
        if handles.check && ishandle(handles.hq) && ishandle(handles.hq)
        delete(handles.hq)
        end
    H=view_surface('Surface',flow.faces,flow.vertices);
    handles.check=0;             
    guidata(hObject,handles)  
            
            
            
    end % vector field

end
end

% --- Executes on button press in pushbuttonVisuPlot.
function pushbuttonVisuPlot_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonVisuPlot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global U V H Vcurl Vdiv index flow
load(handles.ImagingFIle, 'ImageGridTime');
figure;
if (get(handles.radiobuttonVisuDE,'Value') == get(hObject,'Max'))
plot(ImageGridTime(flow.t),flow.de)
else
plot(ImageGridTime(flow.t),sum(abs(U)))
end


function editVisuStep_Callback(hObject, eventdata, handles)
% hObject    handle to editVisuStep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editVisuStep as text
%        str2double(get(hObject,'String')) returns contents of editVisuStep as a double


% --- Executes during object creation, after setting all properties.
function editVisuStep_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editVisuStep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editVisuTime_Callback(hObject, eventdata, handles)
% hObject    handle to editVisuTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editVisuTime as text
%        str2double(get(hObject,'String')) returns contents of editVisuTime as a double


% --- Executes during object creation, after setting all properties.
function editVisuTime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editVisuTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on button press in btnSaveData.
function btnSaveData_Callback(hObject, eventdata, handles)
% hObject    handle to btnSaveData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global U V H Vcurl Vdiv index flow

if (get(handles.checkboxOpticalFlow,'Value') == get(hObject,'Max'))
[filename, pathname] = uiputfile('*.mat','Save in Mat File');
File = fullfile(pathname,filename);
save(File,'flow')

end

if (get(handles.checkboxU,'Value') == get(hObject,'Max'))
[filename, pathname] = uiputfile('*.mat','Save in Mat File');
File = fullfile(pathname,filename);
save(File,'U')

end

if (get(handles.checkboxV,'Value') == get(hObject,'Max'))
[filename, pathname] = uiputfile('*.mat','Save in Mat File');
File = fullfile(pathname,filename);
save(File,'V')

end

if (get(handles.checkboxVdiv,'Value') == get(hObject,'Max'))
[filename, pathname] = uiputfile('*.mat','Save in Mat File');
File = fullfile(pathname,filename);
save(File,'Vdiv')

end

if (get(handles.checkboxVcurl,'Value') == get(hObject,'Max'))
[filename, pathname] = uiputfile('*.mat','Save in Mat File');
File = fullfile(pathname,filename);
save(File,'Vcurl')

end

if (get(handles.checkboxH,'Value') == get(hObject,'Max'))
[filename, pathname] = uiputfile('*.mat','Save in Mat File');
File = fullfile(pathname,filename);
save(File,'H')

end
% --- Executes on button press in checkboxU.
function checkboxU_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxU (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxU


% --- Executes on button press in checkboxV.
function checkboxV_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxV


% --- Executes on button press in checkboxOpticalFlow.
function checkboxOpticalFlow_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxOpticalFlow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxOpticalFlow


% --- Executes on button press in checkboxVdiv.
function checkboxVdiv_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxVdiv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxVdiv


% --- Executes on button press in checkboxVcurl.
function checkboxVcurl_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxVcurl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxVcurl


% --- Executes on button press in checkboxH.
function checkboxH_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxH (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxH


