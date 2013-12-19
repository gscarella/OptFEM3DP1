function [Elem]=ElemMassMat3DP1D0(V)
% NAME 
%  [Elem]=ElemMassMat3DP1D0(V)
% INPUTS 
%  V 	: double (element volume)
% OUTPUTS 
%  Elem 	: matrix 4x4
% DESCRIPTION
%  Compute P1-Lagrange elementary Mass matrix.
%  Numbering of local points in reference element is :
%    P=[(0, 0, 0), (1, 0, 0), (0, 1, 0), (0, 0, 1)]
%----------------------------------------
% Automatic generation with sage
% (c) Cuvelier F. email:cuvelier@math.univ-paris13.fr
%
% Copyright (C) 2013  CJS (LAGA)
%   see README for details
Elem=[ ...
[ 2, 1, 1, 1]; ...
[ 1, 2, 1, 1]; ...
[ 1, 1, 2, 1]; ...
[ 1, 1, 1, 2]]*V/20;
%Elem=(ones(4,4)+eye(4,4))*volume/12;
