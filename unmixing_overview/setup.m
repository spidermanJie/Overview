%%  setup 
%  
%  ----  Description -----------------------------------------------------
%
%  Set up the path for functions and data
%
%
%   Author:  Jose M. Bioucas Dias, January 2012
%            bioucas@lx.it.pt
%

%%
clear sunmixpath;
st = pwd;

sunmixpath = [ ...
    st,'\include;', ...
    st,'\datasets;', ...
    st,'\include\mves;', ...
    st,'\include\mvcnmf;', ...
    st,'\include\SPICE;', ...
    st,'\include\deca_code;', ...
    st,'\include\BM3D;', ...
    ];
addpath(sunmixpath);

clear sunmixpath st;



