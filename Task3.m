clc; clear; close all;

a = 9.88;
b = 1.25;
c = 3.64;
x0 = 0.70;
y0 = -0.50;
z0 = 1.45;

[X1, Y1, Z1] = ellipsoid(x0, y0, z0, a, b, c, 30);

figure('Name', 'Отображение поверхностей', 'NumberTitle', 'off');


subplot(2, 2, 1);
mesh(X1, Y1, Z1); 
title('Каркасный вид (Mesh)');
xlabel('X'); ylabel('Y'); zlabel('Z');
grid on;
axis equal; 
colormap(gca, 'jet'); 


subplot(2, 2, 2);
surf(X1,Y1,Z1);
title('Плёночный вид (Surf)');
xlabel('X'); ylabel('Y'); zlabel('Z');
grid on;
axis equal;
colormap(gca, 'parula'); 


a = 1.33;
b = -6.73;
x0 = -1.19;
y0 = 1.47;
z0 = 1.00;
[X2, Y2] = meshgrid(-2*abs(a)+x0:0.2:2*abs(a)+x0, -abs(b)+y0:0.2:abs(b)+y0); 

Z2 = z0 + ((X2 - x0).^2)/(a^2) - ((Y2 -y0).^2)/(b^2)


subplot(2, 2, 3);
mesh(X2, Y2, Z2); 
title('Каркасный вид (Mesh)');
xlabel('X'); ylabel('Y'); zlabel('Z');
grid on;
axis equal; 
colormap(gca, 'cool'); 


subplot(2, 2, 4);
surf(X2,Y2,Z2);
title('Плёночный вид (Surf)');
xlabel('X'); ylabel('Y'); zlabel('Z');
colormap(gca, 'summer'); 
grid on;
axis equal;




figure('Name', 'Отображение эллипсоида', 'NumberTitle', 'off');

subplot(2, 2, 1);
mesh(X1, Y1, Z1); 
title('Каркасный вид (Mesh)');
xlabel('X'); ylabel('Y'); zlabel('Z');
grid on;
axis equal; 
colormap(gca, 'jet'); 
view(-55, 20);

subplot(2, 2, 2);
surf(X1,Y1,Z1);
title('Плёночный вид (Surf)');
xlabel('X'); ylabel('Y'); zlabel('Z');
grid on;
axis equal;
colormap(gca, 'cool'); 

view(45, 45);

subplot(2, 2, 3);
surf(X1,Y1,Z1);
title('Плёночный вид (Surf)');
xlabel('X'); ylabel('Y'); zlabel('Z');
grid on;
axis equal;
colormap(gca, 'spring'); 
view(-45, 16);



subplot(2, 2, 4);
contourf(X1,Y1,Z1);

title('Топографический (contourf)');
xlabel('X'); ylabel('Y'); zlabel('Z');
grid on;
axis image;
colormap(gca, 'spring'); 





figure('Name', 'Отображение гиперболического параболоида', ...
    'NumberTitle', 'off');




subplot(2, 2, 1);
surf(X2, Y2, Z2); 

shading interp;
camlight('headlight')

title('Свет сверху');
xlabel('X'); ylabel('Y'); zlabel('Z');
grid on;
axis equal; 
colormap(gca, 'cool'); 



subplot(2, 2, 2);
surf(X2, Y2, Z2); 

shading interp;
camlight('right')
lighting gouraud
view(30, 40)

title('Свет справа');
xlabel('X'); ylabel('Y'); zlabel('Z');
grid on;
axis equal; 
colormap(gca, 'cool'); 



subplot(2, 2, 3);
surf(X2, Y2, Z2); 

shading interp;
lighting gouraud
camlight('left')
view(-60, 20)

title('Свет слева');
xlabel('X'); ylabel('Y'); zlabel('Z');
grid on;
axis equal; 
colormap(gca, 'cool'); 



subplot(2, 2, 4);
surf(X2, Y2, Z2); 

shading interp;
lighting flat
camlight(40,30)
view(50, 50)

title('Плоский свет');
xlabel('X'); ylabel('Y'); zlabel('Z');
grid on;
axis equal; 
colormap(gca, 'cool'); 