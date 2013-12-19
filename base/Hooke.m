function H=Hooke(lambda,mu);
%
% Copyright (C) 2013  CJS (LAGA)
%   see README for details
d=lambda+2*mu;
H=zeros(6,6);
H(1:3,1:3)=lambda*ones(3,3)+2*mu*eye(3,3);
H(4,4)=mu;H(5,5)=mu;H(6,6)=mu;
