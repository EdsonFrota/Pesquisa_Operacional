function revised_Orige(c,b,a,inq,minimize)
if nargin<3||nargin>5
    fprintf('\nError:Number of input arguments are inappropriate!\n');
else
    n=length(c);m=length(b);j=max(abs(c));
    if nargin<4
        minimize=0;
        inq=-ones(m,1);
    elseif nargin<5
        minimize=0;
    end
    if ~isequal(size(a),[m,n])||m~=length(inq)
        fprintf('\nError: Dimension mismatch!\n');
    else
        if minimize==1
            c=-c;
        end
        count=n;nbv=1:n;bv=zeros(1,m);av=zeros(1,m);
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
        fprintf('\n.............The initial tablaue................\n')
        fprintf('\t z');disp(bv);
        fprintf('--------------------------------------------------\n')
        disp([B_inv x_b])
        flag=0;count=0;of_curr=0;
        while(flag~=1)
            [s,t]=min(B_inv(1,:)*A(:,nbv));
            y=B_inv*A(:,nbv(t));count=count+1;
            if(any(y(2:m+1)>0))
                fprintf('\n.............The %dth tablaue................\n',count)
                fprintf('\t z');disp(bv);
                fprintf('--------------------------------------------------\n')
                disp([B_inv x_b y])
                if count>1 && of_curr==x_b(1)
                    flag=1;
                    if minimize==1
                        x_b(1)=-x_b(1);
                    end
                    fprintf('\nThe given problem has degeneracy!\n');
                    fprintf('\nThe current objective function value=%d.\n',x_b(1));
                    fprintf('\nThe current solution is:\n');
                    for i=1:n
                        found=0;
                        for j=1:m
                            if bv(j)==i
                                fprintf('x%u = %d\n',i,x_b(1+j));found=1;
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
                                    fprintf('\nThe given LPP is infeasible!\n');
                                    return
                                end
                            end
                        end
                        if minimize==1
                            x_b(1)=-x_b(1);
                        end
                        fprintf('\nReqiured optimization has been achieved!\n');
                        fprintf('\nThe optimum objective function value=%d.\n',x_b(1));
                        fprintf('\nThe optimum solution is:\n');
                        for i=1:n
                            found=0;
                            for j=1:m
                                if bv(j)==i
                                    fprintf('x%u = %d\n',i,x_b(1+j));found=1;
                                end
                            end
                            if found==0
                                fprintf('x%u = %d\n',i,0);
                            end
                        end
                        if (s==0 && any(y(2:m+1)>0))
                            fprintf('\nThe given problem has alternate optima!\n');
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
                fprintf('\nThe given problem has unbounded solution\n')
                return
            end
        end
    end
end
