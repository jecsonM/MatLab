function plotMarkers(markersX, markersY, yOffset, labelPrefix, markerStyle)
    % plotMarkers отрисовывает линии-выноски и текстовые метки для точек.
    %
    % Входные параметры:
    %   markersX    - вектор координат X
    %   markersY    - вектор координат Y
    %   labelPrefix - строка/текст перед координатами (например, "Точка")
    %   xOffset     - смещение текста по оси X относительно самой точки
    %   yOffset     - смещение линии и текста по оси Y
    
    plot(markersX, markersY, markerStyle, 'MarkerSize', 8);
    for j = 1:length(markersX)
        
        fullLabelText = compose("%s (%.2f; %.2f)", labelPrefix, markersX(j), markersY(j));
        
        % Отрисовка линии-выноски от точки до начала текста

        
        plot([markersX(j), markersX(j)+0.001], [markersY(j), markersY(j) + yOffset], 'k-', 'LineWidth', 0.5)
        
        text(markersX(j), markersY(j) + yOffset, fullLabelText, ...
            'HorizontalAlignment', 'center', ...
            'VerticalAlignment', 'bottom', ...
            'FontSize', 10, ...
            'FontWeight', 'bold');
    end
end
