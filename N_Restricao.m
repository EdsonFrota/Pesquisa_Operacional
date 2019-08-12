
% esta função retorna os dois valores para as novas restrições, ou seja, se
% a solução gerada pelo simplex for não inteira e gera os 2 inteiros mais
% proximos.
%EX: simple(A,B,C) retornou, x = 2.5 então newTestrict te retorna 2 e 3.
function [ m ] = N_Restricao( value_of_lookNotInt )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
m(1) = fix(value_of_lookNotInt);%trunca para o valor mais abaixo
m(2) = m(1)+1;
end

