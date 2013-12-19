function [e2q,e2t,e2n,e2do,e2be]=BuildEdges(Th)
% e2q  (nedx2) Edges to Nodes 
%   e2q(l,il) : indice dans le tableau Th.q du sommet il de l'arete l
% e2t  (nedx2) Edges to Triangles
%   e2t(l,1) : indice dans le tableau Th.me du 1er triangle adjacent 
%              a l'arete l 
%   e2t(l,2) : indice dans le tableau Th.me du 2eme triangle adjacent 
%              a l'arete l si arete interne sinon 0
% e2n (nedx2) : Edges to local number 
%   e2n(l,1)  : numero local de l'arete dans le 1er triangle (voir e2t)
%   e2n(l,2)  : numero local de l'arete dans le 2eme triangle (voir e2t)
%               s'il existe. 0 sinon.
% e2do (nedx1) 
%   e2do(l)   : +1 si l'arete est dans le sens direct pour le 1er triangle (voir e2t)
%               -1 sinon
% e2be (nbex4) : nbe number of boundary edges
%   e2be(l,1)  : numero de l'arete du bord 
%   e2be(l,2)  : +1 si l'arete est dans le "bon" sens (sens de Th.be)
%                -1 sinon
%   e2be(l,3)  : label du bord
%   e2be(l,4)  : permet de reconstruire le tableau Th.be
%        I=find(e2be(:,2)~=1);
%        K=e2be(:,4);
%        be=e2q(e2be(:,1),:);
%        be(I,:)=fliplr(be(I,:));
%        be(K,:)=be; 
%        be'- Th.be;
%        be' <=> Correspond a Th.be
%
% Copyright (C) 2013  CJS (LAGA)
%   see README for details
NumLocEdges=[ 1 2 ;2 3; 3 1]; % Numerotation locale des aretes 
                              % 
%NumLocEdges=[ 2 3 ;3 1; 1 2];

GlobalListEdges=[reshape(Th.me(NumLocEdges(:,1),:),3*Th.nme,1),reshape(Th.me(NumLocEdges(:,2),:),3*Th.nme,1)];

Edges2Elements=ones(3,1)*[1:Th.nme];
Edges2Elements=Edges2Elements(:);

Edges2LocalNum=[1; 2 ;3]*ones(1,Th.nme);
Edges2LocalNum=Edges2LocalNum(:);

[GlobalListEdgesSort,IS]=sort(GlobalListEdges,2);
PermutEdges=IS(:,2)-IS(:,1); % Contient 1 si arete dans le sens direct pour le triangle considéré
                             % Contient -1 sinon
                             
[e2q,IG,IE]=unique(GlobalListEdgesSort,'rows','first');   
e2t=Edges2Elements(IG,:);
e2n=Edges2LocalNum(IG,:);
e2do=PermutEdges(IG); % 

[e2ql,IGl,IEf]=unique(GlobalListEdgesSort,'rows','last');
e2tl=Edges2Elements(IGl,:);
e2nl=Edges2LocalNum(IGl,:);
Id=find(IG==IGl);
e2tl(Id)=0;
e2nl(Id)=0;
e2t=[e2t e2tl];
e2n=[e2n e2nl];

if nargout==5
  I=find(e2t(:,2)==0);
  %e2q(I,:); % Aretes du bord
  % Ne marche pas !
  %BE=Th.be;
  %[BE1,J]=sort(BE,1); % 
  %[BE2,K]=sort(BE1,2);
  BE=Th.be';
  [BE1,J1]=sort(BE,2); % BE(l,J1(l,:)) == BE1(l,:)
  [BE2,J2]=sortrows(BE1,[1 2]); % BE2 == BE1(J2,:)
  JJ=J1(J2,2)-J1(J2,1);

  e2be=[I JJ Th.bel(J2)' J2];
  %[BE(K,:), e2q(I,:) Th.bel(K)']
end
