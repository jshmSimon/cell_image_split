function varargout = gui(varargin)
% GUI MATLAB code for gui.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui

% Last Modified by GUIDE v2.5 14-Jun-2017 23:46:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_OutputFcn, ...
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


% --- Executes just before gui is made visible.
function gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui (see VARARGIN)

% Choose default command line output for gui
handles.output = hObject;

global ButtonDown pos1;  
ButtonDown =[];  
pos1=[];  

set(handles.axes1,'xTick',[]);
set(handles.axes1,'yTick',[]);

set(handles.item1,'xTick',[]);
set(handles.item1,'yTick',[]);
set(handles.item2,'xTick',[]);
set(handles.item2,'yTick',[]);
set(handles.item3,'xTick',[]);
set(handles.item3,'yTick',[]);
set(handles.item4,'xTick',[]);
set(handles.item4,'yTick',[]);
set(handles.item5,'xTick',[]);
set(handles.item5,'yTick',[]);
set(handles.item6,'xTick',[]);
set(handles.item6,'yTick',[]);

set(handles.general_info,'string','');
set(handles.detail_info1,'string','');
set(handles.detail_info2,'string','');
set(handles.detail_info3,'string','');
set(handles.detail_info4,'string','');
set(handles.detail_info5,'string','');
set(handles.detail_info6,'string','');

set(handles.page_num,'string','');
set(handles.next_page,'visible','off');
set(handles.last_page,'visible','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);





% --- Outputs from this function are returned to the command line.
function varargout = gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in openimg.
function openimg_Callback(hObject, eventdata, handles)
% hObject    handle to openimg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname]=...
    uigetfile({'*.jpg';'*.bmp';'*.png';'*.gif'},'选择图片');
str=[pathname filename];
global original_img show_img;
original_img=imread(str);
axes(handles.axes1);
show_img=original_img;
imshow(show_img);



% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over openimg.
function openimg_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to openimg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in close.
function close_Callback(hObject, eventdata, handles)
% hObject    handle to close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(gcf);


% --- Executes when selected object is changed in uibuttongroup1.
function uibuttongroup1_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uibuttongroup1 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global original_img show_img;
str=get(hObject,'string');
axes(handles.axes1);
[m,n,k]=size(original_img);
switch str
    case '原图'
        show_img=original_img;
        imshow(show_img);
    case '中值滤波'  
        show_img=original_img;
        for i=1:3
            show_img(:,:,i)=medfilt2(show_img(:,:,i));
        end
        imshow(show_img);
    case '均值滤波'
        show_img=original_img;
        h=ones(3,3)/9;
        for i=1:3
            show_img(:,:,i)=imfilter(show_img(:,:,i),h);
        end
        imshow(show_img);
    case '维纳滤波'
        show_img=original_img;
        for i=1:3
            show_img(:,:,i)=wiener2(show_img(:,:,i),[5 5]);
        end
        imshow(show_img);
    case '锐化滤波'
        show_img=original_img;
        h=[0 1 0;1 -4 1;0 1 0];
        for i=1:3
            J=conv2(im2double(show_img(:,:,i)),h,'same');
            show_img(:,:,i)=show_img(:,:,i)-uint8(J);
        end
        imshow(show_img);
        
            
end


% --- Executes on button press in pre_split.
function pre_split_Callback(hObject, eventdata, handles)
% hObject    handle to pre_split (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global show_img;
B=show_img(:,:,3);
B_gray=im2double(B);
level=graythresh(B_gray);
B_bw=im2bw(B_gray,level);
axes(handles.axes1);
show_img=B_bw;
imshow(show_img);

% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over pre_split.

% hObject    handle to pre_split (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over pre_split.
function pre_split_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to pre_split (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in spot_fill.
function spot_fill_Callback(hObject, eventdata, handles)
% hObject    handle to spot_fill (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global show_img;
se=strel('disk',5);
Spot_filled=imopen(show_img,se);
axes(handles.axes1);
show_img=Spot_filled;
imshow(show_img);


% --- Executes on button press in water_split.
function water_split_Callback(hObject, eventdata, handles)
% hObject    handle to water_split (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global show_img;
D=-bwdist(~show_img);
mask=imextendedmin(D,2);
D2=imimposemin(D,mask);
Ld=watershed(D2);
Water_splited=show_img;
Water_splited(Ld==0)=0;
axes(handles.axes1);
show_img=Water_splited;
imshow(show_img);








% --- Executes on mouse press over figure background, over a disabled or
% --- inactive control, or over an axes background.
function figure1_WindowButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global ButtonDown pos1 show_img ;  
if(strcmp(get(gcf,'SelectionType'),'normal'))%判断鼠标按下的类型，mormal为左键  
    ButtonDown=1;  
    pos1=get(handles.axes1,'CurrentPoint');%获取坐标轴上鼠标的位置  
end  
Diy_splited=show_img;
row=floor(pos1(1,2));
col=floor(pos1(1,1));
Diy_splited(row,col)=0;
axes(handles.axes1);
show_img=Diy_splited;
imshow(show_img);


% --- Executes on mouse motion over figure - except title and menu.
function figure1_WindowButtonMotionFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%鼠标运动事件的响应  
global ButtonDown  show_img;  
if ButtonDown == 1  
    pos = get(handles.axes1, 'CurrentPoint');
    row=floor(pos(1,2));
    col=floor(pos(1,1));
    Diy_splited=show_img;
    Diy_splited(row,col)=0;
    show_img=Diy_splited;
    axes(handles.axes1);
    imshow(show_img);
end  



% --- Executes on mouse press over figure background, over a disabled or
% --- inactive control, or over an axes background.
function figure1_WindowButtonUpFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%鼠标按键抬起的响应事件  
global ButtonDown;  
ButtonDown = 0;  
water_split_Callback(hObject, eventdata, handles);


% --- Executes on button press in clear_edge.
function clear_edge_Callback(hObject, eventdata, handles)
% hObject    handle to clear_edge (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global show_img;
clear_edge_img=show_img;
[L,num]=bwlabel(clear_edge_img,8);
[m,n]=size(clear_edge_img);
%清除上边缘
for i=1:n
    if(L(1,i)==0)
        continue;
    else
        tag=L(1,i);
        clear_edge_img(L==tag)=0;
    end
end
%清除右边缘
for i=1:m
    if(L(i,n-1)==0)
        continue;
    else
        tag=L(i,n-1);
        clear_edge_img(L==tag)=0;
    end
end
%清除下边缘
for i=1:n
    if(L(m,i)==0)
        continue;
    else
        tag=L(m,i);
        clear_edge_img(L==tag)=0;
    end
end
%清除左边缘
for i=1:m
    if(L(i,1)==0)
        continue;
    else
        tag=L(i,1);
        clear_edge_img(L==tag)=0;
    end
end
show_img=clear_edge_img;
axes(handles.axes1);
imshow(show_img);


% --- Executes on button press in count.
function count_Callback(hObject, eventdata, handles)
% hObject    handle to count (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global N show_img original_img img_group perimeter_group area_group;
[B,L,N]=bwboundaries(show_img,'noholes');
[m,n]=size(show_img);
counted_img=zeros(m,n);
for i=1:N
    %显示边缘
    for j=1:size(B{i},1)
        counted_img(B{i}(j,1),B{i}(j,2))=1;
    end
    %标号
    med_row=floor(mean(B{i}(:,1)));
    med_col=floor(mean(B{i}(:,2)));
    if floor(i/10)==0
        str=[num2str(i) '.png'];
        I=imread(str);
    else
        str1=[num2str(floor(i/10)) '.png'];
        str2=[num2str(rem(i,10)) '.png'];
        I1=imread(str1);
        I2=imread(str2);
        I=[I1 I2];
    end
    [number_row,number_col]=size(I);
    counted_img((med_row - (number_row/2)):(med_row + (number_row/2) - 1),(med_col - (number_col/2)):(med_col + (number_col/2) - 1))=I;
    %截取每个细胞图像
    item_img=original_img(med_row - 45:med_row +44,med_col - 45:med_col + 44,:);
    item_img_index=L(med_row - 45:med_row +44,med_col - 45:med_col + 44);
    index=find(item_img_index~=i);
    r=item_img(:,:,1);
    g=item_img(:,:,2);
    b=item_img(:,:,3);
    r(index)=255;
    g(index)=255;
    b(index)=255;
    item_img=cat(3,r,g,b);
    img_group{i}=item_img;
    %每个细胞周长
    item_perimeter=size(B{i},1);
    perimeter_group{i}=item_perimeter;
    %每个细胞面积
    item_area=length(find(L==i));
    area_group{i}=item_area;

end
%显示标号的原图
R=original_img(:,:,1)+uint8(counted_img*255);
G=original_img(:,:,2)+uint8(counted_img*255);
B=original_img(:,:,3)+uint8(counted_img*255);
show_img=cat(3,R,G,B);
axes(handles.axes1);
imshow(show_img);

%显示general_info
avg_perimeter=floor(mean(cell2mat(perimeter_group)));
avg_area=floor(mean(cell2mat(area_group)));
str=['细胞个数：' num2str(N) '       ' '平均周长：' num2str(avg_perimeter) '       ' '平均面积：' num2str(avg_area)];
set(handles.general_info,'string',str);
       


% --- Executes on button press in show_item.
function show_item_Callback(hObject, eventdata, handles)
% hObject    handle to show_item (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global N img_group perimeter_group area_group page pages;
page=1;
pages=ceil(N/6);
str=['第' num2str(page) '/' num2str(pages) '页'];
set(handles.page_num,'string',str);
if page~=pages
    axes(handles.item1);imshow(img_group{1});
    axes(handles.item2);imshow(img_group{2});
    axes(handles.item3);imshow(img_group{3});
    axes(handles.item4);imshow(img_group{4});
    axes(handles.item5);imshow(img_group{5});
    axes(handles.item6);imshow(img_group{6});
    for i=1:6
        strs{i}=['No.' num2str(i) ' ' '周长：' num2str(perimeter_group{i}) ' ' '面积：' num2str(area_group{i})];
    end
    set(handles.detail_info1,'string',strs{1});
    set(handles.detail_info2,'string',strs{2});
    set(handles.detail_info3,'string',strs{3});
    set(handles.detail_info4,'string',strs{4});
    set(handles.detail_info5,'string',strs{5});
    set(handles.detail_info6,'string',strs{6});
else
    item_img=ones(size(img_group{1}));
    item_img(:,:,:)=255;
    item_imgs{1:6}=item_img;
    item_strs{1:6}='';
    for i=1:N
        item_imgs{i}=img_group{i};
        item_strs{i}=['No.' num2str(i) '   ' '周长：' num2str(perimeter_group{i}) '   ' '面积：' num2str(area_group{i})];
    end
    axes(handles.item1);imshow(item_imgs{1});
    axes(handles.item2);imshow(item_imgs{2});
    axes(handles.item3);imshow(item_imgs{3});
    axes(handles.item4);imshow(item_imgs{4});
    axes(handles.item5);imshow(item_imgs{5});
    axes(handles.item6);imshow(item_imgs{6});
    
    set(handles.detail_info1,'string',item_strs{1});
    set(handles.detail_info2,'string',item_strs{2});
    set(handles.detail_info3,'string',item_strs{3});
    set(handles.detail_info4,'string',item_strs{4});
    set(handles.detail_info5,'string',item_strs{5});
    set(handles.detail_info6,'string',item_strs{6});
end

set(handles.next_page,'visible','on');
set(handles.last_page,'visible','on');


% --- Executes on button press in next_page.
function next_page_Callback(hObject, eventdata, handles)
% hObject    handle to next_page (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global N img_group perimeter_group area_group page pages;
if page~=pages
    start=page*6+1;
    over=min(page*6+6,N);
    item_img=ones(size(img_group{1}));
    item_img(:,:,:)=255;
    for i=1:6
        item_imgs{i}=item_img;
        item_strs{i}='';
    end
    for i=start:over
        item_imgs{i-page*6}=img_group{i};
        item_strs{i-page*6}=['No.' num2str(i) ' ' '周长：' num2str(perimeter_group{i}) ' ' '面积：' num2str(area_group{i})];
    end
    axes(handles.item1);imshow(item_imgs{1});
    axes(handles.item2);imshow(item_imgs{2});
    axes(handles.item3);imshow(item_imgs{3});
    axes(handles.item4);imshow(item_imgs{4});
    axes(handles.item5);imshow(item_imgs{5});
    axes(handles.item6);imshow(item_imgs{6});
    
    set(handles.detail_info1,'string',item_strs{1});
    set(handles.detail_info2,'string',item_strs{2});
    set(handles.detail_info3,'string',item_strs{3});
    set(handles.detail_info4,'string',item_strs{4});
    set(handles.detail_info5,'string',item_strs{5});
    set(handles.detail_info6,'string',item_strs{6});
    
    page=page+1;
    str=['第' num2str(page) '/' num2str(pages) '页'];
    set(handles.page_num,'string',str);
end



% --- Executes on button press in last_page.
function last_page_Callback(hObject, eventdata, handles)
% hObject    handle to last_page (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global N img_group perimeter_group area_group page pages;
if page~=1
    over=page*6-6;
    start=over-5;
    item_img=ones(size(img_group{1}));
    item_img(:,:,:)=255;
    for i=1:6
        item_imgs{i}=item_img;
        item_strs{i}='';
    end
    for i=start:over
        item_imgs{i-(page-2)*6}=img_group{i};
        item_strs{i-(page-2)*6}=['No.' num2str(i) ' ' '周长：' num2str(perimeter_group{i}) ' ' '面积：' num2str(area_group{i})];
    end
    axes(handles.item1);imshow(item_imgs{1});
    axes(handles.item2);imshow(item_imgs{2});
    axes(handles.item3);imshow(item_imgs{3});
    axes(handles.item4);imshow(item_imgs{4});
    axes(handles.item5);imshow(item_imgs{5});
    axes(handles.item6);imshow(item_imgs{6});
    
    set(handles.detail_info1,'string',item_strs{1});
    set(handles.detail_info2,'string',item_strs{2});
    set(handles.detail_info3,'string',item_strs{3});
    set(handles.detail_info4,'string',item_strs{4});
    set(handles.detail_info5,'string',item_strs{5});
    set(handles.detail_info6,'string',item_strs{6});
    
    page=page-1;
    str=['第' num2str(page) '/' num2str(pages) '页'];
    set(handles.page_num,'string',str);
end
