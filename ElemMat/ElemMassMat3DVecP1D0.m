function [Kg]=ElemMassMat3DVecP1D0(volumes)
% NAME 
%  [Kg]=ElemMassMat3DVecP1D0(volumes)
% INPUTS 
%  volumess 	: vector 1 x nme (elements volume)
% OUTPUTS 
%  Kg 	: matrix 16 x nme
% DESCRIPTION
%  Compute P1-Lagrange Kg array for Mass matrix (see report).
%  Numbering of local points in reference element is :
%    P=[(0, 0, 0), (1, 0, 0), (0, 1, 0), (0, 0, 1)]
%----------------------------------------
% Automatic generation with sage
% (c) Cuvelier F. email:cuvelier@math.univ-paris13.fr
%
% Copyright (C) 2013  CJS (LAGA)
%   see README for details
ndf=4;
Kg=zeros(ndf*ndf,length(volumes));
A10=volumes/10;
A20=volumes/20;
Kg(1,:)=A10;
Kg(2,:)=A20;
Kg(3,:)=A20;
Kg(4,:)=A20;
Kg(6,:)=A10;
Kg(7,:)=A20;
Kg(8,:)=A20;
Kg(11,:)=A10;
Kg(12,:)=A20;
Kg(16,:)=A10;
Kg([5, 9, 10, 13, 14, 15],:)=Kg([2, 3, 7, 4, 8, 12],:);
