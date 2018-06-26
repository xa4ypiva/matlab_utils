function ciOneSide = ConfIntStd(std, expNum, beta)
%Confidence Interval (one side) for standard deviation vector std
%beta - confidence probability [0, 1]
%expNum - number of experiments
%   Detailed explanation goes here

alpha = 1 - beta;
t = pbf(1 - alpha / 2);

dataLen = length(std);
stdstd = zeros(1, dataLen);
for i = 1 : dataLen 
    stdstd(i) = sqrt(2 * std(i) / (expNum - 1));
end
ciOneSide = t * stdstd;

end

