function varargout = Decomp_dct_Stego(varargin)
% DECOMP_DCT M-file for Decomp_dct.fig
%      DECOMP_DCT, by itself, creates a new DECOMP_DCT or raises the existing
%      singleton*.
%
%      H = DECOMP_DCT returns the handle to a new DECOMP_DCT or the handle to
%      the existing singleton*.
%
%      DECOMP_DCT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DECOMP_DCT.M with the given input arguments.
%
%      DECOMP_DCT('Property','Value',...) creates a new DECOMP_DCT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Decomp_dct_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Decomp_dct_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Decomp_dct

% Last Modified by GUIDE v2.5 22-Mar-2015 23:24:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Decomp_dct_OpeningFcn, ...
                   'gui_OutputFcn',  @Decomp_dct_OutputFcn, ...
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


% --- Executes just before Decomp_dct is made visible.
function Decomp_dct_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Decomp_dct (see VARARGIN)

% Choose default command line output for Decomp_dct
handles.output = hObject

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Decomp_dct wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Decomp_dct_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[file path]=uigetfile('*.jpg');
comp=imread(file);
axes(handles.axes1)
imshow(comp)
handles.comp=comp;
guidata(hObject, handles);

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.figure1, 'pointer', 'watch')
drawnow;

global original

comp=handles.comp;
[r c p]=size(comp);


im=comp;

img_dct=dct2(im);
img_pow=(img_dct).^2;
img_pow=img_pow(:);
[B,index]=sort(img_pow);
B=flipud(B);
index=flipud(index);
decompressed_dct=zeros(size(im));

rate=10;

for k=1:rate
decompressed_dct(index(k))=img_dct(index(k));
end
img_dct=idct2(decompressed_dct);
rec_gray=img_dct;
decomp=original;
axes(handles.axes2)
imshow(decomp)

set(handles.figure1, 'pointer', 'arrow')
handles.decomp=decomp;
guidata(hObject, handles)


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
decomp=handles.decomp;
[file path]=uiputfile('*.bmp');
imwrite(decomp,[path file])

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1);cla
axes(handles.axes2);cla
axes(handles.axes3);cla
a=[];
set(handles.text6,'string',a)
set(handles.edit1,'string',a)
a=[];
clc
clear all

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(handles.figure1)
main


% --- Executes on button press in Select_COverImage.
function Select_COverImage_Callback(hObject, eventdata, handles)
[file path]=uigetfile('*.bmp');% Reading stego image at receiver side
stego=imread(file);% reading stego image
axes(handles.axes3)% showing to axes1  
imshow(stego)
handles.stego=stego; % handling stego image from push 3 to push 2
guidata(hObject, handles);


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
stego=handles.stego; % handling from push 3 to 2

global len key

key1=get(handles.edit1,'string'); % getting key 
key1=str2num(key1);

if(key~=key1)% checking if key is not equal
    msgbox('Wrong key enter correct key','box')
    error('Wrong key enter correct key')
end

[sec_msg,rec_img]=extract(stego,1,len);% extracting sec string from syego image


[sec_key]=secret_key_generation_txt(len,key1);% key string generation

out_msg_txt=xor(sec_msg,sec_key);% decrypt sec string using sec key

out_msg_txt=out_msg_txt';% converting colom to row

textStr = bin2str(out_msg_txt);% converting sec string to char

set(handles.text6,'string',textStr)% set this string to static text box 3
handles.textStr=textStr;
guidata(hObject, handles);


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
textStr=handles.textStr;
% [file path]=uiputfile('*.txt','w');
fidenc=fopen('Recovered Secrete Text.txt','w');
fprintf(fidenc,'%s',textStr)
% fprintf([path file],'%s',textStr)
fclose(fidenc)

if (textStr)
msgbox(' Message Successfully Saved. In current Folder (Recovered Secret Text.txt)');
else 
    msgbox('Not Functioning (Something Wrong!');
    

end

function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes during object creation, after setting all properties.
function text6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
