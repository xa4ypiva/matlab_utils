function [structOut] = SortByField(structIn, numField)

cellIn = struct2cell(structIn);
sz = size(cellIn);
cellIn = reshape(cellIn, sz(1), [])';
cellIn = sortrows(cellIn, numField);
cellIn = reshape(cellIn', sz);
structOut = cell2struct(cellIn, fieldnames(structIn), 1);

end

