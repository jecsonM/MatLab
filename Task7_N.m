clc; clear; close all;
syms x a;

lim1 = limit( sqrt(1/x+sqrt(1/x+sqrt(1/x))) - sqrt(1/x-sqrt(1/x+sqrt(1/x))), x, 0, 'right') 
lim2 = limit( (tan(x)-tan(a))/(x-a), x, a)




lim3 = limit( log(1+2^x)*log(1+3/x) , x, Inf)


syms x;
diff1 =  diff(2*x/(1-x^2), x, 1)



syms a b;
diff2 =  diff( atan(x)+1/3 * atan(x^3) , x, 1)

diff3 = diff( 1/(x*sqrt(x))* (sqrt(a) *atan(x/a)- sqrt(b)*atan(sqrt(x/b))), x, 0)

disp('Пункт 2, полином')


p = [0.9 -0.63 -0.36 0.09];
syms x;
eq = poly2sym(p, x) == 0;

%аналитически
sol = solve(eq, x);    

%VPA
sol_vpa = vpa(sol, 10)

%roots
r_roots = roots(p)

%Разность точностей
sort((sol_vpa)) - sort(r_roots)

disp('Пункт 3, разложение функции в ряд Тейлора ')

syms x
f = x^2 - sin(x);

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
title(sprintf('Ряд Тейлора функции x^2 - sin(x) в точке x_0 = %g', x0));


%Пункт 4 Системы уравнений

rng(2); 

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