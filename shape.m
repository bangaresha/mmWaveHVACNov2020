th = (pi/24:pi/24:2*pi)';
x = cos(th);
y = sin(th);

circShp = alphaShape(x,y,3);

x0 = [reshape(cos(th)*(1:5), numel(cos(th)*(1:5)),1); 0];
y0 = [reshape(sin(th)*(1:5), numel(sin(th)*(1:5)),1); 0];
zg0 = ones(numel(x0),1);
xg0 = repmat(x0,5,1);
yg0 = repmat(y0,5,1);
zg0 = zg0*(0:.25:1);
zg0 = zg0(:);

zg2 = ones(numel(x0),1);
xg2 = repmat(x0,5,1);
yg2 = repmat(y0,5,1);
zg2 = zg2*(4.50:0.25:5.50);
zg2 = zg2(:);

x1 = [reshape(cos(th)*(1:5), numel(cos(th)*(1:5)),1);];
y1 = [reshape(sin(th)*(1:5), numel(sin(th)*(1:5)),1);];
% figure
% plot(x1,y1)

in = inShape(circShp,x1,y1);
x1 = x1(~in);
y1 = y1(~in);
z1 = ones(numel(x1),1);
xg1 = repmat(x1,13,1);
yg1 = repmat(y1,13,1);
z1 = z1*(1.25:.25:4.25);
zg1 = z1(:);

xg3 = [xg0; xg1; xg2];
yg3 = [yg0; yg1; yg2];
zg3 = [zg0; zg1; zg2];

shp = alphaShape(xg3,yg3,zg3,0.8);
shp1 = alphaShape([xg0; xg1],[yg0; yg1],[zg0; zg1],0.8);
shp2 = alphaShape([xg1; xg2],[yg1; yg2],[zg1; zg2],0.8);

figure
plot(shp2)

[elements,nodes] = boundaryFacets(shp);
nodes = nodes';
elements = elements';
model = createpde();
geometryFromMesh(model,nodes,elements);

%View the geometry and face numbers.
figure
pdegplot(model,'FaceLabels','on','FaceAlpha',0.5)
mes = generateMesh(model,'GeometricOrder','linear');


% th = (pi/12:pi/12:2*pi)';
% x = [reshape(cos(th)*(2:5), numel(cos(th)*(2:5)),1);];
% y = [reshape(sin(th)*(2:5), numel(sin(th)*(2:5)),1);];
% x1 = [reshape(cos(th)*(0:5), numel(cos(th)*(0:5)),1);];
% y1 = [reshape(sin(th)*(0:5), numel(sin(th)*(0:5)),1);];
% % figure
% % plot(x1,y1,'.')
% % axis equal
% 
% zg = ones(numel(x),1);
% xg = repmat(x,5,1);
% yg = repmat(y,5,1);
% zg = zg*(1.25:.25:2.25);
% zg = zg(:);
% 
% zg1 = ones(numel(x1),1);
% xg1 = repmat(x1,5,1);
% yg1 = repmat(y1,5,1);
% zg1 = zg1*(0:.25:1);
% zg1 = zg1(:);
% zg2 = ones(numel(x1),1);
% zg2 = zg2*(2.5:.25:3.5);
% zg2 = zg2(:);
% 
% xg3 = [xg1; xg; xg1];
% yg3 = [yg1; yg; yg1];
% zg3 = [zg1; zg; zg2];
% 
% shp = alphaShape(xg3,yg3,zg3);
% %shp.Alpha = 2;
% figure
% plot(shp)
% 
% shp1 = alphaShape([xg1; xg],[yg1; yg],[zg1; zg]);
% %shp1.Alpha = 2;
% figure
% plot(shp1)