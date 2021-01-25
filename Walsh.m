function walshMatrix = Walsh(len)
%WALSH Summary of this function goes here
%   Detailed explanation goes here

N = len;
hm = hadamard(N);
hIdx = 0 : N-1;                                         % Hadamard index
M = log2(N) + 1;  
hIdxBin = fliplr(dec2bin(hIdx,M)) - '0';                % Bit reversing of the binary index
seqIdxBin = zeros(N, M-1);                              % Pre-allocate memory
for k = M : -1 : 2
    seqIdxBin(:,k) = xor(hIdxBin(:,k), hIdxBin(:,k-1)); % Binary sequency index 
end
seqIdx = seqIdxBin * pow2((M-1 : -1 : 0)');             % Binary to integer sequency index
walshMatrix = hm(seqIdx+1,:);                           % 1-based indexing

end

