function R=StiffAssembling3DP1base(nq,nme,q,me,volumes)
% function R=StiffAssembling3DP1base(nq,nme,q,me,volumes)
%   Assembly of the Stiffness Matrix by P1-Lagrange finite elements in 3D
%   - Basic version (see report).
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
%
% Return values:
%  R: Global stiffness matrix, nq-by-nq sparse matrix.
%
% Example:
%    Th=CubeMesh(10);
%    R=StiffAssembling3DP1base(Th.nq,Th.nme,Th.q,Th.me,Th.volumes);
%  
% See also:
%   ElemStiffMat3DP1D0
%
% Copyright (C) 2013  CJS (LAGA)
%   see README for details
R=sparse(nq,nq);
for k=1:nme
    E=ElemStiffMat3DP1D0(q(:,me(:,k)),volumes(k));
    for il=1:4
        i=me(il,k);
        for jl=1:4
            j=me(jl,k);
            R(i,j)=R(i,j)+E(il,jl);
        end
    end
end
