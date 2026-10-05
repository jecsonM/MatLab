function plotMarkers(markersX, markersY, yOffset, labelPrefix, markerStyle)
    
    plot(markersX, markersY, markerStyle, 'MarkerSize', 8);
    for j = 1:length(markersX)
        
        fullLabelText = compose("%s (%.2f; %.2f)", labelPrefix, markersX(j), markersY(j));
       
        plot([markersX(j), markersX(j)+0.001], [markersY(j), markersY(j) + yOffset], 'k-', 'LineWidth', 0.5)
        
        text(markersX(j), markersY(j) + yOffset, fullLabelText, ...
            'HorizontalAlignment', 'center', ...
            'VerticalAlignment', 'bottom', ...
            'FontSize', 10, ...
            'FontWeight', 'bold');
    end
end
