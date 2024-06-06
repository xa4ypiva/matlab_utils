function [out] = Normalize(in, value_max, method)
if (nargin < 3)
    method = "abs";
end

switch lower(method)
    case "abs"
        norm_coef = value_max / max(abs(in));
    case "iq"
        norm_coef = value_max / max([max(abs(real(in))), max(abs(imag(in)))]);
    otherwise
        error("method may be [""abs"", ""iq""]");
end

out = in * norm_coef;
end

