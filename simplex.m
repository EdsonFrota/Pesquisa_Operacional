% função para MAX
function X = simplex(fo,A,B,C)
%fo    constantes da função objetivo 

%A   matriz com as constantes das inequações 

%B  matriz das desigualdades 

iterM=100; % número maximo de iterações
In=size(A,1); % número de inequações 
i=1;
Maiorigual=eye(In);
while(i<=In)
    
    Maiorigual(i,i)=C(i);
    i=i+1;
end


Xsol=[A Maiorigual     B
      fo zeros(1,In) 0];   % A montagem da matriz tablue, onde a ultima linha é a fo
  
for iter=1:1:iterM
Xsol
    fin=Xsol(end,1:end-1)<0%onde linha for negativo fin recebe 0
  if fin==0
       break 
  end
[a,c]=min(Xsol(end,:));  % a = valor minimo e c = coluna pivo.
Xre=Xsol(:,end)./Xsol(:,c); % valor em b é dividido pelos valores da variavel que vai sair.

i=Xre<=0; % valores nao positivos da linha de xre recebem i
d=Xre;
d(i)=inf;

[b,f]=min(d);  % b recebe menor valor positivo, f recebe a linha que vai sair

Xsol(f,1:end)=Xsol(f,1:end)/Xsol(f,c); % linha é dividida pelo pivo de forma pivo ser 1
for i=1:1:size(Xsol,1)  %gauss
   
    if i~=f             %caso precise inverter linhas...
    Xsol(i,:)=Xsol(i,:)- (Xsol(i,c)*Xsol(f,:));
    
    end
    
end

end 
%Xsol
cont=0;
for i=1:1:size(fo,2)
    d=logical(Xsol(:,i));
    cont=0;
    for j=1:1:size(d) 
        if d(j,1)==1
            cont=cont+1;
        end
    end
    if(cont==1)
    X(i,1)=Xsol(d,end);
    end
    if(cont~=1)
    X(i,1)=0;
    end
end