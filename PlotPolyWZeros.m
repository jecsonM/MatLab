function PlotPolyWZeros(p,x, plot_title, ylims, alternateYoffset)
arguments
        p
        x
        plot_title
        ylims = [-20 20]
        alternateYoffset = 1        % значение по умолчанию
    end

y = polyval(p, x);

xzeros = roots(p);
xzeros = xzeros(abs(imag(xzeros)) < 1e-6);
xzeros = real(xzeros);
         
xzeros = xzeros(xzeros > min(x) & xzeros < max(x));                 


yzeros = polyval(p, xzeros);


plot(x,y);
ylim(ylims);
title(plot_title);
xlabel('x');
ylabel('y');
hold on;
plotMarkersWX(xzeros, yzeros, 0.1, 1, "zero:  ", 'm*', 1, alternateYoffset);

end

