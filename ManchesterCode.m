function [output, input2] = ManchesterCode(input, standard)

clock = zeros(1, length(input) * 2);
clock(2:2:end) = 1;
input2 = reshape(repmat(reshape(input', [], 1), 1, 2)', [], size(input, 1))';

switch (standard)
    case 'ieee'
    case 'thomas'
        clock = not(clock);
    otherwise
        error('Unsupported standard. Supported values are "ieee", "thomas"');
end

output = double(xor(input2, clock));

end

