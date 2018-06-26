function mls = MLS(sourceSequence, polynomDegree)
% mls = MLS(sourceSequence, polynomDegree)
% Функция для генерации М-последовательности
% sourceSequence - начальное состояние регистра.
% polynomDegree - cтепени полинома, которые будут суммироваться. Например [3,1] соответствует x^3 + x + 1
% Выходной массив имеет длину L = 2^n - 1

n = length(sourceSequence);
l = length(polynomDegree);

if (n < l || polynomDegree(1) > n)
    error('error: check your polynom');
end

L = 2^n - 1;
mls = zeros(1, L);

for i = 1 : 1 : L
    mls(i) = sourceSequence(7);
    temp = 0;
    for j = 1 : 1 : l
        temp = xor(temp, sourceSequence(polynomDegree(j) ) );
    end
    for k = n : -1 : 2
        sourceSequence(k) = sourceSequence(k - 1);
    end
    sourceSequence(1) = temp;
end

