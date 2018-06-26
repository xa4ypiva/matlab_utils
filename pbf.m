function t = pbf( x )
%PROBIT FUNCTION
%   Detailed explanation goes here

t = sqrt(2) * erfinv(2 * x - 1);

end

