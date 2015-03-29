function varargout = comp_DCT(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @comp_DCT_OpeningFcn, ...
                   'gui_OutputFcn',  @comp_DCT_OutputFcn, ...
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


% --- Executes just before comp_DCT is made visible.
function comp_DCT_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = comp_DCT_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)

hObject(handles)

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)

[file ,path]=uigetfile('*.bmp');
original=imread(file);
axes(handles.axes2)
imshow(original)

[d h ]=size(original);
set(handles.edit1,'string',(d*h))

handles.original=original;
handles.file=file;
guidata(hObject, handles);


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)


original=handles.original;
file=handles.file;
rate=get(handles.edit2,'string');
rate=str2num(rate);

original = double(original)/255;
rate=10000*rate;

im=original;
img_dct=dct2(im);
img_pow=(img_dct).^2;
img_pow=img_pow(:);
[B,index]=sort(img_pow);
B=flipud(B);
index=flipud(index);
compressed_dct=zeros(size(im));

for k=1:rate
compressed_dct(index(k))=img_dct(index(k));
end
img_dct=idct2(compressed_dct);

comp=img_dct;

axes(handles.axes3)

imshow(comp)

imwrite(comp, 'Compressed Image .jpg');

D_H=dir('Compressed Image .jpg');
filesize=D_H.bytes;

D_H1=dir(file);
filesize1=D_H1.bytes;

cr=filesize1/filesize;
set(handles.edit4,'string',cr)

handles.gray=comp;

global original
if(image )
    msgbox('Image Saved Named (Compressed Image) Click on Main Menu to terminate the application .Please continue with  Steganography.')
  
else
    msgbox('Image Did Not Saved')
end

guidata(hObject, handles);



% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on button press in ClearAll.
function ClearAll_Callback(hObject, eventdata, handles)

axes(handles.axes2);cla
axes(handles.axes3);cla
axes(handles.axes4);cla
axes(handles.axes8);cla
a=[]
set(handles.edit1,'string',a)
set(handles.edit2,'string',a)
set(handles.edit3,'string',a)
set(handles.edit4,'string',a)
set(handles.edit7,'string',a)
set(handles.edit8,'string',a)
set(handles.edit9,'string',a)
set(handles.edit10,'string',a)
clc
clear



% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)

rate=get(handles.edit2,'string');
rate=str2double(rate);
original=handles.original;
[r, c, p]=size(original);
mod_rate=rate*10000;
set(handles.edit3,'string',mod_rate)



% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
[file path]=uigetfile('*.jpg');% Cover image reading
cover=imread(file);
axes(handles.axes4)% setting to axes1
imshow(cover)% image showing
handles.cover=cover;% handling cover image from push1 to push2
guidata(hObject, handles);


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
out_emd_img=handles.out_emd_img;
[file path]=uiputfile('*.bmp');
imwrite(out_emd_img,[path file])


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

cover=handles.cover;


msg=get(handles.edit8,'string');
binVector = str2bin(msg);
binVector=binVector'; 
len=length(binVector);


key=get(handles.edit7,'string');

key=str2num(key);

[sec_key]=secret_key_generation_txt(len,key);
out_key_msg1=xor(binVector,sec_key);

global len key
% Embedding
out_emd_img=embed1(cover,out_key_msg1,1);
axes(handles.axes8)
imshow(out_emd_img)
set(handles.figure1, 'pointer', 'arrow') 
handles.out_emd_img=out_emd_img; 
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on button press in pushbutton15.
function pushbutton15_Callback(hObject, eventdata, handles)

close(handles.figure1)
main



% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton16.
function pushbutton16_Callback(hObject, eventdata, handles)

sender = 'dlawarMamin@gmail.com';
mypassword ='xxxxxxx';
setpref('Internet','E_mail',sender);
setpref('Internet','SMTP_Server','smtp.gmail.com');
setpref('Internet','SMTP_Username',sender);
setpref('Internet','SMTP_Password',mypassword);

props = java.lang.System.getProperties;
props.setProperty('mail.smtp.auth','true');
props.setProperty('mail.smtp.socketFactory.class', 'javax.net.ssl.SSLSocketFactory');
props.setProperty('mail.smtp.socketFactory.port','465');
a= get(handles.edit9, 'String');
b= get(handles.edit10, 'string');
sendmail(a ,'Test from sender',b);
  msgbox('Message Successfully Send ');
  


% --------------------------------------------------------------------
function uitoolbar1_ButtonDownFcn(hObject, eventdata, handles)

guidata(hObject, handles);


% --- Executes on mouse press over axes background.
function axes4_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axes4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
