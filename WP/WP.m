function varargout = WP(varargin)
% WP MATLAB code for WP.fig
%      WP, by itself, creates a new WP or raises the existing
%      singleton*.
%
%      H = WP returns the handle to a new WP or the handle to
%      the existing singleton*.
%
%      WP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in WP.M with the given input arguments.
%
%      WP('Property','Value',...) creates a new WP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before WP_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to WP_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help WP

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @WP_OpeningFcn, ...
                   'gui_OutputFcn',  @WP_OutputFcn, ...
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


% --- Executes just before WP is made visible.
function WP_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to WP (see VARARGIN)

% Choose default command line output for WP
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes WP wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = WP_OutputFcn(~, ~, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function proses_Callback(~, ~, handles)
%membaca data dan memilih baris dan kolom yang akan digunakan
data = xlsread('Real estate valuation data set.xlsx');
data =[data(:,3) data(:,4) data(:,5) data(:,8)];
data = data(1:50,:);

%atribut tiap kriteria dan pembobotan
k = [0,0,0,1];
w = [3,5,4,1];

%insialisasi ukuran data
[x, y] = size(data);

%normalisasi bobot dengan
w = w./sum(w);

%menghitung vektor S perbaris
for j=1:y
    if k(j)==0, w(j)=-1*w(j);
    end
end
for i=1:x
    S(i)=prod(data(i,:).^w);
end

%perangkingan dengan menormalisasi nilai S
V= S/sum(S);

%melakukan pengecekan 5 nilai tertinggi lalu di outputkan
[maks, index] = maxk(V,5);
data = data(index);
data = transpose(num2cell(data));
maks = transpose(num2cell(maks));
hasil = [data maks];
set(handles.tabel, 'Data', hasil);
