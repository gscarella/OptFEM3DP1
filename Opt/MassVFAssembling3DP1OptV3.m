function M=MassVFAssembling3DP1OptV3(nq,nme,me,volumes,Num)
%
% Copyright (C) 2013  CJS (LAGA)
%   see README for details

ElemMassVFMat=BuildElemMassVFMatFunc(Num);
E=ElemMassVFMat(20);
E=E(:)';
[Ig,Jg]=BuildIgJgP1VF(Num,me,nq);

I=find(E~=0);
Ig=Ig(I,:);
Jg=Jg(I,:);
Kg=zeros(length(I),nme);
E=E(I);
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
