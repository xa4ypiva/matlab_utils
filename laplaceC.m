function [ Fc ] = laplaceC( x )
%LAPLACEC Summary of this function goes here
%   Laplace Complementary function
% Fc(x) = 1 / sqrt(2pi) * int from x to inf {exp(-t^2 / 2) dt}

Fc = erfc(x/sqrt(2)) / 2;

end

