function M=MassVFAssembling3DP1OptV2(nq,nme,me,volumes,Num)
% function M=MassVFAssembling3DP1OptV2(nq,nme,me,volumes,Num)
%   Assembly of the Mass vectors fields Matrix by P1-Lagrange finite elements in 3D
%   - OptV2 version (see report).
%
% Parameters:
%  nq: total number of vertices of the 3D mesh,
%  nme: total number of elements.
%  me: Connectivity array, 4-by-nme array.
%      me(jl,k) is the storage index of the jl-th  vertex
%      of the k-th tetrahedron in the array q of vertices coordinates,
%      jl in {1,..,4} and k in {1,...,nme}.
%  volumes: Array of volumes, 1-by-nme array. volumes(k) is the volume
%         of the k-th tetrahedron.
%  Num: 
%    0 global alternate numbering with local alternate numbering (classical method), 
%    1 global block numbering with local alternate numbering,
%    2 global alternate numbering with local block numbering,
%    3 global block numbering with local block numbering.
%
% Return values:
%  M: Global Mass vectors fields matrix, (3xnq)-by-(3xnq) sparse matrix.
%
% Example:
%    Th=CubeMesh(10);
%    Mvf=MassVFAssembling3DP1OptV2(Th.nq,Th.nme,Th.me,Th.volumes,0);
%
% See also:
%   BuildIgJgP1VF, BuildElemMassVFMatFunc
%
% Copyright (C) 2013  CJS (LAGA)
%   see README for details

ElemMassVFMat=BuildElemMassVFMatFunc(Num);
E=ElemMassVFMat(20);
E=E(:)';
[Ig,Jg]=BuildIgJgP1VF(Num,me,nq);
Kg=zeros(144,nme);

It=find(E==2);
Vt=volumes/10;
for i=It
  Kg(i,:)=Vt;
end

It=find(E==1);
Vt=volumes/20;
for i=It
  Kg(i,:)=Vt;
end

M=sparse(Ig(:),Jg(:),Kg(:),3*nq,3*nq);
