function ElemStiffElasMat=BuildElemStiffElasMatFunc(Num)
%
% Copyright (C) 2013  CJS (LAGA)
%   see README for details
switch Num
case {0,1}
  ElemStiffElasMat=@(ql,volume,H) ElemStiffElasMat3DBaP1(ql,volume,H);
case {2,3}
  ElemStiffElasMat=@(ql,volume,H) ElemStiffElasMat3DBbP1(ql,volume,H);
end
