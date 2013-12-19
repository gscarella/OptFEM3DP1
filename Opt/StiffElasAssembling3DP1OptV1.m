function K=StiffElasAssembling3DP1OptV1(nq,nme,q,me,volumes,lambda,mu,Num)
% function K=StiffElasAssembling3DP1OptV1(nq,nme,q,me,volumes,lambda,mu,Num)
%   Assembly of the Stiffness Elasticity Matrix by P1-Lagrange finite elements in 3D
%   - OptV1 version (see report).
%
% Parameters:
%  nq: total number of vertices of the 3D mesh,
%  nme: total number of elements.
%  q: Array of vertices coordinates, 3-by-nq array.
%     q(il,j) is the il-th coordinate of the j-th vertex, il in {1,3}
%     and j in {1,...,nq}.
%  me: Connectivity array, 4-by-nme array.
%      me(jl,k) is the storage index of the jl-th  vertex
%      of the k-th tetrahedron in the array q of vertices coordinates,
%      jl in {1,..,4} and k in {1,...,nme}.
%  volumes: Array of volumes, 1-by-nme array. volumes(k) is the volume
%         of the k-th tetrahedron.
%  lambda: the first Lame coefficient in Hooke's law
%  mu: the second Lame coefficient in Hooke's law
%  Num: 
%    0 global alternate numbering with local alternate numbering (classical method), 
%    1 global block numbering with local alternate numbering,
%    2 global alternate numbering with local block numbering,
%    3 global block numbering with local block numbering.
%
% Return values:
%  K: Global stiffness elasticity matrix, (3xnq)-by-(3xnq) sparse matrix.
%
% Example:
%    Th=CubeMesh(10);
%    KK=StiffElasAssembling3DP1OptV1(Th.nq,Th.nme,Th.q,Th.me,Th.volumes,1.,0.25,0);
%
% See also:
%   BuildIkFunc, BuildElemStiffElasMatFunc


%
% Copyright (C) 2013  CJS (LAGA)
%   see README for details
ElemStiffElasMat=BuildElemStiffElasMatFunc(Num);
GetI=BuildIkFunc(Num,nq);
H=Hooke(lambda,mu);
Ig=zeros(144*nme,1);Jg=zeros(144*nme,1);Kg=zeros(144*nme,1);
kk=1:144;
for k=1:nme
  Me=ElemStiffElasMat(q(:,me(:,k)),volumes(k),H);
  I=GetI(me,k);
  jA=ones(12,1)*I;
  iA=jA';

  Ig(kk)=iA(:);
  Jg(kk)=jA(:);
  Kg(kk)=Me(:);
  kk=kk+144;
end
K=sparse(Ig,Jg,Kg,3*nq,3*nq);
