%INPUT:
% - xn é a solução xn que está sendo analisada, por exemplo x2 então xn = 2
% - M: matriz das constantes das inequações
% - V: vetor das desigualdades
% - novaRestricao: é o valor da restrição adicionada, sempre vai ser um
% inteiro, se for positiva o algoritmo vai entender como uma restrição de
% <=X se for negativo o algoritmo vai entender como >=X
%OUTPUT:
% - 1 significa que o criterio de parada Teste1 foi identificado, ou seja,
% solução não viavel
% - 0 significa que o criterio de parada não foi satisfeito.



function [ out ] = Teste1( xn, M, V, novaRestricao)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
% Detectando a infactibilidade desta solução
%para isso vou verificar as restrições
[a,b] = size(M);
i = 1;
if(novaRestricao>=0)
    while(i<=a)%percorrer as linhas
        if(M(i,xn)*novaRestricao<=V(i,1))%verifica se as restrições estão sendo atendidas
            out = 0; % as restrições estão sendo atendidas
        else
            out = 1; % uma das restrições não foi atendida, ou seja a solução é infactivel
            break;
        end
        i = i+1;
    end
end
if(novaRestricao<0)
    while(i<=a)%percorrer as linhas
        if(M(i,xn)*(novaRestricao*(-1))<=V(i,1))%verifica se as restrições estão sendo atendidas
            out = 0; % as restrições estão sendo atendidas
        else
            out = 1; % uma das restrições não foi atendida, ou seja a solução é infactivel
            break;
        end
        i = i+1;
    end
end
    
end

