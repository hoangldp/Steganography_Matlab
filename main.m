function varargout = main(varargin)
% MAIN MATLAB code for main.fig
%      MAIN, by itself, creates a new MAIN or raises the existing
%      singleton*.
%
%      H = MAIN returns the handle to a new MAIN or the handle to
%      the existing singleton*.
%
%      MAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN.M with the given input arguments.
%
%      MAIN('Property','Value',...) creates a new MAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before main_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to main_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help main

% Last Modified by GUIDE v2.5 15-Apr-2020 23:19:20

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @main_OpeningFcn, ...
                   'gui_OutputFcn',  @main_OutputFcn, ...
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


% --- Executes just before main is made visible.
function main_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to main (see VARARGIN)

% Choose default command line output for main
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes main wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = main_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in btnSelectImageOrigin.
function btnSelectImageOrigin_Callback(hObject, eventdata, handles)
% hObject    handle to btnSelectImageOrigin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[file, path] = uigetfile({'*.jpg;*.jpg;*.png;*.bmp', ...
    'Anh ma hoa (*.jpg;*.jpg;*.png;*.bmp)'}, ...
    'Chon anh');
if isequal(file, 0)
    return;
else
    fileName = fullfile(path, file);
    handles.fileNameImageOrigin = fileName;
    handles.imageOrigin = imread(fileName);
    guidata(hObject, handles);
    axes(handles.axesImageOrigin);
    imshow(handles.imageOrigin);
end



function txtSecretInput_Callback(hObject, eventdata, handles)
% hObject    handle to txtSecretInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtSecretInput as text
%        str2double(get(hObject,'String')) returns contents of txtSecretInput as a double


% --- Executes during object creation, after setting all properties.
function txtSecretInput_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtSecretInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtSecretOutput_Callback(hObject, eventdata, handles)
% hObject    handle to txtSecretOutput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtSecretOutput as text
%        str2double(get(hObject,'String')) returns contents of txtSecretOutput as a double


% --- Executes during object creation, after setting all properties.
function txtSecretOutput_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtSecretOutput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnEmbed.
function btnEmbed_Callback(hObject, eventdata, handles)
% hObject    handle to btnEmbed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
secret = get(handles.txtSecretInput, 'string');
if isempty(secret) || ~isfield(handles, 'fileNameImageOrigin')
    disp('Error: Must enter secret and chose image.');
else
    fileName = handles.fileNameImageOrigin;
    [image, count] = embed(fileName, secret);
    handles.imageEmbed = image;
    guidata(hObject, handles);
    axes(handles.axesImageEmbed);
    imshow(handles.imageEmbed);
    info = [int2str(count / 8), ' byte', ' (', int2str(count / 8 / 1024), ' KB)'];
    set(handles.lblBitEmbed, 'string', info);
end


% --- Executes on button press in btnExtract.
function btnExtract_Callback(hObject, eventdata, handles)
% hObject    handle to btnExtract (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isfield(handles, 'imageEmbed')
    return;
else
    image = handles.imageEmbed;
    secret = extractSecret(image);
    set(handles.txtSecretOutput, 'string', secret);
end


% --- Executes on button press in btnSelectImageEmbed.
function btnSelectImageEmbed_Callback(hObject, eventdata, handles)
% hObject    handle to btnSelectImageEmbed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[file, path] = uigetfile({'*.bmp', ...
    'Anh ma hoa (*.bmp)'}, ...
    'Chon anh');
if isequal(file, 0)
    return;
else
    fileName = fullfile(path, file);
    handles.fileNameImageEmbed = fileName;
    handles.imageEmbed = imread(fileName);
    guidata(hObject, handles);
    axes(handles.axesImageEmbed);
    imshow(handles.imageEmbed);
end


% --- Executes on button press in btnSaveImageEmbed.
function btnSaveImageEmbed_Callback(hObject, eventdata, handles)
% hObject    handle to btnSaveImageEmbed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[file, path] = uiputfile({'*.bmp', ...
    'Anh ma hoa (*.bmp)'}, ...
    'Luu anh');
if isequal(file, 0) || ~isfield(handles, 'imageEmbed')
    return;
else
    imwrite(handles.imageEmbed, [path, file]);
end


% --- Executes on button press in btnGetMaxBit.
function btnGetMaxBit_Callback(hObject, eventdata, handles)
% hObject    handle to btnGetMaxBit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isfield(handles, 'imageOrigin')
    set(handles.btnGetMaxBit,'Enable','off');
    count = getMaxEmbed(handles.imageOrigin);
    info = [int2str(count / 8), ' byte', ' (', int2str(count / 8 / 1024), ' KB)'];
    set(handles.lblMaxBitEmbed, 'string', info);
    set(handles.btnGetMaxBit,'Enable','on');
end
