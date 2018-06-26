function [ signal ] = SignalOversampleNoFilting( x, factor )
%SIGNALOVERSAMPLENOFILTING Summary of this function goes here
%   Detailed explanation goes here

lenX = length(x);
lenSignal = lenX * factor;
signal = zeros(1, lenSignal);
for i = 1 : lenX
    signal((i-1)*factor+1 : i*factor) = x(i);
end

end

