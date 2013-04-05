
% Name: gen_data_sets
%
% Generate data sets used in the paper
%
% J. Bioucas-Dias, A. Plaza, N. Dobigeon, M. Parente, and J. Du,
% "Overview on spectral unmixing: geometrical, statistical, and sparse
% regression based approaches", Submitted to IEEE Journal of Selected
% Topics in Applied Earth Observations and Remote Sensing, 2012.
%
%
%% Description
%
%  generates data data sets according to the linear mixing model 
%  
%      Y = M*X + W
%
%   Y --> [Bxn] (data set); n B-dimensional spectral vectors
%   M --> [B*p] (mixing matrix) p B-dimensional endmember signatures 
%   X --> [p*n] (fractional abundances) n p-dimensional  vectors of fractional abundances
%   W --> [Bxn] (additive noise)  n B-dimensional noise  vectors
%
%  The data sets are generated by the function spectMixGen depend of the
%  following paremeters:
%
%   --> M,n
%   --> Signal to noise ratio (SNR)
%   --> Noise spectral (power along the B bands) shape
%   --> Statistics of the fractional abundances
%   --> signatute variability
%   --> include pure pixels
%   --> max purity of the fractional anundances
%    
%  See next how the names of the data set encode the above parameters
%
%%
% Name of the data sets: 
%
%   Rxxxxx --> Real data set; xxxx name of the data set
%
%   SxxxPxxxF2xxx...Fkxxx... --> Simulated data set, where
%                                Fk\in {B,N,PP,MP,XS,O,SNR,NS}
%
%  
%   ----- S - simulated (mandatory) ) -----------------------------------
%    xxxx \in {ud, usgs} 
%      ud == ud: elements of matrix M are sampled from an iid
%                Uniform[0,1] distribution
%      ud == usgs: colums of the mixing matrix are sampled from
%                      the USGS library
%
%   ----- P - number of endmembers (mandatory) --------------------------
%    xxxx -> number of endmembers
%
%   ----- B - number of bands (optional) --------------------------------
%    xxxx -> number of bands (default 224)
%
%   ----- N - number of pixels (optional) -------------------------------
%    xxxx -> number of pixels (default 5000)
%
%   ----- PP - contains pure pixel (optional) ---------------------------
%    the last p vectors of fractional abundances are set to eye(p))
%    default (no PP)
%
%   ----- MP - max purity (optional) ------------------------------------
%    xxx \in [1/p,1] -> frational endmembers are no larger than xxx
%        (default 1) 
%
%   ----- XS - fractional abundances statistics (optional) --------------
%    xxx >= -1  -> Diriclet parameter for all sources (default 1)  
%
%   ----- O -  oulliers (optional)  ----------------------------
%    xxx -> number or outliers
%       
%   ----- SNR - signal-to-noise ratio (optional) ------------------------
%    xxxx -> signal-to-noise ratio in dB (default 40 dB)
%
%   ----- NS - noise shape (optional) -----------------------------------
%   xxxx  -> type of additive Gaussian noise shape (default iid)
%       0 == iid
%       1 == Gaussian shape with parameters [1  B/2 10] (see spectMixGen)
%       2 == Rectagular shape with parameters [1 B/2 10] (see spectMixGen)
%
%   ---------------------------------------------------------------------      
%% 
%  
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Author: Jose M. Bioucas-Dias (January, 2012)
%
%
%
%% beginning  

clear all,
close all
verbose = 1;
dataset_no = 0;


%%
%--------------------------------------------------------------------------
%        generate SudP5SNR40 data set
%-------------------------------------------------------------------------
dataset_no = dataset_no + 1;
% initializa random number generator
rand('seed',31416 + dataset_no);
randn('seed',31416 + dataset_no);

p = 5;
B = 224;
N = 5000;

M = rand(B,p);
SNR = 40;
 

SHAPE_PARAMETER = 1;    % sources uniformely distributed over the simplex
MAX_PURIRY = 1;         % pure pixels;
OUTLIERS   = 0;         % no outliers
PURE_PIXELS = 'no';    % pure pixels

[Y,x,noise] = spectMixGen(M,N,'Source_pdf', 'Diri_id','pdf_pars',SHAPE_PARAMETER,...
    'max_purity',MAX_PURIRY*ones(1,p),'no_outliers',OUTLIERS, ...
    'pure_pixels', PURE_PIXELS,'violation_extremes',[1,1.2],'snr', SNR, ...
    'noise_shape','uniform');


save SudP5SNR40 Y M x




%%
%--------------------------------------------------------------------------
%        generate SusgsP5SNR40 data set
%-------------------------------------------------------------------------
dataset_no = dataset_no + 1;
% initializa random number generator
rand('seed',31416 + dataset_no);
randn('seed',31416 + dataset_no);

p = 5;
N = 5000;


load('USGS_1995_Library')
[L n_materiais]=size(datalib);
% select randomly
sel_mat = 4+randperm(n_materiais-4);
sel_mat = sel_mat(1:p);
M = datalib(:,sel_mat);

SNR = 40;
 

SHAPE_PARAMETER = 1;    % sources uniformely distributed over the simplex
MAX_PURIRY = 1;         % pure pixels;
OUTLIERS   = 0;         % no outliers
PURE_PIXELS = 'no';    % pure pixels


[Y,x,noise] = spectMixGen(M,N,'Source_pdf', 'Diri_id','pdf_pars',SHAPE_PARAMETER,...
    'max_purity',MAX_PURIRY*ones(1,p),'no_outliers',OUTLIERS, ...
     'pure_pixels', PURE_PIXELS,'violation_extremes',[1,1.2],'snr', SNR, ...
    'noise_shape','uniform');


save SusgsP5SNR40 Y M x


%%
%--------------------------------------------------------------------------
%        generate SusgsP5NS1SNR30 data set
%-------------------------------------------------------------------------
dataset_no = dataset_no + 1;
% initializa random number generator
rand('seed',31416 + dataset_no);
randn('seed',31416 + dataset_no);

p = 5;
N = 5000;


load('USGS_1995_Library')
[B n_materiais]=size(datalib);
% select randomly
sel_mat = 4+randperm(n_materiais-4);
sel_mat = sel_mat(1:p);
M = datalib(:,sel_mat);

SNR = 30;
 

SHAPE_PARAMETER = 1;    % sources uniformely distributed over the simplex
MAX_PURIRY = 1;         % pure pixels;
OUTLIERS   = 0;         % no outliers
PURE_PIXELS = 'no';     % pure pixels
%NOISE_PAR = [1 B/2 10];


[Y,x,noise] = spectMixGen(M,N,'Source_pdf', 'Diri_id','pdf_pars',SHAPE_PARAMETER,...
    'max_purity',MAX_PURIRY*ones(1,p),'no_outliers',OUTLIERS, ...
     'pure_pixels', PURE_PIXELS,'violation_extremes',[1,1.2],'snr', SNR, ...
     'noise_shape','uniform');


save SusgsP5SNR30 Y M x



%%
%--------------------------------------------------------------------------
%                 SusgsP5PPSNR30, SusgsP5PPSNR40
%                 SusgsP5MP08SNR30, SusgsP5MP08SNR40
%                 SusgsP5XS10SNR30,  SusgsP5XS10SNR40
%                 SusgsP5MP08O3SNR30, SusgsP5MP08O3SNR40
%-------------------------------------------------------------------------
dataset_no = dataset_no + 10;
% initializa random number generator
rand('seed',31416 + dataset_no);
randn('seed',31416 + dataset_no);

% ----------- pure pixel -----------------------

p = 5;
%B = 224;
N = 5000;


load('USGS_pruned_10_deg.mat')
[B n_materials]=size(datalib);
% select randomly
sel_mat = 4+randperm(n_materials-4);
sel_mat = sel_mat(1:p);
M = datalib(:,sel_mat);


SNR = 30;
SHAPE_PARAMETER = 1;    % sources uniformely distributed over the simplex
MAX_PURIRY = 1;         % pure pixels;
OUTLIERS   = 0;         % no outliers
PURE_PIXELS = 'yes';    % pure pixels

[Y,x,noise] = spectMixGen(M,N,'Source_pdf', 'Diri_id','pdf_pars',SHAPE_PARAMETER,...
    'max_purity',MAX_PURIRY*ones(1,p),'no_outliers',OUTLIERS, ...
    'pure_pixels', PURE_PIXELS,'violation_extremes',[1,1.2],'snr', SNR, ...
    'noise_shape','uniform');

save SusgsP5PPSNR30 Y M x

% --- 40 dB ------
SNR = 40;
[Y,x,noise] = spectMixGen(M,N,'Source_pdf', 'Diri_id','pdf_pars',SHAPE_PARAMETER,...
    'max_purity',MAX_PURIRY*ones(1,p),'no_outliers',OUTLIERS, ...
    'pure_pixels', PURE_PIXELS,'violation_extremes',[1,1.2],'snr', SNR, ...
    'noise_shape','uniform');


save SusgsP5PPSNR40 Y M x


% ----------- non-pure pixel -----------------------
SNR = 30;
SHAPE_PARAMETER = 1;    % sources uniformely distributed over the simplex
MAX_PURIRY = 0.8;       % pure pixels;
OUTLIERS   = 0;         % no outliers
PURE_PIXELS = 'no';     % pure pixels

[Y,x,noise] = spectMixGen(M,N,'Source_pdf', 'Diri_id','pdf_pars',SHAPE_PARAMETER,...
    'max_purity',MAX_PURIRY*ones(1,p),'no_outliers',OUTLIERS, ...
    'pure_pixels', PURE_PIXELS,'violation_extremes',[1,1.2],'snr', SNR, ...
    'noise_shape','uniform');

save SusgsP5MP08SNR30 Y M x 

% --- 40 dB ------
SNR = 40;
[Y,x,noise] = spectMixGen(M,N,'Source_pdf', 'Diri_id','pdf_pars',SHAPE_PARAMETER,...
    'max_purity',MAX_PURIRY*ones(1,p),'no_outliers',OUTLIERS, ...
    'pure_pixels', PURE_PIXELS,'violation_extremes',[1,1.2],'snr', SNR, ...
    'noise_shape','uniform');

save SusgsP5MP08SNR40 Y M x 


% ----------- highly mixed  -----------------------
SNR = 30;
SHAPE_PARAMETER = 10;   % sources clustered in the center of the simplex simplex
MAX_PURIRY = 1;         % pure pixels;
OUTLIERS   = 0;         % no outliers
PURE_PIXELS = 'no';     % pure pixels

[Y,x,noise] = spectMixGen(M,N,'Source_pdf', 'Diri_id','pdf_pars',SHAPE_PARAMETER,...
    'max_purity',MAX_PURIRY*ones(1,p),'no_outliers',OUTLIERS, ...
    'pure_pixels', PURE_PIXELS,'violation_extremes',[1,1.2],'snr', SNR, ...
    'noise_shape','uniform');

save SusgsP5XS10SNR30 Y M x 
% --- 40 dB ------
SNR = 40;
[Y,x,noise] = spectMixGen(M,N,'Source_pdf', 'Diri_id','pdf_pars',SHAPE_PARAMETER,...
    'max_purity',MAX_PURIRY*ones(1,p),'no_outliers',OUTLIERS, ...
    'pure_pixels', PURE_PIXELS,'violation_extremes',[1,1.2],'snr', SNR, ...
    'noise_shape','uniform');

save SusgsP5XS10SNR40 Y M x 


% ----------- non pure pixels + outliers   -----------------------
SNR = 30;
SHAPE_PARAMETER = 1;   % sources clustered in the center of the simplex simplex
MAX_PURIRY = 0.8;      % pure pixels;
OUTLIERS   = 3;        % no outliers
PURE_PIXELS = 'no';    % pure pixels


[Y,x,noise] = spectMixGen(M,N,'Source_pdf', 'Diri_id','pdf_pars',SHAPE_PARAMETER,...
    'max_purity',MAX_PURIRY*ones(1,p),'no_outliers',OUTLIERS, ...
    'pure_pixels', PURE_PIXELS,'violation_extremes',[1,1.2],'snr', SNR, ...
    'noise_shape','uniform');

save SusgsP5MP08O3SNR30 Y M x 

% --- 40 dB ------
SNR = 40;

[Y,x,noise] = spectMixGen(M,N,'Source_pdf', 'Diri_id','pdf_pars',SHAPE_PARAMETER,...
    'max_purity',MAX_PURIRY*ones(1,p),'no_outliers',OUTLIERS, ...
    'pure_pixels', PURE_PIXELS,'violation_extremes',[1,1.2],'snr', SNR, ...
    'noise_shape','uniform');

save SusgsP5MP08O3SNR40 Y M x 


% ----------------------------------------------------------------------


