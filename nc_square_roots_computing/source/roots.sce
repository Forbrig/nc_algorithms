//Vitor Guilherme Forbrig (vitorforbrig@gmail.com)

clc(); //clear console
eps = 0.001; //here we put the minimum aproximation that we want
it = 200; //number of iteractions

//---------------------------------------------------------------------MISC------------------------------------------------------------------
function [y] = f(x)
    y = x^2 +x -3; //the function goes here!
endfunction;

//derivate of the function
function [y] = df(x)
     y = 2*x + 1; // the derivate goes here! (for newton method)
endfunction

//print the casrtesian plane of the function, it allow us to get a better interval to isolate a root
function graphic(init, tend)
	interval = tend - init; //get the lenght of the interval
	interval = interval / 100; //to draw 100 points on the cartesian plane we add this to 'a'
	while (init < tend); //we increment init
		y = f(init);
		xgrid(); //draw lines on the cartesian	
		plot(init, y, '.k'); //draw the point aplicate on the function
		init = init + interval; //add the small amount (to the next dot)	
	end;
endfunction;

//here we validate the points, if the function give points with different values,
//positive and negative, that means in this interval have (at least) one root
function valid = validate(x, y)
	if (f(x) * f(y) > 0) then
        valid = 0;
	else
        valid = 1;
	end;
endfunction;

//---------------------------------------------------------------------BISSECTION------------------------------------------------------------------
//bissection is a kind of binary search that, with a pre-interval,
//get a better one, halving it
function bissec(a, b, eps)
    k = 0;
    while (abs(b - a) > eps & k < it) //when the root is near the eps or a the number of interactions reach 100
        xm  = (a + b) / 2.;    //middle
        //printf('On the %g iteraction: f(a)= %g, f(b) = %g  xm = %g\n', k, f(a), f(b), xm);
            
        if (f(a) * f(xm) < 0) then // choose if "a" will be changed
            b = xm;
        else (f(xm) * f(b) < 0)  // choose if "b" will be changed
            a = xm;
        end
        //printf('On the %g iteraction we get a = %g, b = %g\n', k+1, x0, x1);
        k = k+1;
    end
    printf('BISSECTION: After %g iteractions the root found is approximately %g\n', k-1, xm);
endfunction;

//---------------------------------------------------------------------SECANT--------------------------------------------------------------
function secant(a, b, eps)
    k = 0;
    xm = ((a * f(b)) -(b * f(a))) / (f(b) - f(a)); //to enter on loop
    
    while (min(abs(f(xm)), (b - a)) > eps & k < it) //when the root is near the eps or a the number of interactions reach 100
        xm = ((a * f(b)) -(b * f(a))) / (f(b) - f(a)); //secant proportion
        //printf('On the %g iteraction: f(a)= %g, f(b) = %g  xm = %g\n', k, f(a), f(b), xm);
        if (f(a) * f(xm) < 0) then // escolhe se o x1 vai ser substituido
            b = xm;
        else (f(xm) * f(b) < 0)  // escolhe se o x0 vai ser substituido
            a = xm;
        end
        k = k+1;
    end;
    printf('SECANT: After %g iteractions the root found is approximately %g\n', k-1, xm);
endfunction

//---------------------------------------------------------------------NEWTON------------------------------------------------------------------
function newton(a, b, eps) //it dont use the "right side b"
    k = 0;
    flag = 1; //need this for the first interaction because the abs(a - xm) < eps 
    xm = a;
    while (((abs(a - xm) > eps) | flag == 1) & k < it) //when the root is near the eps or a the number of interactions reach 100
        flag = 0;
        xm = a;
        a = xm - (f(xm)/df(xm)); //this is the next a
        k = k+1;
    end;
    printf('NEWTON: After %g iteractions the root found is approximately %g\n', k-1, xm);
endfunction
//---------------------------------------------------------------------MAIN------------------------------------------------------------------

printf("Welcome to roots 0.0.2\n");
graphic(-10, 10); // I haven't imagined how I will define a good interval... (NEED TO CHANGE THE PARAMETERS)

while(1)
    while(1)
        printf("Give an interval (choose by looking in the graph)"); //points A and B must be in opposite sides of X axis
        a = input("Left point: ");
        b = input("Right point: ");
        valid = validate(a, b);
        if (valid == 1) then
            printf("f(%g) and f(%g) are valid\n", a, b);
            break;
        else
            printf("f(%g) and f(%g) must be in opposite sides\n", a, b);
        end
    end;
    
    printf("Select an option:\n 1. Bissection; 2. Secant; 3. Newton; 4. All; 0. Exit.\n");
    option = input("Option: ");
    select option
        case 1 then
            bissec(a, b, eps);
        case 2 then
            secant(a, b, eps);
        case 3 then
            newton(a, b, eps);
        case 4 then
            bissec(a, b, eps);
            secant(a, b, eps);
            newton(a, b, eps);
        case 0 then
            break;
        else
            printf("Invalid option!\n");
    end;
    break;
end;
