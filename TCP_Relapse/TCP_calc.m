function TCP_dose_curve = TCP_calc (percent_in_morning)
t_end = 20;
IC = 10^6;
dose = 3;
%dose_per_fr  = 1.5;
t_end_rad = 0.02;
t_fraction = 1;
dose_1 = dose * percent_in_morning;
dose_2 = dose * (1-percent_in_morning);
%percent_in_morning = 0.66; % VARY THIS PARAMETER!

params = [dose ; 1 ; 0.02 ; 20 ; 0.4; 0.3 ; percent_in_morning]; 

[Y]=ode4(@(t,y)(dCells(t,y,params)),0:0.005:t_end,IC);
%plot(0:0.005:t_end,Y)
%figure();
TCP_time_fcn = exp(-Y);
%plot(0:0.005:t_end,TCP_time_fcn)
dose_time_fcn = @(t)((dose_1 / t_end_rad) .* (mod(t,t_fraction)) .* (mod(t,t_fraction) < t_end_rad) + floor (t / t_fraction) .* dose  + dose_1*(mod(t,t_fraction) >= t_end_rad) + (dose_2 / t_end_rad) .* (mod(t-0.25,t_fraction)) .*(mod(t,t_fraction)> 0.25) .* (mod(t,t_fraction) < t_end_rad+0.25) + dose_2*(mod(t,t_fraction) >= t_end_rad + 0.25) )
times_vec= 0:0.005:t_end;

doses_and_times = dose_time_fcn(times_vec);
doses_vec = 0:1:60;
req_TCP = [];
for k = 1:length(doses_vec);
    req_dose = doses_vec(k);
for i=2:length(doses_and_times)
    cur_dose = doses_and_times(i);
    prev_dose = doses_and_times(i-1);
if (cur_dose >= req_dose && prev_dose <= req_dose )
    req_TCP(k) =TCP_time_fcn(i) ;% times_vec(i);
    %req_time
    break;
end
end
end
%figure();
plot(doses_vec,req_TCP,'linewidth',2);

TCP_dose_curve = [doses_vec' req_TCP'];
%plot(dose_time_fcn(0:0.005:t_end),0:0.005:t_end)
%dose_checked = 30;
%time_for_dose = interp1(dose_time_fcn(0:0.005:t_end),0:0.005:t_end,dose_checked)
%time_for_dose
%TCP_at_dose = interp1(0:0.005:t_end,exp(-Y),time_for_dose)
%TCP_at_dose
% for i=1:10
%    exp(-Y(i))
    
    
%    exp(-Y(length(Y)))
   
% end
% TCP_time_fcn = exp(-Y);
% 
% interp1(0:0.005:t_end,TCP_time_fcn,3.02)
% 
% interp1(0:0.005:t_end,TCP_time_fcn,4.27)
% interp1(0:0.005:t_end,TCP_time_fcn,6.26)
% interp1(0:0.005:t_end,TCP_time_fcn,8.02)
% interp1(0:0.005:t_end,TCP_time_fcn,9.27)
% interp1(0:0.005:t_end,TCP_time_fcn,11.26)
% interp1(0:0.005:t_end,TCP_time_fcn,13.02)
% interp1(0:0.005:t_end,TCP_time_fcn,14.27)
% interp1(0:0.005:t_end,TCP_time_fcn,16.26)
% interp1(0:0.005:t_end,TCP_time_fcn,18.02)
% interp1(0:0.005:t_end,TCP_time_fcn,19.27)











% for conventional = 2gy/fr

% TCP_time_fcn(805) %10
% TCP_time_fcn(801 + 602) %15
% TCP_time_fcn(801 + 200*5 + 4) %20
% TCP_time_fcn(801 + 200*8 + 2 ) %25
% TCP_time_fcn(801 + 200*10 + 4) %30
% TCP_time_fcn(801 + 200*13 + 2) %35
% TCP_time_fcn(801 + 200*15 + 4) %40
% TCP_time_fcn(801 + 200*18 + 2) %45
% TCP_time_fcn(801 + 200*20 + 4) %50
% TCP_time_fcn(801 + 200*23 + 2) %55
% TCP_time_fcn(801 + 200*25 + 4) %60

% for hypo = 3Gy / Fr




% 
% 
% dose_time_fcn = @(t)((dose_per_fr / t_end_rad) .* (mod(t,t_fraction)) .* (mod(t,t_fraction) < t_end_rad) + floor (t / t_fraction) .* dose_per_fr  + dose_per_fr*(mod(t,t_fraction) >= t_end_rad))
% time_vec = 0:0.005:t_end;
% nextLoc = 1;
% TCP_dose = [];
% proper_dose_fcn = [];
% for i=1:length(time_vec)
% if (mod(time_vec(i),t_fraction) <= t_end_rad)    
% TCP_dose(nextLoc) = TCP_time_fcn(i)
% proper_dose_fcn(nextLoc) = dose_time_fcn(time_vec(i));
% nextLoc = nextLoc + 1;
% end
% 
% end
% 
% % TCP_dose
% % proper_dose_fcn
% plot(proper_dose_fcn, TCP_dose);
% A = [proper_dose_fcn' TCP_dose']
% %figure();
% %plot(0:0.005:t_end, dose_time_fcn(0:0.005:t_end));
% %plot(dose_time_fcn(0:0.005:t_end), exp(-Y));
% 
% %dose_time_values = dose_time_fcn(0:0.005:t_end);
% %dose_time_duplicates_removed = zeros(length(Y),2);
% 
% % for i=1:length(Y)
% % cur_dose = dose_time_values(i);
% % 
% % if (cur_dose ~= dose_time_duplicates_removed(nextLoc-1,1))
% %     dose_time_duplicates_removed(nextLoc,:) = [cur_dose time_vec(i)];
% %     nextLoc = nextLoc + 1;
% % end
% % end
% % dose_time_duplicates_removed(1:500)
