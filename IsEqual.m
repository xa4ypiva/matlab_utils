function [res] = IsEqual(x1, x2, tol)

res = abs(x1 - x2) < tol;

end

