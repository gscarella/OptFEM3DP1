function [Elem]=ElemStiffElasMat3DBaP1(ql,V,H)
% NAME 
%  [Elem]=ElemStiffElasMat3DBaP1(ql,V,H)
% INPUTS 
%  area 	: double (element volume)
%  ql    	: matrix 3x4
%        	  ql(:,il) ...
%  H    : Hooke matrix (6x6)
% OUTPUTS 
%  Elem 	: matrix 12x12
% DESCRIPTION
%  Compute P1-Lagrange elementary Stiff matrix.
%  Numbering of local points in reference element is :
%    P=[(0, 0, 0), (1, 0, 0), (0, 1, 0), (0, 0, 1)]
%----------------------------------------
% Automatic generation with sage
% (c) Cuvelier F. email:cuvelier@math.univ-paris13.fr
%
% Copyright (C) 2013  CJS (LAGA)
%   see README for details
D12=ql(:,1)-ql(:,2);
D13=ql(:,1)-ql(:,3);
D14=ql(:,1)-ql(:,4);
D23=ql(:,2)-ql(:,3);
D24=ql(:,2)-ql(:,4);
D34=ql(:,3)-ql(:,4);
M=zeros(3,4);
M(1,1)=-D23(2)*D24(3) + D23(3)*D24(2);
M(2,1)=D23(1)*D24(3) - D23(3)*D24(1);
M(3,1)=-D23(1)*D24(2) + D23(2)*D24(1);
M(1,2)=D13(2)*D14(3) - D13(3)*D14(2);
M(2,2)=-D13(1)*D14(3) + D13(3)*D14(1);
M(3,2)=D13(1)*D14(2) - D13(2)*D14(1);
M(1,3)=-D12(2)*D14(3) + D12(3)*D14(2);
M(2,3)=D12(1)*D14(3) - D12(3)*D14(1);
M(3,3)=-D12(1)*D14(2) + D12(2)*D14(1);
M(1,4)=D12(2)*D13(3) - D12(3)*D13(2);
M(2,4)=-D12(1)*D13(3) + D12(3)*D13(1);
M(3,4)=D12(1)*D13(2) - D12(2)*D13(1);
B=zeros(12,6);
k=0;
for il=1:4
  B(1+k,[1,4,5])=M(:,il);
  B(2+k,[4,2,6])=M(:,il);
  B(3+k,[5,6,3])=M(:,il);
  k=k+3;
end

Elem=B*H*B'/(36*V);
