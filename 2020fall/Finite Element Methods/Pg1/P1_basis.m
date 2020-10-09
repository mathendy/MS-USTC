function result = P1_basis(f,nodes)
[N,~]=size(nodes);
e=N-1;
h=nodes(2:N)-nodes(1:N-1);
H=1./h;
K=spdiags([-1*H(2:e),H(1:e-1)+H(2:e),-1*H(1:e-1)],[-1,0,1],e-1,e-1);
F=f(nodes(2:e)).*(h(1:e-1)+h(2:e))/2;
result=K\F;
end

