pgon = polyshape( [-1 -1 1 1] , [1 -1 -1 1] );

tr = triangulation(pgon);

model = createpde;

tnodes = tr.Points';
telements = tr.ConnectivityList';

geometryFromMesh(model,tnodes,telements);


mesh=generateMesh(model,'GeometricOrder','linear','Hmax',0.05);


Ne = findNodes(mesh,'region','Edge',1:4);
% figure
% pdemesh(model,'NodeLabels','on')
% hold on
% plot(mesh.Nodes(1,Ne ),mesh.Nodes(2,Ne ),'or','MarkerFaceColor','g')




figure
pdemesh(model)

p = model.Mesh.Nodes';



elem = model.Mesh.Elements';