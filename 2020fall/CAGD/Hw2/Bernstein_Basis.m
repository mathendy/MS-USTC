function result = Bernstein_Basis(points)
[n,~]=size(points);
N=100;
t=linspace(0,1,N+1);
result=zeros(N+1,2);

coef = zeros(1,n);
for i = 1:n
    coef(i)=nchoosek(n-1,i-1);
end
for i=1:N+1
    result(i,:)=(coef.*t(i).^(0:n-1).*(1-t(i)).^(n-1:-1:0))*points;
end
end

