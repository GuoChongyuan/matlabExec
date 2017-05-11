function coordinate_plot(transCoordinate,returnCoordinate,targetCoordinate)        %连线各点，将路线画出来
    hold on;
    plot(transCoordinate.x,transCoordinate.y,'r*',returnCoordinate.x,returnCoordinate.y,'r*',targetCoordinate.x,targetCoordinate.y,'r*');
    line([transCoordinate.x,returnCoordinate.x],[transCoordinate.y,returnCoordinate.y]);
    line([transCoordinate.x,targetCoordinate.x],[transCoordinate.y,targetCoordinate.y]);
    line([returnCoordinate.x,targetCoordinate.x],[returnCoordinate.y,targetCoordinate.y]);
    hold off;