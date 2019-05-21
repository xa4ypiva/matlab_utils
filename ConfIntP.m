function [ci] = ConfIntP(prob, expNum)

f = 1.65; % beta = 0.9
ci = sqrt(prob .* (1-prob) * f^2 / expNum);

end

