function [out] = Normalize(in, value_max)
out = in ./ max([max(real(in)), max(imag(in))]) * value_max;
end

