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

% Last Modified by GUIDE v2.5 06-May-2020 23:32:16

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

handles.method = 5;
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
    [image, count] = embed(fileName, handles.method, secret);
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
    secret = extractSecret(image, handles.method);
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
    count = getMaxEmbed(handles.imageOrigin, handles.method);
    info = [int2str(count / 8), ' byte', ' (', int2str(count / 8 / 1024), ' KB)'];
    set(handles.lblMaxBitEmbed, 'string', info);
    set(handles.btnGetMaxBit, 'Enable', 'on');
end


% --------------------------------------------------------------------
function mnSystem_Callback(hObject, eventdata, handles)
% hObject    handle to mnSystem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function mnHelp_Callback(hObject, eventdata, handles)
% hObject    handle to mnAbout (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function mnReset_Callback(hObject, eventdata, handles)
% hObject    handle to mnReset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isfield(handles, 'fileNameImageOrigin')
    handles = rmfield(handles, 'fileNameImageOrigin');
end
if isfield(handles, 'imageOrigin')
    handles = rmfield(handles, 'imageOrigin');
end
if isfield(handles, 'fileNameImageEmbed')
    handles = rmfield(handles, 'fileNameImageEmbed');
end
if isfield(handles, 'imageEmbed')
    handles = rmfield(handles, 'imageEmbed');
end

set(get(handles.axesImageOrigin, 'Parent'), 'HandleVisibility', 'on');
axes(handles.axesImageOrigin);
cla(handles.axesImageOrigin,'reset');
set(handles.axesImageOrigin, 'Visible', 'off');

set(get(handles.axesImageEmbed, 'Parent'), 'HandleVisibility', 'on');
axes(handles.axesImageEmbed);
cla(handles.axesImageEmbed, 'reset');
set(handles.axesImageEmbed, 'Visible', 'off');

set(handles.lblMaxBitEmbed, 'string', '');
set(handles.lblBitEmbed, 'string', '');

set(handles.txtSecretOutput, 'string', '');
set(handles.txtSecretInput, 'string', '');

set(handles.lblPsnr, 'string', '');

set(handles.pnEmbed, 'visible', 'on');
set(handles.pnExtract, 'visible', 'off');
set(handles.pnEvaluate, 'visible', 'off');



% --------------------------------------------------------------------
function mnExit_Callback(hObject, eventdata, handles)
% hObject    handle to mnExit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
closereq();


% --------------------------------------------------------------------
function mnAbout_Callback(hObject, eventdata, handles)
% hObject    handle to mnAbout (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
open('about.fig');


% --- Executes when selected object is changed in uibuttongroup1.
function uibuttongroup1_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uibuttongroup1 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
switch (get(eventdata.NewValue, 'Tag'))
    case 'rdFive'
        handles.method = 5;
    case 'rdSix'
        handles.method = 6;
    case 'rdSeven'
        handles.method = 7;
    case 'rdEight'
        handles.method = 8;
end
guidata(hObject, handles);


% --- Executes on button press in btnPsnr.
function btnPsnr_Callback(hObject, eventdata, handles)
% hObject    handle to btnPsnr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isfield(handles, 'imageEmbed') || ~isfield(handles, 'imageOrigin')
    return;
else
    imageEmbed = handles.imageEmbed;
    imageOrigin = handles.imageOrigin;
    psnr = getPeakSignalNoiseRatio(imageOrigin, imageEmbed);
    set(handles.lblPsnr, 'string', psnr);
end


% --- Executes on button press in btnShowHistogram.
function btnShowHistogram_Callback(hObject, eventdata, handles)
% hObject    handle to btnShowHistogram (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isfield(handles, 'imageEmbed') && ~isfield(handles, 'imageOrigin')
    return;
else
    figure;
    if isfield(handles, 'imageOrigin')
        imageOrigin = handles.imageOrigin;
        [OriginRed, xRed] = imhist(imageOrigin(:,:,1));
        [OriginGreen, xGreen] = imhist(imageOrigin(:,:,2));
        [OriginBlue, xBlue] = imhist(imageOrigin(:,:,3));

        subplot(3,2,1), bar(xRed, OriginRed, 'Red');
        subplot(3,2,3), bar(xGreen, OriginGreen, 'Green');
        subplot(3,2,5), bar(xBlue, OriginBlue, 'Blue');
    end

    if isfield(handles, 'imageEmbed')
        imageEmbed = handles.imageEmbed;
        [EmbedRed, yRed] = imhist(imageEmbed(:,:,1));
        [EmbedGreen, yGreen] = imhist(imageEmbed(:,:,2));
        [EmbedBlue, yBlue] = imhist(imageEmbed(:,:,3));

        subplot(3,2,2), bar(yRed, EmbedRed, 'Red');
        subplot(3,2,4), bar(yGreen, EmbedGreen, 'Green');
        subplot(3,2,6), bar(yBlue, EmbedBlue, 'Blue');
    end
end


% --- Executes on button press in btnShowEmbed.
function btnShowEmbed_Callback(hObject, eventdata, handles)
% hObject    handle to btnShowEmbed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.pnEmbed, 'visible', 'on');
set(handles.pnExtract, 'visible', 'off');
set(handles.pnEvaluate, 'visible', 'off');

% --- Executes on button press in btnShowExtract.
function btnShowExtract_Callback(hObject, eventdata, handles)
% hObject    handle to btnShowExtract (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.pnEmbed, 'visible', 'off');
set(handles.pnExtract, 'visible', 'on');
set(handles.pnEvaluate, 'visible', 'off');

% --- Executes on button press in btnShowEvaluate.
function btnShowEvaluate_Callback(hObject, eventdata, handles)
% hObject    handle to btnShowEvaluate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.pnEmbed, 'visible', 'off');
set(handles.pnExtract, 'visible', 'off');
set(handles.pnEvaluate, 'visible', 'on');
