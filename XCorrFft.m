function [result] = XCorrFft(s1, s2)

lenCorr = length(s1) + length(s2) - 1;
s1 = [s1, zeros(1,lenCorr - length(s1))];
s2 = [conj(s2(end : -1 : 1)), zeros(1, lenCorr - length(s2))];

y1 = fft(s1);
y2 = fft(s2);

result = y1 .* y2;

result = ifft(result);

end

