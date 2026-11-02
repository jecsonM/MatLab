clc; clear; close all;
syms x a n;

lim1 = limit( (x^2-5*x+6)/(x^2-8*x+15), x, 3) 
lim2 = limit( (tan(a+2*x)-2*tan(a+x)+tan(a))/(x^2), x, 0)


assume(x > 0);
assume(n, 'positive')          
assumeAlso(n, 'integer');

lim3 = limit( (n^2)*(x^(1/n) - x^(1/(n+1))) , x, Inf)

syms x;
diff1 =  diff(x * (log(x+sqrt(1+x^2)))^2, x, 1)


syms a b;
diff2 =  diff( 2/sqrt(a^2-b^2) * acot(sqrt((a-b)/(a+b)))*tan(x/2) , x, 1)


syms phi R;
assume(phi > 0 & phi < pi)   ;

b = 2*R*sin(phi);      
h = R*(1 - cos(phi));  

S_seg = simplify( (1/2)*R^2*(2*phi) - (1/2)*R^2*sin(2*phi) );
S_tri = simplify( (1/2)*b*h );

L4 = limit(S_seg / S_tri, phi, 0)

disp('Пункт 2, полином')


p = [1.5, -0.3, -9.86, -5.48];
syms x;
eq = poly2sym(p, x) == 0;

%аналитически
sol = solve(eq, x);    

%VPA
sol_vpa = vpa(sol, 10)

%roots
r_roots = roots(p)

%Разность точностей
sort(double(sol_vpa)) - sort(r_roots)

disp('Пункт 3, разложение функции в ряд Тейлора ')

syms x
f = 5*x - 8*log(x) - 8;

x0 = 1;                  
orders = [2 3 4 5]; 


T = cell(1, numel(orders));
for k = 1:numel(orders)
    T{k} = taylor(f, x, x0, 'Order', orders(k));
end


syms t
for k = 1:numel(orders)
    Tt = subs(T{k}, x, t + x0);      
    coeffs_k = coeffs(Tt, t, 'All'); 
    fprintf('Порядок %d (членов: %d)\n', k, orders(k));
    disp(T{k})
    disp('Коэффициенты (по возрастанию степени t = x-x0):')
    disp(coeffs_k)
end


%Пункт 3 Графики
xmin = x0 - 0.5;    
xmax = x0 + 0.5;


xx = linspace(xmin, xmax, 400);
f_num = double(subs(f, x, xx));

figure; hold on; grid on;
plot(xx, f_num, 'k-', 'LineWidth', 2);


styles = {'r--','g--','b--','m--'};
for k = 1:numel(orders)
    T_num = double(subs(T{k}, x, xx));
    plot(xx, T_num, styles{k}, 'LineWidth', 1.2);
end

legend(['f(x)', arrayfun(@(n) sprintf('Taylor Order=%d',n), orders, 'UniformOutput', false)], ...
       'Location','best');
xlabel('x'); ylabel('y');
title(sprintf('Ряд Тейлора функции 5x - 8ln x - 8 в точке x_0 = %g', x0));


%Пункт 4 Системы уравнений

rng(0); 

n = 3;
while true
    A = round(-9 + 18*rand(n,n));  
    if abs(det(A)) > 1e-10 
        break;
    end
end
b = round(-9 + 18*rand(n,1));

disp('A ='); disp(A)
disp('b ='); disp(b)
fprintf('det(A) = %g\n\n', det(A));

% Аналитически через solve
syms x1 x2 x3
x = [x1; x2; x3];
sol_solve = solve(A*x == b, x);     
x_solve = [sol_solve.x1; sol_solve.x2; sol_solve.x3];
x_solve_vpa = vpa(x_solve, 10);
disp('solve(vpa,10)')
disp(x_solve_vpa)

% Через обратную матрицу inv

x_inv = inv(sym(A)) * sym(b);
x_inv_vpa = vpa(x_inv, 10);

disp('inv(A)*b (vpa, 10)')
disp(x_inv_vpa)

%Через обр. слэш
x_backslash = A \ b;

disp('A\b ')
disp(x_backslash)



fprintf('\nСравнение (макс. |разность|):\n');
fprintf('  |solve - inv|       = %.2e\n', max(abs(double(x_solve_vpa) - double(x_inv_vpa))));
fprintf('  |solve - backslash| = %.2e\n', max(abs(double(x_solve_vpa) - x_backslash)));
fprintf('  |inv   - backslash| = %.2e\n', max(abs(double(x_inv_vpa) - x_backslash)));