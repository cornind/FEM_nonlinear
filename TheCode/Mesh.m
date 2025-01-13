th = (pi/24:pi/24:2*pi) ;
x1 =  cos(th)  ;
y1 = sin(th);
pgon = polyshape( x1, y1 );

tr = triangulation(pgon);

model = createpde;

tnodes = tr.Points';
telements = tr.ConnectivityList';

geometryFromMesh(model,tnodes,telements);


mesh=generateMesh(model,'GeometricOrder','linear','Hmax',0.05);


Ne = findNodes(mesh,'region','Edge',1);
% figure
% pdegplot(model,'FaceLabels','on','EdgeLabels','on')
% hold on
% plot(mesh.Nodes(1,Ne ),mesh.Nodes(2,Ne ),'or','MarkerFaceColor','g')




figure
pdemesh(model)

p = model.Mesh.Nodes';



elem = model.Mesh.Elements';