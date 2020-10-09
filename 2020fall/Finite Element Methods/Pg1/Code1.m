Error1=zeros(4,1);
Error2=zeros(4,1);

N=[10,20,40,80];
for i=1:4
    X=linspace(0,1,N(i)+1)';
    result1=P1_basis(@(x) (x-1).*sin(x)-2*cos(x),X);
    result2=P2_basis(@(x) (x-1).*sin(x)-2*cos(x),X);
    X1=linspace(0,1,2*N(i)+1)';
    trueSolution=(X1-1).*sin(X1);
    Error1(i)=max(abs(trueSolution(1:2:end)-[0;result1;0]));
    Error2(i)=max(abs(trueSolution-[0;result2;0]));
end
logN=log(N);
logError1=log(Error1);
logError2=log(Error2);

%plot(X1,(X1-1).*sin(X1),'r',X,[0;result1;0],'b',X1,[0;result2;0],'g');