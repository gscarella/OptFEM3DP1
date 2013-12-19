function Th=CubeMesh(N)
% function Th=CubeMesh(N)
% Initialization of a minimalist 3D Mesh structure for the cube domain
%
% Cube domain is [0,1]-by-[0,1]-by-[0,1].
%
% There are N+1 vertices on each edges and (N+1)-by-(N+1) vertices on
% each boundary faces.
%
% Parameters:
%  N: integer, number, minus on, of vertices on a edge 
%
% Return values:
%  Th: mesh structure
%
% Generated fields of Mesh:
%  nq: total number of vertices.
%  q: Array of vertices coordinates, 3-by-nq array.
%     q(il,j) is the il-th coordinate of the j-th vertex, il in {1,3}
%     and j in {1,...,nq}.
%  nme: total number of elements.
%  me: Connectivity array, 4-by-nme array.
%      me(jl,k) is the storage index of the jl-th  vertex
%      of the k-th tetrahedron in the array q of vertices coordinates,
%      jl in {1,..,4} and k in {1,...,nme}.
%  volumes: Array of volumes, 1-by-nme array. volumes(k) is the volume
%         of the k-th tetrahedron.
%
% See also
%  ComputeVolumesOpt
%
% Copyright (C) 2013  CJS (LAGA)
%   see README for details

  L=1;
  h=L/N;t=0:h:L;
  if isOctave()
    assert(~isempty(ver('msh')),'package msh must be installed')
    mesh=msh3m_structured_mesh(t,t,t,1,1:6); % package msh
    me=mesh.t(1:4,:);
    q=mesh.p;
  else
    [x,y,z] = meshgrid(t,t,t);
    q=[x(:) y(:) z(:)];
    tri = delaunayn(q);
    me=tri';
    q=q';
  end
  
  nq=length(q);
  nme=length(me);
  
  V=ComputeVolumesOpt(me,q);
  Th=struct('q',q,'me',me, ...
            'nq',size(q,2), ...
            'nme',size(me,2),...
            'volumes',V);
            
%            'areas',ComputeAreaOpt(q,me),...
%            'lbe',EdgeLengthOpt(be,q));
  
