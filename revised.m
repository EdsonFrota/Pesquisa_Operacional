function X =  revised(fo,V,M,C,minimize)
    c = fo;
    b = V;
    a = M;
    inq = C;

    n=length(c); % DIMENSÕES TABELA
    m=length(b); % DIMENSÕES TABELA
    j=max(abs(c));
   
    if ~isequal(size(a),[m,n]) || m~=length(inq)
        fprintf('\n ERRO DE DIMENSÕES \n');
    else
        if minimize==1  
            c=-c; % SE FOR MINIMIZAR C FICA NEGATIVO
        end
        count=n; 
        nbv=1:n;
        bv=zeros(1,m);
        av=zeros(1,m);
        for i=1:m
            if b(i)<0
                a(i,:)=-a(i,:);
                b(i)=-b(i);
            end
            if inq(i)<0
                count=count+1;
                c(count)=0;
                a(i,count)=1;
                bv(i)=count;
            elseif inq(i)==0
                count=count+1;
                c(count)=-10*j;
                a(i,count)=1;
                bv(i)=count;
                av(i)=count;
            else
                count=count+1;
                c(count)=0;
                a(i,count)=-1;
                nbv=[nbv count];
                count=count+1;
                c(count)=-10*j;
                a(i,count)=1;
                av(i)=count;
                bv(i)=count;
            end
        end
        A=[-c;a];
        B_inv=eye(m+1,m+1);
        B_inv(1,2:m+1)=c(bv);
        x_b=B_inv*[0; b'];
        fprintf('\n.............TABLAUE INICIAL................\n')
        fprintf('\t z');
        disp(bv);
        fprintf('--------------------------------------------------\n')
        disp([B_inv x_b])
        flag=0;count=0;of_curr=0;
        while(flag~=1)
            [s,t]=min(B_inv(1,:)*A(:,nbv));
            y=B_inv*A(:,nbv(t));count=count+1;
            if(any(y(2:m+1)>0))
                fprintf('\n.............%dº TABLAUE................\n',count)
                fprintf('\t z');disp(bv);
                fprintf('--------------------------------------------------\n')
                disp([B_inv x_b y])
                if count>1 && of_curr==x_b(1)
                    flag=1;
                    if minimize==1
                        x_b(1)=-x_b(1);
                    end
                    fprintf('\nO problema dado tem degeneração!\n');
                    fprintf('\nO valor da função objetivo atual=%d.\n',x_b(1));
                    fprintf('\nA solução atual é:\n');
                    for i=1:n
                        found=0;
                        for j=1:m
                            if bv(j)==i
                                fprintf('x%u = %d\n',i,x_b(1+j));
                                found=1;
                            end
                        end
                        if found==0
                             fprintf('x%u = %d\n',i,0);
                        end
                    end
                else
                    of_curr=x_b(1);
                    if(s>=0)
                        flag=1;
                        for i=1:length(av)
                            for j=1:m
                                if av(i)==bv(j)
                                    fprintf('\nO LPP dado é infactível!\n');
                                    return
                                end
                            end
                        end
                        if minimize==1
                            x_b(1)=-x_b(1);
                        end
                        fprintf('\nA otimização necessária foi alcançada!\n');
                        fprintf('\nO valor da função objetivo atual=%d.\n',x_b(1));
                        fprintf('\nA solução atual é:\n');
                        for i=1:n
                            found=0;
                            for j=1:m
                                if bv(j)==i
                                    fprintf('x %u = %d\n',i,x_b(1+j));
                                    found=1;
                                end
                            end
                            if found==0
                                fprintf('x%u = %d\n',i,0);
                            end
                        end
                        if (s==0 && any(y(2:m+1)>0))
                            fprintf('\nO problema dado tem uma solução ótima alternativa!\n');
                        end
                    else
                        u=10*j;
                        for i=2:m+1
                            if y(i)>0
                                if (x_b(i)/y(i))<u
                                    u=(x_b(i)/y(i));
                                    v=i-1;
                                end
                            end
                        end
                        temp=bv(v);bv(v)=nbv(t);
                        nbv(t)=temp;
                        E=eye(m+1,m+1);
                        E(:,1+v)=-y/y(1+v);
                        E(1+v,1+v)=1/y(1+v);
                        B_inv=E*B_inv;
                        x_b=B_inv*[0; b'];
                    end
                end
            else
                fprintf('\nO problema dado tem uma solução ilimitada\n')
                return
            end
        end
        for i=1:n
            found=0;
            for j=1:m
                if bv(j)==i
                    X(i,1) = x_b(1+j);
                   %fprintf('x %u = %d\n',i,x_b(1+j));
                   found=1;
                end
            end
            if found==0
                X(i,1) = 0;
               %fprintf('x%u = %d\n',i,0);
            end
        end
    end
    
    

