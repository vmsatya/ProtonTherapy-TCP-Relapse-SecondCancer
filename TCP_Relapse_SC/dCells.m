function dy=dCells(t,y,params)
% Andrew Dhawan
% Summer Research Term 2012
% This contains the ODEs for the system with S, P1,...PN, M cells
% including effects of dedifferentiation
%dy = zeros(3,1);

dose = params(1);
t_fraction = params(2);
t_dose_given = params(3);
t_end_rad = params(4);
 alpha = params(5);
rho = params(6);
percent_in_morning = params(7);

%alpha = params(1);
%beta = params(2);
%N = params(3);
%k = params(4);
dose= percent_in_morning * dose;
dose_2 = (1-percent_in_morning) * dose;
%dose = 2 * dose / 3;
%dose_2 = dose/2;

%delta = @(t)(5*sin(t)+5);
if (mod(t,t_fraction)  < t_dose_given && t<= t_end_rad )
    dy = rho * y - alpha* dose * y / t_dose_given ;
elseif (mod(t,t_fraction)  < t_dose_given+ 0.25 && t<= t_end_rad && mod(t,t_fraction) > 0.25)
dy = rho * y - alpha* dose_2 * y / t_dose_given ;
else
    dy = rho * y;
end
%dy(1) = alpha  - beta * y(1) * y(2);
%dy(2) = N * k * y(3) - beta * y(1) * y(2);
%dy(3) = beta * y(1) * y(2) - (delta(t) + k) * y(3);

end
