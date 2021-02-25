numberOfPDE = 1;
t = (pi/24:pi/12:2*pi)';
x = cos(t);
y = sin(t);
circShp = alphaShape(x,y,2);
plot(circShp)

[xg, yg] = meshgrid(-2:0.5:2);
xg = xg(:);
yg = yg(:);

in = inShape(circShp,xg,yg);
xg = [xg(~in); cos(t)];
yg = [yg(~in); sin(t)];
zg = ones(numel(xg),1);
xg = repmat(xg,5,1);
yg = repmat(yg,5,1);
zg = zg*(0:.25:1);
zg = zg(:);

[xg1, yg1] = meshgrid(-2:0.5:2);
xg1 = xg1(:);
yg1 = yg1(:);
zg1 = ones(numel(xg1),1);
xg1 = repmat(xg1,5,1);
yg1 = repmat(yg1,5,1);
zg1 = zg1*(-1.25:.25:-0.25);
zg1 = zg1(:);

[xg2, yg2] = meshgrid(-2:0.5:2);
xg2 = xg2(:);
yg2 = yg2(:);
zg2 = ones(numel(xg2),1);
xg2 = repmat(xg2,5,1);
yg2 = repmat(yg2,5,1);
zg2 = zg2*(1.25:0.25:2.25);
zg2 = zg2(:);
xg3 = [xg1; xg; xg2];
yg3 = [yg1; yg; yg2];
zg3 = [zg1; zg; zg2];

shp = alphaShape(xg3,yg3,zg3);
shp1 = alphaShape(xg,yg,zg);
figure
plot(shp)

[elements,nodes] = boundaryFacets(shp);
nodes = nodes';
elements = elements';
model = createpde();
geometryFromMesh(model,nodes,elements);

%View the geometry and face numbers.
figure
pdegplot(model,'FaceLabels','on','FaceAlpha',0.5)
mes = generateMesh(model,'GeometricOrder','linear');