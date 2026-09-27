clc; clear; close all;



x1  = linspace(-2, 0.5, 2000);  
a = 1.6; b = 0.4; c = 2.4; d = 0.3;
y1 = atan(-a + (x1-b).^2) .* sin(c + d*x1.^2);

x2  = linspace(-2, 2, 2000);   
p  = [1.5, -0.3, -9.86,  -5.58];     % коэффициенты полинома
y2 = polyval(p, x2);

% % % % % % % % % % %  ЧАСТЬ A
dis1 = (max(x1) - min(x1));
y1Offset = (max(y1) - min(y1)) * 0.1;
dis2 = (max(x2) - min(x2));
y2Offset = (max(y2) - min(y2)) * 0.1;


% Характерные точки y1 (трансцендентная)
x1zerosInd = find(diff(sign(y1)) ~= 0);
x1zeros = x1(x1zerosInd);
y1zeros = y1(x1zerosInd);

x1minsTF = islocalmin(y1);
x1maxesTF = islocalmax(y1);

figure('Name','(a) Характерные точки','Color','w');

subplot(2, 1, 1);
plot(x1,y1, 'k-', 'LineWidth', 2);


hold on;

plotMarkers(x1zeros, y1zeros, y1Offset, "zero:  ", 'm*')
plotMarkers(x1(x1minsTF),y1(x1minsTF), y1Offset, "min:  ", 'r*')
plotMarkers(x1(x1maxesTF),y1(x1maxesTF), -y1Offset, "max:  ",'b*')



title('График с отмеченными характерными точками');
xlabel('x');
ylabel('y1 = atan(-a + (x1-b).^2) .* sin(c + d*x1.^2);');
hold off;

grid on;






% Характерные точки y2 (полином)
x2zerosInd = find(diff(sign(y2)) ~= 0);
x2zeros = x2(x2zerosInd);
y2zeros = y2(x2zerosInd);

x2minsTF = islocalmin(y2);
x2maxesTF = islocalmax(y2);

subplot(2, 1, 2);
plot(x2,y2, 'k-', 'LineWidth', 2);

hold on;
plotMarkers(x2zeros, y2zeros, y2Offset, "zero: ", 'm*');
plotMarkers(x2(x2minsTF), y2(x2minsTF), y2Offset, "min: ", 'r*');
plotMarkers(x2(x2maxesTF),y2(x2maxesTF), -y2Offset, "max: ", 'b*');

title('График с отмеченными характерными точками');
xlabel('x');
ylabel('y2 = 1.5x^3 -0.3x^2 -9.86x -5.58');
grid on;

% % % % % % % % % % %  ЧАСТЬ B
figure('Name','(b) Разными стилями','Color','w');



styles = { 'k-', 'm:', 'g-', 'r--' };
markerStyles = { 's', 'o', '.', '^' };

%трансцендентрные
for i = 1: length(styles)
    subplot(2, 4, i);
    

    markersX1 = linspace(min(x1)+0.1*dis1, max(x1)-0.1*dis1,8);
    markersY1 = atan(-a + (markersX1-b).^2) .* sin(c + d*markersX1.^2);
    
    plot(x1,y1, styles{i}, 'LineWidth', 0.5*i);
    
    hold on;

    plot(markersX1, markersY1, markerStyles{i}, 'MarkerSize', 16 - i*2);
    
    for j = 1:length(markersX1)

    labelText = compose("(%.2f, %.2f)", markersX1(j), markersY1(j));
    
    plot([markersX1(j), markersX1(j)+0.03*dis1], [markersY1(j), markersY1(j)+y1Offset] , 'k-', 'LineWidth', 0.5)
    text(markersX1(j), markersY1(j) + y1Offset, labelText, ...
        'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'bottom', ...
        'FontSize', 10, ...
        'FontWeight', 'bold');
    end


    xlabel('x');
    ylabel('y1');
    % axis square; 
    title(["y1: Стиль: " + styles{i}, "LW: " + string(i*0.5)]);
end

%полиномы
for i = 1: length(styles)

    markersX2 = linspace(min(x2)+0.1*dis2, max(x2)-0.1*dis2,8);
    markersY2 = polyval(p, markersX2);;

    subplot(2, 4, i+4);
    plot(x2,y2, styles{i}, 'LineWidth', 0.5*i);

    hold on;
    plot(markersX2, markersY2, markerStyles{5-i}, 'MarkerSize', 16 - i*2);

    for j = 1:length(markersX2)
        
    labelText = compose("(%.2f, %.2f)", markersX2(j), markersY2(j));
    
    plot([markersX2(j), markersX2(j)+(-1)^j *0.03*dis2], [markersY2(j), markersY2(j)+(-1)^j *y2Offset] , 'k-', 'LineWidth', 0.5)
    text(markersX2(j)+(-1)^j *dis2*0.1, markersY2(j) +(-1)^j * y2Offset, labelText, ...
        'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'bottom', ...
        'FontSize', 10, ...
        'FontWeight', 'bold');
    end

    xlabel('x');
    ylabel('y2');
    % axis square; 
    title(["y2: Стиль: " + styles{i}, "LW: " + string(i*0.5)]);
end

% % % % % % % % % % %  ЧАСТЬ C

figure('Name','(c) В одних осях и в разных','Color','w');