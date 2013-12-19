function ElemMassVFMat=BuildElemMassVFMatFunc(Num)
%
% Copyright (C) 2013  CJS (LAGA)
%   see README for details
switch Num
case {0,1}
  ElemMassVFMat=@(volume) ElemMassVFMat3DBaP1(volume);
case {2,3}
  ElemMassVFMat=@(volume) ElemMassVFMat3DBbP1(volume);
end
