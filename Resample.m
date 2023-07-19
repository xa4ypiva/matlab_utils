function [xOut] = Resample(xIn, fsIn, fsOut, n)

[p, q] = rat(fsOut / fsIn);

if (nargin < 4)
    xOut = resample(xIn, p, q);
else
    xOut = resample(xIn, p, q, n);
end


end

