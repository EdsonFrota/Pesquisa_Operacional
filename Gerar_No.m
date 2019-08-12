function [ out, Zmax, X ] = Gerar_No( fo,M,V,C,xn,novaRestricao,Zmaxatual, Xotmatual )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
%para não perder tempo a primeira coisa é verificar a viabilidade, condição
%de parada Teste1
%primeiro arrumamos M e V adicionando as novas restrições
a = 0;
b = Zmaxatual;
c = Xotmatual;

if(xn == 0)

else
    [lin,col] = size(fo);
    i = 1;
    while(i<=col)
        if(i == xn)
            temp(1,i) = 1;
        else
         temp(1,i) = 0;
        end
        i = i+1;
    end
    M = [M;temp]
    if(novaRestricao >=0)
    V = [V;novaRestricao]
    C = [C;-1]
    else
    V = [V;((-1)*novaRestricao)]
    C = [C;1]
    end
    if(Teste1(xn,M,V,novaRestricao))
        disp('Teste1');
    out = 0;%solução infactivel
    return %encerra a função
    end
end
%agora avaliar a solução simplex
%x = simplex(fo,M,V);
%fo
%V
%M
Ct = C';

x = revised(fo,V',M,Ct,0);
i = Verf_Int(x);%inteiro?
%agora verificamos a condição Teste3, se o Zatual é menor q Zmax
Zatl = (fo)*x;
if(Teste3(Zmaxatual,Zatl))
    disp('Teste3');
    out = 0;%o Zatual é menor por isso pode parar, e esta solução não serve pra nda
    Zmax = Zmaxatual;
    X = Xotmatual;
    return
end
%agora condição TS2, se é toda solução inteira ou não e se vamos criar
%novos nós ou não.

if(i==0)%caso seja solução inteira...
    disp('Teste2');
    Zatl = (fo)*x;%como é uma solução inteira, então verificamos se é maior q a anterior.
    if(Zatl>Zmaxatual)
        Zmax = Zatl;
        X = x;
        out = 0;
    end
        return
else%caso não seja uma solução inteira...
    %como não é uma solução inteira então temos que criar 2 novos nós.
    %em i temos o valor de qual é o primeiro x da solução q não é inteiro,
    %por tanto agora vamos achar quais são os 2 inteiros mais proximos para
    %criação dos novos nós.
    r = N_Restricao(x(i,1));
    j = 1;
    %x
    b
    c
    %if(xn == 2)
     %   return
    %end
    while(j<=2)%um laço para cada nó(usando recursão)
  
        if (j == 2)
           %C(end,end)= C(end,end)*(-1);
           r(j) = r(j)*(-1);
        end
        [a, b, c] = Gerar_No(fo,M,V,C,i,r(j),b,c); 
        j = j+1;
    end
end
out = a;%concluido com sucesso
Zmax = b;
X = c;
end

