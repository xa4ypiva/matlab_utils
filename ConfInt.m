function [ci] = ConfInt(x, beta)

pd = fitdist(x, 'normal');
ci = paramci(pd, 'alpha', 1-beta);
ci(:,1) = ci(:,1) - pd.mu;
ci(:,2) = ci(:,2) - pd.sigma;

end

