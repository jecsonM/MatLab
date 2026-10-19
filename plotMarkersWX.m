function plotMarkersWX(markersX, markersY, xOffset, yOffset, labelPrefix, markerStyle, alterX, alterY)
    
    plot(markersX, markersY, markerStyle, 'MarkerSize', 8);
    for j = 1:length(markersX)
        
        fullLabelText = compose("%s (%.2f; %.2f)", labelPrefix, markersX(j), markersY(j));
       
        plot([markersX(j), markersX(j)+ ((-1)^j)^alterX*xOffset], [markersY(j), markersY(j) + ((-1)^j)^alterY*yOffset], 'k-', 'LineWidth', 0.5);
        
        text(markersX(j) + ((-1)^j)^alterX*xOffset, markersY(j) + ((-1)^j)^alterY*yOffset, fullLabelText, ...
            'HorizontalAlignment', 'center', ...
            'VerticalAlignment', 'bottom', ...
            'FontSize', 10, ...
            'FontWeight', 'bold');
    end
end