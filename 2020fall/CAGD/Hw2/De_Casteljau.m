function result = De_Casteljau(points)
[n,~]=size(points);
N=100;
t=linspace(0,1,N+1);
result=zeros(N+1,2);

for j = 1:N+1
    b=points;
    for r = 1:n-1
        for i = 1:n-r
            b(i,:)=(1-t(j))*b(i,:)+t(j)*b(i+1,:);
        end
    end
    result(j,:)=b(1,:);
end
end

