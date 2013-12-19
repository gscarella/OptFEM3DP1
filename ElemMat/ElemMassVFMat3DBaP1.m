function M=ElemMassVFMat3DBaP1(volume)
%D=(ones(4,4)+eye(4,4))*volume/20;
%
% Copyright (C) 2013  CJS (LAGA)
%   see README for details
D=ElemMassMat3DP1D0(volume);
M=zeros(12,12);
I=[1,4,7,10];
for d=1:3
  M(I,I)=D;
  I=I+1;
end
