function InitOptFEM3D()
% function InitOptFEM3D()
%   Initialization of the MATLAB search path and loading of msh
%   package for Octave
%
%   If Octave is used, the msh and general packages are automatically loaded.
%
%
% Copyright (C) 2013  CJS (LAGA)
%   see README for details
  addpath([pwd,filesep,'common']);
  addpath([pwd,filesep,'Opt']);
  addpath([pwd,filesep,'base']);
  addpath([pwd,filesep,'valid']);
  addpath([pwd,filesep,'ElemMat']);
  addpath([pwd,filesep,'bench']);
  if isOctave()
     more off
 
     pkg load msh
     pkg load general
     graphics_toolkit('fltk')
  end
