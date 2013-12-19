function [Kg]=ElemStiffMat3DVecP1D0(q,me,volumes)
% NAME 
%  [Kg]=ElemStiffMat3DVecP1D0(q,me,areas)
% INPUTS 
%  q     	: matrix 2 x nq 
%  me    	: matrix 3 x nme 
%  volumes 	: vector 1 x nme (elements volume)
% OUTPUTS 
%  Kg 	: matrix 16x nme
% DESCRIPTION
%  Compute P1-Lagrange Kg array for Stiff matrix (see report).
%  Numbering of local points in reference element is :
%    P=[(0, 0, 0), (1, 0, 0), (0, 1, 0), (0, 0, 1)]
%----------------------------------------
% Automatic generation with sage
% (c) Cuvelier F. email:cuvelier@math.univ-paris13.fr
%
% Copyright (C) 2013  CJS (LAGA)
%   see README for details
ndf=4;
nme=length(volumes);
D12=q(:,me(1,:))-q(:,me(2,:));
D13=q(:,me(1,:))-q(:,me(3,:));
D14=q(:,me(1,:))-q(:,me(4,:));
D23=q(:,me(2,:))-q(:,me(3,:));
D24=q(:,me(2,:))-q(:,me(4,:));
D34=q(:,me(3,:))-q(:,me(4,:));
G{1}=zeros(3,nme);
G{1}(1,:)=-D23(2,:).*D24(3,:) + D23(3,:).*D24(2,:);
G{1}(2,:)=D23(1,:).*D24(3,:) - D23(3,:).*D24(1,:);
G{1}(3,:)=-D23(1,:).*D24(2,:) + D23(2,:).*D24(1,:);
G{2}=zeros(3,nme);
G{2}(1,:)=D13(2,:).*D14(3,:) - D13(3,:).*D14(2,:);
G{2}(2,:)=-D13(1,:).*D14(3,:) + D13(3,:).*D14(1,:);
G{2}(3,:)=D13(1,:).*D14(2,:) - D13(2,:).*D14(1,:);
G{3}=zeros(3,nme);
G{3}(1,:)=-D12(2,:).*D14(3,:) + D12(3,:).*D14(2,:);
G{3}(2,:)=D12(1,:).*D14(3,:) - D12(3,:).*D14(1,:);
G{3}(3,:)=-D12(1,:).*D14(2,:) + D12(2,:).*D14(1,:);
G{4}=zeros(3,nme);
G{4}(1,:)=D12(2,:).*D13(3,:) - D12(3,:).*D13(2,:);
G{4}(2,:)=-D12(1,:).*D13(3,:) + D12(3,:).*D13(1,:);
G{4}(3,:)=D12(1,:).*D13(2,:) - D12(2,:).*D13(1,:);
clear D12 D13 D14 D23 D24 D34
vol36=36*volumes;
G1G1=sum(G{1}.*G{1},1)./vol36;
G1G2=sum(G{1}.*G{2},1)./vol36;
G1G3=sum(G{1}.*G{3},1)./vol36;
G1G4=sum(G{1}.*G{4},1)./vol36;
G2G2=sum(G{2}.*G{2},1)./vol36;
G2G3=sum(G{2}.*G{3},1)./vol36;
G2G4=sum(G{2}.*G{4},1)./vol36;
G3G3=sum(G{3}.*G{3},1)./vol36;
G3G4=sum(G{3}.*G{4},1)./vol36;
G4G4=sum(G{4}.*G{4},1)./vol36;
Kg=zeros(ndf*ndf,nme);
Kg(1,:)=+1.0*G1G1;
Kg(2,:)=+1.0*G1G2;
Kg(3,:)=+1.0*G1G3;
Kg(4,:)=+1.0*G1G4;
Kg(6,:)=+1.0*G2G2;
Kg(7,:)=+1.0*G2G3;
Kg(8,:)=+1.0*G2G4;
Kg(11,:)=+1.0*G3G3;
Kg(12,:)=+1.0*G3G4;
Kg(16,:)=+1.0*G4G4;
Kg([5, 9, 10, 13, 14, 15],:)=Kg([2, 3, 7, 4, 8, 12],:);
