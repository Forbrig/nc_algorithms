//Vitor Guilherme Forbrig (vitorforbrig@gmail.com)
clc(); //clear console

A = [
 4, -1, -1, 0, 0, 0, 0, 0;
-1,  4,  0, -1, 0, 0, 0, 0;
-1,  0,  4, -1, 0, -1, 0, 0;
 0, -1, -1, 4, -1, 0, -1, 0;
 0,  0,  0, -1, 4, 0, 0, -1;
 0,  0,  -1,  0, 0, 4, -1, 0;
 0,  0,  0, -1, 0, -1, 4, -1;
 0,  0,  0, 0, -1, 0, -1, 4;
];
I = eye(A); //create an identity matrix with dimensions of A
ind = [95; 50; 80; 0; 30; 190; 110; 135]; //independent terms
indv = [95, 50, 80, 0, 30, 190, 110, 135];
x = [0; 0; 0; 0; 0; 0; 0; 0];
x0 = [0; 0; 0; 0; 0; 0; 0; 0];  //initial solution (dont change)
n = 8; //size of matrix nxn
eps = 10^-6; //here we put the minimum aproximation that we want
it = 100; //qt of iteractions
//---------------------------------------------------------------------MISC------------------------------------------------------------------
    function diagonal_dominant ()
    flag = 1;
    // convergent criteria
    //if the main diagonal is dominant, it converge for in Jacobi method (sufficient but not necessary)
    i = 1;
    while (i < n+1)
        j = 1;
        test = 0;
        while (j < n+1)
            test = test + A(i, j);
            j = j+1;
        end
        if ((test - A(i,i)) < A(i,i)) then
            flag = 1;
        else
            flag = 0;
            break;
        end
        i = i+1;
    end
     if (flag ==  1) then //check to see if jacobi converges (sufficient but not necessary)
        printf("Main diagonal is dominant\n"); //it converge for in Jacobi method
    end
    endfunction
    
    function eigen_values (AXX) //(auto valores)
        evals = spec(AXX); 
        if max(abs(evals)) < 1 then
            printf("it converges\n");
        end
        disp (abs(evals));
        //disp (evals);
    endfunction
    
//---------------------------------------------------------------------JACOBI------------------------------------------------------------------
function jacobi(A, ind, x, eps, it, n)
    for i = 1 : n
        for j = 1 : n
            AX(i, j) = A(i, j)/A(i, i); //create a new matrix isolating each xn -> ex:  x1 = (k2*x2+k3*x3)/k1
        end;
        indaux(i) = ind(i)/A(i, i); //same as line 6 all in reason of xn
    end;
    
    //eigen_values(AX);
    
    it2 = 0;
    prec = 10000; //just to enter on the loop
    while (eps < prec & it2 < it)
        x = indaux - (AX-I)*x; //new solution of this iteraction
        prec = norm((AX*x)-indaux);
        it2 = it2+1;
    end
    printf("JACOBI: after %d iteractions with a precision of %f the result is:\n", it2, prec);
    disp(x);
    
endfunction

//---------------------------------------------------------------------GAUSS------------------------------------------------------------------

function gauss (A, ind, x, eps, it, n)
    it2 = 0;
    prec = 1000;
    while (prec > eps & it2 < it)
        for (i=1:n)
            aux = 0;
            for (j=1:n)
                if (i <> j) then
                    aux = (A(i, j) * x(i)) + aux;
                end;
            end;
            x(i) = (1/A(i, i)) * (ind(i) - aux);
            //disp(x);
        end;
        prec = norm((A*x)-ind');
        it2 = it2 + 1; 
    end;
    printf("GAUSS: after %d iteractions with a precision of %f the result is:\n", it2, prec);
    disp(x);
endfunction
    
//---------------------------------------------------------------------MAIN------------------------------------------------------------------
printf("Welcome to system_approach 0.0.1\n");

while(1)  
    printf("Select an option:\n 1. Jacobi; 2. Gauss; 3. All; 0. Exit.\n");
    option = input("Option: ");
    select option
        case 1 then
            jacobi(A, ind, x0, eps, it, n);
        case 2 then
            gauss(A, indv, x0, eps, it, n);
        case 3 then
            jacobi(A, ind, x0, eps, it, n);
            gauss(A, indv, x0, eps, it, n);
        case 0 then
            break;
        else
            printf("Invalid option!\n");
    end;
    break;
end;
