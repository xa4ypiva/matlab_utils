function [xOut] = Resample(xIn, fsIn, fsOut)

factor = fsOut / fsIn;
[p, q] = rat(factor);
xOut = resample(xIn, p, q);

end

