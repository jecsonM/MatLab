clc; clear; close all;


x = linspace(-6, 2, 2000);
p = [-2.26, -2.25, 4.02, -7.05, 15.28, 3.39, 15.11, 4.95, -1.71, -6.36, -8.76, 5.60 ];     % коэффициенты полинома
y = polyval(p, x);

xzerosInd = find(diff(sign(y)) ~= 0);



xzeros = roots(p);
xzeros = xzeros(abs(imag(xzeros)) < 1e-6);
xzeros = real(xzeros);

yzeros = polyval(p, xzeros);




figure('Name','A: Полином высокой степени','Color','w');
subplot(1,2,1);

PlotPolyWZeros(p,x, 'График с ограничением по y', [-20 20] );


subplot(1,2,2);
plot(x,y);
title('График без ограничений по y');
xlabel('x');
ylabel('y');
hold on;







x = linspace(-1.4, -0.2, 2000);


figure('Name','B: более узкие интервалы','Color','w');
subplot(1,2,1);

PlotPolyWZeros(p,x, 'График от -1,4 до -0.2', [-20 20], 1 );

hold on;








x = linspace(-0.1, 0.8, 2000);

subplot(1,2,2);

title('График от -0,1 до 0.8');
PlotPolyWZeros(p,x, 'График от -1,4 до -0.2', [-20 20], 0);



figure('Name','С: Производные','Color','w');


x = linspace(-6, 2, 2000);
y = polyval(p, x);

x1 = linspace(-8,6.5, 2000);
x2 = linspace(-8,8, 2000);
x3 = linspace(-8,6, 2000);
dy1 = polyder(p);
dy2 = polyder(dy1);
dy3 = polyder(dy2);

y1 = polyval(dy1,x1);
y2 = polyval(dy2,x2);
y3 = polyval(dy3,x3);

subplot(4,1,1);
PlotPolyWZeros(p,x, 'Сам полином');

subplot(4,1,2);
PlotPolyWZeros(dy1,x1, 'Первая производная');

subplot(4,1,3);
PlotPolyWZeros(dy1,x1, 'Вторая производная');

subplot(4,1,4);
PlotPolyWZeros(dy3,x3, 'Третья производная');



figure('Name','D: Экстремумы','Color','w');




x = linspace(-5, 1.5, 2000);
y = polyval(p, x);


xminsTF = islocalmin(y);
xmaxesTF = islocalmax(y);

subplot(1,2,1);

plot(x,y);
hold on;
title('Экстремумы функциями localmin, localmax');
xlabel('x');
ylabel('y');


plotMarkersWX(x(xminsTF),y(xminsTF) , 0.1, 1e5, "min:  ", 'r*', 0, 1)
plotMarkersWX(x(xmaxesTF),y(xmaxesTF) , 0.1, 2e5, "max:  ",'b*', 0, 1)







x1zeros = roots(dy1);
x1zeros = x1zeros(abs(imag(x1zeros)) < 1e-6);
x1zeros = real(x1zeros);
         
x1zeros = x1zeros(x1zeros > min(x) & x1zeros < max(x));         

xMaxes = x1zeros(polyval(dy2, x1zeros) < 0);
xMins = x1zeros(polyval(dy2, x1zeros) > 0);

subplot(1,2,2);

plot(x,y);
hold on;
title('Экстремумы по корням производных');
xlabel('x');
ylabel('y');

plotMarkersWX(xMins, polyval(p,xMins) , 0.1, 1e5, "min:  ", 'r*', 0, 1);
plotMarkersWX(xMaxes, polyval(p,xMaxes), 0.1, 2e5, "max:  ",'b*', 0, 1);


hold on;

figure('Name','E: Вариация 2-го коэффицента','Color','w');

p_new = p;

delta = (2*rand()-1)*0.05;
p_new(2) = p(2) * (1 + delta);


r0 = roots(p);
r1 = roots(p_new);

cost = abs(r0(:) - r1(:).');
M    = matchpairs(cost, 1e6);

matched_old = r0(M(:,1));
matched_new = r1(M(:,2));

rel_err     = abs(matched_new - matched_old) ./ abs(matched_old);

fprintf('\n  %-22s %-22s %10s\n', 'старый корень', 'новый корень', 'отн. погрешность');
for k = 1:numel(matched_old)
    fprintf('  %+.6f%+.6fi  %+.6f%+.6fi  %9.4f%%\n', ...
        real(matched_old(k)), imag(matched_old(k)), ...
        real(matched_new(k)), imag(matched_new(k)), ...
        100*rel_err(k));
end
fprintf('Изменение p(2): %+.4f%%  (было %.4f, стало %.4f)\n', ...
        100*delta, p(2), p_new(2));

subplot(1,2,1);
PlotPolyWZeros(p,x, 'Изначальный полином')

subplot(1,2,2);
PlotPolyWZeros(p_new,x, 'Полином с изменённым коэффицентом')




