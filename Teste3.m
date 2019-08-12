% essa função avalia a condição da otmilidade da solução, ou seja, se a
% nova solução for pior que a melhor solução inteira atual então pode parar
% por que se a fracionaria já esta pior não tem como melhorar
function [ out] = Teste3( Zmax, Zatual )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
if(Zmax>Zatual)
    out = 1;%o z atual é menor q o Zmax, ou seja já pode parar.
else
    out = 0;
end
end

