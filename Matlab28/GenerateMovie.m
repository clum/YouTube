%Generate a movie that may have different sized frames which necessitates
%the need to use MakeMovieVectorFramesSameSize.
%
%Christopher Lum
%lum@uw.edu

%Version History
%11/19/24: Created

clear
clc
close all

x = linspace(0,10,20);
y = linspace(-2,-3,15);
[X,Y] = meshgrid(x,y);

t = linspace(0,6,40);

for k=1:length(t)
    tk = t(k);
    Z = tk*cos(X+tk).*sin(Y+tk);

    surf(X,Y,Z);
    grid on
    xlabel('x')
    ylabel('y')
    zlabel('f(x,y)')
    movieVector(k) = getframe;
end

%Use the custom MakeMovieVectorFramesSameSize function to ensure all frames
%have the same width and height
movieVector = MakeMovieVectorFramesSameSize(movieVector,'method','shrink');

%Save the movie
myWriter = VideoWriter('curve.avi');
myWriter.FrameRate = 10;
open(myWriter);
writeVideo(myWriter,movieVector);
close(myWriter);