function ciOneSide = ConfIntStd(std, expNum, beta)
%Confidence Interval (one side) for standard deviation vector std
%beta - confidence probability [0, 1]
%expNum - number of experiments
%   Detailed explanation goes here

alpha = 1 - beta;
t = pbf(1 - alpha / 2);
stdstd = sqrt(2 * std / (expNum - 1));
ciOneSide = t * stdstd;

end

