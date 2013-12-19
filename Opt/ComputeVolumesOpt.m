function volumes=ComputeVolumesOpt(me,q)
%
% Copyright (C) 2013  CJS (LAGA)
%   see README for details
for i=1:3
  D21{i}=q(i,me(2,:))-q(i,me(1,:));
  D31{i}=q(i,me(3,:))-q(i,me(1,:));
  D41{i}=q(i,me(4,:))-q(i,me(1,:));
end

volumes=abs((D21{1}.*(D31{2}.*D41{3}-D31{3}.*D41{2})+ ...
         D31{1}.*(D41{2}.*D21{3}-D41{3}.*D21{2})+ ...
         D41{1}.*(D21{2}.*D31{3}-D21{3}.*D31{2}))/6.);
