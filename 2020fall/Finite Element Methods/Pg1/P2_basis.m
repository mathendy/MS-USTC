function result = P2_basis(f,nodes)
A=1/3*[7,-8,1;-8,16,-8;1,-8,7];
[N,~]=size(nodes);
e=N-1;
h=nodes(2:N)-nodes(1:N-1);
K=zeros(2*e+1,2*e+1);
for i = 1:e
    j=2*i-1;
    K(j,j)=K(j,j)+1/h(i)*A(1,1);
    K(j,j+1)=K(j,j+1)+1/h(i)*A(1,2);
    K(j,j+2)=K(j,j+2)+1/h(i)*A(1,3);
    K(j+1,j)=K(j+1,j)+1/h(i)*A(2,1);
    K(j+1,j+1)=K(j+1,j+1)+1/h(i)*A(2,2);
    K(j+1,j+2)=K(j+1,j+2)+1/h(i)*A(2,3);
    K(j+2,j)=K(j+2,j)+1/h(i)*A(3,1);
    K(j+2,j+1)=K(j+2,j+1)+1/h(i)*A(3,2);
    K(j+2,j+2)=K(j+2,j+2)+1/h(i)*A(3,3);
end
F=zeros(2*e-1,1);
for i = 1:e
    F(2*i-1,1)=f((nodes(i)+nodes(i+1))/2)*2/3*h(i);
end
for i = 1:e-1
    F(2*i,1)=f(nodes(i+1))*(h(i)+h(i+1))/6;
end
result=K(2:2*e,2:2*e)\F;
end

