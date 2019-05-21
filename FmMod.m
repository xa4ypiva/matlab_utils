function [iq] = FmMod(signalIn, fsHz, fDevHz)

fsTmpHz = 8 * fDevHz;
fcTmpHz = 2 * fDevHz;
s = Resample(signalIn, fsHz, fsTmpHz);
iq = fmmod(s, fcTmpHz, fsTmpHz, fDevHz);
N = length(iq);
t = (0 : N-1) / fsTmpHz;
iq = hilbert(iq) .* exp(1i * 2*pi*(-fcTmpHz) .* t);
iq = Resample(iq, fsTmpHz, fsHz);

end

