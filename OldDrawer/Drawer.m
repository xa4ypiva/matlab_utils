function [signals_pulse, signals_found, signals_lost] = Drawer(folder, input_filename, len_line, grid_hz, hopsSessionId, centerFreq)
signal = ReadFile([folder, input_filename], 'int32', 1);
raw = reshape(signal, [len_line length(signal) / len_line])';
signals_pulse = LoadFound([folder 'finiteSignals.bin']);
signals_lost = LoadFound([folder 'lost.bin']);
signals_found = LoadFound([folder 'found.bin']);
hops = LoadHop([folder hopsSessionId]);
figure("Name", "Multidetector result");


f = (-len_line / 2 : (len_line - 1) / 2) * grid_hz;
n = 0 : size(raw, 1) - 1;
f_MHz = f / 1e6; 

image(f_MHz,n,20 * log10(abs(raw)),'CDataMapping', 'scaled')
xlabel("Frequency, MHz")
ylabel("Time, samples")

for i = 1:length(signals_pulse)
    if(signals_pulse(i).meanSnr > 0)
        signals_pulse(i).startFreq = (signals_pulse(i).startFreq - len_line / 2) * grid_hz / 1e6;
        signals_pulse(i).stopFreq = (signals_pulse(i).stopFreq  - len_line / 2) * grid_hz / 1e6;
        rectangle('Position', ...
            [(signals_pulse(i).startFreq), (signals_pulse(i).timeStart -0.5) ...
             (signals_pulse(i).stopFreq - signals_pulse(i).startFreq), signals_pulse(i).duration], ...
            'LineWidth', 3);
    end
end



% for i = 1:length(signals_lost)
%     if(signals_lost(i).meanSnr > 0)
%         signals_lost(i).startFreq = (signals_lost(i).startFreq-0.5 - len_line / 2) * grid_hz / 1e6;
%         signals_lost(i).stopFreq = (signals_lost(i).stopFreq+0.5 - len_line / 2) * grid_hz / 1e6;
%         rectangle('Position', ...
%         [(signals_lost(i).startFreq), (0.5+signals_lost(i).timeStart) ...
%          ((signals_lost(i).stopFreq) - signals_lost(i).startFreq), signals_lost(i).duration], ...
%         'LineWidth', 2, 'EdgeColor','r');
%     end
% end

for i = 1:length(hops)
    hops(i).startFreq = (hops(i).startFreq - centerFreq) / 1e6;
    hops(i).stopFreq = (hops(i).stopFreq - centerFreq) / 1e6;
    hops(i).timeStart = (hops(i).timeStart / 2000000);
    hops(i).timeEnd = (hops(i).timeEnd / 2000000);

    
    rectangle('Position', ...
    [(hops(i).startFreq), (hops(i).timeStart)-0.5 ...
    ((hops(i).stopFreq) - hops(i).startFreq), (hops(i).timeEnd - hops(i).timeStart)], ...
    'LineWidth', 2, 'EdgeColor','m');
end

end


