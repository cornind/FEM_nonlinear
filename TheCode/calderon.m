Polynomial_Symbol
load coordinates.dat; coordinates(:,1)=[];
load elements3.dat; elements3(:,1)=[];
eval('load neumann.dat; neumann(:,1) = [];','neumann=[];');
load dirichlet.dat; dirichlet(:,1) = [];
FreeNodes=setdiff(1:size(coordinates,1),unique(dirichlet));

% Initial value
U = ones(size(coordinates,1),1);
% U = sign( coordinates(:,1) );
U(unique(dirichlet)) = u_d(coordinates(unique(dirichlet),:));

% Newton-Raphson iteration
for i=1:100
  
  % Assembly of DJ(U)
  A = sparse(size(coordinates,1),size(coordinates,1));
  for j = 1:size(elements3,1)
    A(elements3(j,:),elements3(j,:)) = A(elements3(j,:),elements3(j,:)) ...
	+ localdj(coordinates(elements3(j,:),:),U(elements3(j,:)),ud,udp);
  end
  
  % Assembly of J(U)
  b = sparse(size(coordinates,1),1);
  for j = 1:size(elements3,1)
    b(elements3(j,:)) = b(elements3(j,:)) ...
   	+ localj(coordinates(elements3(j,:),:),U(elements3(j,:)),ud);
  end
  
  % Volume Forces
  for j = 1:size(elements3,1)
    b(elements3(j,:)) = b(elements3(j,:)) + ...
	det([1 1 1; coordinates(elements3(j,:),:)']) * ...
	f(sum(coordinates(elements3(j,:),:))/3)/6;
  end
  
  % Neumann conditions
  for j = 1 : size(neumann,1)
    b(neumann(j,:))=b(neumann(j,:)) - norm(coordinates(neumann(j,1),:)- ...
	coordinates(neumann(j,2),:))*g(sum(coordinates(neumann(j,:),:))/2)/2;
  end
  
  % Dirichlet conditions
  W = zeros(size(coordinates,1),1);
  W(unique(dirichlet)) = 0;
  
  % Solving one Newton step
  W(FreeNodes) = A(FreeNodes,FreeNodes)\b(FreeNodes);
  U = U - W;
  if norm(W) < 10^(-10)
    break
  end
end

% graphic representation
show(elements3,[],coordinates,full(U));
