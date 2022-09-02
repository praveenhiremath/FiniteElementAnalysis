% Praveenkumar Hiremath - matriculation number 57955
function [ C ] = materialr(e,n)

C1=[1,n,0;n,1,0;0,0,(1-n)/2];

C=(e/(1-(n*n)))*C1;



% C1=[1-n,n,0;n,1-n,0;0,0,(1-(2*n))/2];
% 
% C=(e/((1+n)*(1-(2*n))))*C1;

end

