//Vitor Guilherme Forbrig (vitorforbrig@gmail.com)
clc(); //clear console

n = 1;


x = [1; 2; 3];
y = [3; 2; 1];
n = size(x1, 1); //returns how many points there are





g = 1; //grau do polinomio [1: a0 + a1x; 2: a0 + a1x + a2x¹; etc.]

//pontos
x0 = [1; 1.4; 2; 3.1];
y0 = [4; 3.7; 2; 0.5];
n = size(x0, 1); //calcula o numero de pontos que digitou acima

//calcula a matriz A
function [A]= preencheMatrizA(x0,g,n) 
    for i=(1:n)
        for j=1:(g+1)
            A(i,j) = x0(i)^(j-1)
        end
    end
endfunction

//efetua o ajuste linear, calculando o vetor de coeficientes x
function [x] = calculaCoef(A,y0) 
    x = inv(A'*A)*A'*y0
endfunction

//calcula R²
function [R2] = coeficienteDeCorrelacao(y,y0,n)
    ym = sum(y0)/n;
    R2 = 1 - sum((y-y0).^2)/sum((y0-ym).^2);
endfunction

//-- chamada das funções -- //
A = preencheMatrizA(x0,g,n);
x = calculaCoef(A,y0);
y = A*x; //calcula y da curva ajustada (ŷ)

// -- imprime na tela do scilab -- //
disp("Coeficiente de Correlação (R²):")
disp(coeficienteDeCorrelacao(y,y0,n))
for i=1:(g+1)
    disp(x(i)," = ",i-1,"a")//scilab imprime de trás pra frente
end
