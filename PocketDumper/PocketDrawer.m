% Новый отрисовщик с парсером дампа
function [parsedLines, signals_pulse, signals_found, signals_lost, parsedHops] = PocketDrawer(folder, queryId)



% подставляем айди задания ко всем файлам
postfix = "";
if ~isempty(queryId)
    postfix = string(strcat("_",queryId));
end

% Загружаем файлы
signal = ReadFile(strcat(folder, 'specline', postfix), "int32", 1);

signals_pulse = LoadPulses(strcat(folder, 'finite.bin', postfix));
signals_lost = LoadPulses(strcat(folder, 'lost.bin', postfix));
signals_found = LoadPulses(strcat(folder, 'found.bin',postfix));
hops = LoadHops(strcat(folder, 'hops.bin', postfix));

% Парсим
[mainHeader, raw] = MultidetectorParser(signal, 'int32');

% Распарсенные данные
parsedLines = raw';
parsedHops = hops;


% Конвертируем фильтры в частоты
raw = double(raw);
samples = double(mainHeader.samplesPerLine);
gridHz = double(mainHeader.gridHz);

f = (-samples / 2 : (samples - 1) / 2) * gridHz;
n = mainHeader.firstNumLine : mainHeader.firstNumLine + size(raw, 1) - 1;
f_MHz = f / 1e6; 

% Отрисовка линий
figure("Name", "Multidetector result");
image(f_MHz, n, 20 * log10(abs(raw)), 'CDataMapping', 'scaled')
xlabel(strcat("Frequency, MHz", " ( ", string(double(mainHeader.centerFreqHz) / 1e6), " MHz)"))
ylabel("Line number")



% Накладываем поверх цветные квадратики
for i = 1:length(signals_pulse) % <--- пульсы
    if(signals_pulse(i).meanSnr > 0)
        signals_pulse(i).startFreq = (signals_pulse(i).startFreq-0.5 - samples / 2) * gridHz / 1e6;
        signals_pulse(i).stopFreq = (signals_pulse(i).stopFreq+0.5 - samples / 2) * gridHz / 1e6;
        rectangle('Position', ...
            [(signals_pulse(i).startFreq), (signals_pulse(i).timeStart - 0.5) ...
             (signals_pulse(i).stopFreq - signals_pulse(i).startFreq), signals_pulse(i).duration], ...
            'LineWidth', 3);
    end
end

% Получаем мапину всех уникальных сессий и строим по ним словарь для
% определения цвета
uniqSess = unique(vertcat(hops.sessionId));
colorMap = ['#FBCEB1'; '#ED3CCA'; '#CD9575'; '#F19CBB'; '#44944A'; '#293133'; '#C1876B'; '#9966CC'; '#E32636'; '#B5B8B1'; ...
            '#A8E4A0'; '#CCCCFF'; '#F984E5'; '#480607'; '#FFB02E'; '#FAE7B5'; '#BDECB6'; '#45161C'; '#98FB98'; '#D87093'; ...
            '#EEE8AA'; '#A5260A'; '#34C924'; '#FF43A4'; '#FF0033'; '#BD33A4'; '#7CFC00'; '#FFF8E7'; '#FFD700'; '#FFCF48'; ...
            '#D5713F'; '#0BDA51'; '#ACE1AF'; '#FF6E4A'; '#E5BE01'; '#E3A9BE'; '#9932CC'; '#FF00CC'; '#EA7E5D'; '#E75480'; ...
            '#FF7E00'; '#8FBC8F'; '#A08040'; '#FFD800'; '#F754E1'; '#66FF00'; '#FF6800'; '#FAA76C'; '#660099'; '#FDF5E6'];

colorDict = dictionary(uniqSess, colorMap(1:length(uniqSess), :));

for i = 1:length(hops) % <--- хопы
    hops(i).startFreq = (hops(i).startFreq - double(mainHeader.centerFreqHz)) / 1e6;
    hops(i).stopFreq = (hops(i).stopFreq - double(mainHeader.centerFreqHz)) / 1e6;

    % Оттенок красного со сдвигом палитры на шаг в зависимости от
    % количества сессий
    

    rectangle('Position', ...
    [hops(i).startFreq, (hops(i).lineNumStart)-0.5, ...
    (hops(i).stopFreq - hops(i).startFreq), (hops(i).lineNumEnd - hops(i).lineNumStart)], ...
    'LineWidth', 2, 'EdgeColor',colorDict(hops(i).sessionId));

end

% for i = 1:length(signals_lost) % <--- лосты
%     if(signals_lost(i).meanSnr > 0)
%         signals_lost(i).startFreq = (signals_lost(i).startFreq-0.5 - samples / 2) * gridHz / 1e6;
%         signals_lost(i).stopFreq = (signals_lost(i).stopFreq+0.5 - samples / 2) * gridHz / 1e6;
%         rectangle('Position', ...
%         [(signals_lost(i).startFreq), (0.5+signals_lost(i).timeStart) ...
%          ((signals_lost(i).stopFreq) - signals_lost(i).startFreq), signals_lost(i).duration], ...
%         'LineWidth', 2, 'EdgeColor','r');
%     end
% end

end
