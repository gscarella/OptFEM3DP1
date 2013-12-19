function G=ComputeGradientVec(q,me)
% function G=ComputeGradientVec(q,me)
% Compute, for each tetraedra, the gradients of the 4 local P1-Lagrange basis functions 
% multiply by 6|T|.
%
% Parameters:
%  q: Array of vertices coordinates, 3-by-nq array.
%     q(il,j) is the il-th coordinate of the j-th vertex, il in {1,3}
%     and j in {1,...,nq}.

%  me: Connectivity array, 4-by-nme array.
%      me(jl,k) is the storage index of the jl-th  vertex
%      of the k-th tetrahedron in the array q of vertices coordinates,
%      jl in {1,..,4} and k in {1,...,nme}.
% 
% Return values:
%   G: array of 4 cells. each cell is an 3-by-nme array.
%   G{il}(:,k) is 6|Tk| times the gradient of the local P1-Lagrange basis function
%   associated to point q(:,me(il,:)) on the the tetrahedron Tk.
%
% Copyright (C) 2013  CJS (LAGA)
%   see README for details
D12=q(:,me(1,:))-q(:,me(2,:));
D13=q(:,me(1,:))-q(:,me(3,:));
D14=q(:,me(1,:))-q(:,me(4,:));
D23=q(:,me(2,:))-q(:,me(3,:));
D24=q(:,me(2,:))-q(:,me(4,:));
D34=q(:,me(3,:))-q(:,me(4,:));

G{1}=[-D23(2,:).*D24(3,:) + D23(3,:).*D24(2,:); ...
       D23(1,:).*D24(3,:) - D23(3,:).*D24(1,:); ...
      -D23(1,:).*D24(2,:) + D23(2,:).*D24(1,:)];
G{2}=[ D13(2,:).*D14(3,:) - D13(3,:).*D14(2,:); ...
      -D13(1,:).*D14(3,:) + D13(3,:).*D14(1,:); ...
       D13(1,:).*D14(2,:) - D13(2,:).*D14(1,:)];

G{3}=[-D12(2,:).*D14(3,:) + D12(3,:).*D14(2,:); ...
       D12(1,:).*D14(3,:) - D12(3,:).*D14(1,:); ...
      -D12(1,:).*D14(2,:) + D12(2,:).*D14(1,:)];
G{4}=[ D12(2,:).*D13(3,:) - D12(3,:).*D13(2,:); ...
      -D12(1,:).*D13(3,:) + D12(3,:).*D13(1,:); ...
       D12(1,:).*D13(2,:) - D12(2,:).*D13(1,:)];
