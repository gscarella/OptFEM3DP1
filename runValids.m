function runValids(varargin)
% function runValids(varargin)
%   Run validation tests for Mass , Stiff , StiffElas and MassVF matrices in 3D.
%   For each assembly matrix, we make 3 tests 
%     - Test 1 : computation of the assembly Matrix using all the versions giving 
%       errors and computation times.
%     - Test 2 : comparison of the associated integral and its P1-Lagrange approximation.
%     - Test 3 : retrieving of numerical order for P1-Lagrange approximation.
%
% Parameters:
%   save    :  set to true to save figures in 'image' directory.
%   percent :  value for resizing the figure (only png format). See #SaveFigure
%
% Example:
%     runValids('save',true,'percent',50)
%
% See also:
%   validMass3DP1, validStiff3DP1, validStiffElas3DP1, validMassVF3DP1, SaveFigure
%
% Copyright (C) 2013  CJS (LAGA)
%   see README for details
InitOptFEM3D();

p = inputParser; 
  
if isOctave()
  p=p.addParamValue('save', false, @islogical );
  p=p.addParamValue('percent', 50 , @(t) ((t>0)&&(t<=100)) );
  p=p.parse(varargin{:});
else % Matlab
  p.addParamValue('save', false, @islogical );
  p.addParamValue('percent', 50 , @(t) ((t>0)&&(t<=100)) );
  p.parse(varargin{:});
end
close all

figure(1)
validMass3DP1();
SaveFigure(p.Results.save,'validMass3DP1',p.Results.percent)
figure(2)
validMassVF3DP1(0);
SaveFigure(p.Results.save,'validMassVF3DP1',p.Results.percent)
figure(3)
validStiff3DP1();
SaveFigure(p.Results.save,'validStiff3DP1',p.Results.percent)
figure(4)
validStiffElas3DP1(0);
SaveFigure(p.Results.save,'validStiffElas3DP1',p.Results.percent)
