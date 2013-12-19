function [Elem]=ElemStiffElasMat3DBbP1(ql,V,H)
% NAME 
%  [Elem]=ElemStiffElasMat3DBbP1(ql,V,H)
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
G=zeros(3,4);
G(1,1)=-D23(2)*D24(3) + D23(3)*D24(2);
G(2,1)=D23(1)*D24(3) - D23(3)*D24(1);
G(3,1)=-D23(1)*D24(2) + D23(2)*D24(1);
G(1,2)=D13(2)*D14(3) - D13(3)*D14(2);
G(2,2)=-D13(1)*D14(3) + D13(3)*D14(1);
G(3,2)=D13(1)*D14(2) - D13(2)*D14(1);
G(1,3)=-D12(2)*D14(3) + D12(3)*D14(2);
G(2,3)=D12(1)*D14(3) - D12(3)*D14(1);
G(3,3)=-D12(1)*D14(2) + D12(2)*D14(1);
G(1,4)=D12(2)*D13(3) - D12(3)*D13(2);
G(2,4)=-D12(1)*D13(3) + D12(3)*D13(1);
G(3,4)=D12(1)*D13(2) - D12(2)*D13(1);
B=zeros(12,6);

for il=1:4
  B(il,[1,4,5])=G(:,il);
  B(il+4,[4,2,6])=G(:,il);
  B(il+8,[5,6,3])=G(:,il);
end
%  for il=1:4
%    B(il+4,[4,2,6])=M(:,il);
%  end
%  for il=1:4
%    B(il+8,[5,6,3])=M(:,il);
%  end

Elem=B*H*B'/(36*V);
