//Vitor Guilherme Forbrig (vitorforbrig@gmail.com)
clc(); //clear console

g = 1; //polynomial grade

//if g>1 you need to put the values this way (with the respective exp)
// x = [
// 1^3 2^2 3^1 1;
// 1^3 2^2 3^1 1;
// 1^3 2^2 3^1 1
// ];


x = [-2.0; -0.5; 1.2; 2.1; 3.5; 5.4];
y = [4.4; 5.1; 3.2; 1.6; 0.1; -0.4];
n = size(x, 1); //returns how many points there are

if (g == 1) then
    B = x' * x;
    A = ((inv(B)*x') * y);
    printf("The adjusted x value:\n");
    disp(A);
else then
    B = x' * x;
    A = ((inv(B)*x') * y);
    printf("The adjusted x value:\n");
    disp(A);
end
