
% te retorna o primeiro valor não inteiro das soluções.
% se retornar 0 é por q todas as soluções são inteiras
function [ noINT ] = Verf_Int( M )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
i = 1;
[a,b] = size(M);
noINT = 0;
while(i<=a)
    if(rem(M(i),1)==0)%resto da divisão por 1
        i = i+1;
    else
        noINT = i;
        break;
    end
end
end

