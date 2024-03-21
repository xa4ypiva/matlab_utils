% Новый отрисовщик с парсером дампа
function [signals_pulse, signals_found, signals_lost] = DrawerParser(folder, input_filename, type)

signal = ReadFile([folder, input_filename], type, 1);
[name] = strsplit(input_filename,"_");

% если у спеклайна в названии есть айди,то подставляет его ко всем сигналам
postfix = "";
if length(name) ~= 1
    postfix = string(strcat("_",name(2:end)));
end

signals_pulse = LoadFound(strcat(folder, 'finiteSignal.bin', postfix));
signals_lost = LoadFound(strcat(folder, 'lost.bin', postfix));
signals_found = LoadFound(strcat(folder, 'found.bin',postfix));

% Парсим
[mainHeader, raw] = MultidetectorParser(signal, 'int32');

raw = double(raw);
samples = double(mainHeader.samplesPerLine);
gridHz = double(mainHeader.gridHz);

f = (-samples / 2 : (samples - 1) / 2) * gridHz;
n = mainHeader.firstNumLine : mainHeader.firstNumLine + size(raw, 1) - 1;
f_MHz = f / 1e6; 

figure("Name", "Multidetector result");
image(f_MHz, n, 20 * log10(abs(raw)), 'CDataMapping', 'scaled')
xlabel(strcat("Frequency, MHz", " ( ", string(double(mainHeader.centerFreqHz) / 1e6), " MHz)"))
ylabel("Line number")



% Накладываем поверх цветные квадратики
for i = 1:length(signals_pulse) % <--- финиты
    if(signals_pulse(i).meanSnr > 0)
        signals_pulse(i).startFreq = (signals_pulse(i).startFreq-0.5 - samples / 2) * gridHz / 1e6;
        signals_pulse(i).stopFreq = (signals_pulse(i).stopFreq+0.5 - samples / 2) * gridHz / 1e6;
        rectangle('Position', ...
            [(signals_pulse(i).startFreq), (0.5+signals_pulse(i).timeStart) ...
             (signals_pulse(i).stopFreq - signals_pulse(i).startFreq), signals_pulse(i).duration], ...
            'LineWidth', 3);
    end
end

for i = 1:length(signals_lost) % <--- лосты
    if(signals_lost(i).meanSnr > 0)
        signals_lost(i).startFreq = (signals_lost(i).startFreq-0.5 - samples / 2) * gridHz / 1e6;
        signals_lost(i).stopFreq = (signals_lost(i).stopFreq+0.5 - samples / 2) * gridHz / 1e6;
        rectangle('Position', ...
        [(signals_lost(i).startFreq), (0.5+signals_lost(i).timeStart) ...
         ((signals_lost(i).stopFreq) - signals_lost(i).startFreq), signals_lost(i).duration], ...
        'LineWidth', 2, 'EdgeColor','r');
    end
end

end
