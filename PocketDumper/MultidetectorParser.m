function [mainHeader, lines] = MultidetectorParser(speclines, type)
% Размер типа входных данных
typeSize = typecast(0,type);
typeSize = whos('typeSize').bytes / whos('typeSize').size(2);

% Данные в байтах
dataInBytes = typecast(cast(speclines, type), 'uint8');

% Парсим мейн заголовок
mainHeader = ParseMainHeader(dataInBytes);

% Линии + заголовки
body = dataInBytes(mainHeader.mainHeaderSize+1:end);

% Размер одной линии с заголовком в байтах
lineSize = mainHeader.samplesPerLine * typeSize + mainHeader.lineHeaderSize;

%Кол-во линий в дампе
linesAmount = (length(body) / lineSize) - 1;

lines = cast(zeros(linesAmount, mainHeader.samplesPerLine), type);

% Собираем линии с учетом потеряных линий
startLine = -1;
for line=0 : linesAmount-1
    start = line * lineSize + 1;
    % Парсим линии
    [lineHeader, amplitudes] = ParseLine(body(start:start + lineSize - 1), type);

    if startLine == -1
        startLine = lineHeader.lineNum;
    end
    lines(lineHeader.lineNum - startLine + 1,1:end) = amplitudes;
end

end



function [mainHeader] = ParseMainHeader(inBytes)
    mainHeader = struct("mainHeaderSize", typecast(inBytes(1:4),'uint32'), ...
                        "lineHeaderSize", typecast(inBytes(5:8),'uint32'), ...
                        "gridHz", typecast(inBytes(9:12),'uint32'), ...
                        "samplesPerLine", typecast(inBytes(13:16), 'uint32'), ...
                        "centerFreqHz", typecast(inBytes(17:24), 'uint64'), ...
                        "bandHz", typecast(inBytes(25:28), 'uint32'), ...
                        "firstNumLine", typecast(inBytes(29:32),'uint32'));
end


function [header, samples] = ParseLine(line, dataType)
    line = typecast(line,'uint8');
    header = struct('lineNum', typecast(line(1:4), 'uint32'));
    samples = typecast(line(5:end),dataType);
end