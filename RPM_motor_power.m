% This function computes the effective instantaneous power post efficiency losses (task 7) in the
% motor. It also computes the instantaneous Power which the battery cannot provide
% beyond its current limit or when it is empty under which the power that support system 
% requests from the motor will have to be given by the driver.

function [power] = RPM_motor_power (power_support,velocity,battery_empty)
  power_losses=0;
  power_driver = 0;
  max_current = 11;
  %max efficiency is 85%
  max_efficiency = 0.85;
  %max efficiency is 40%
  min_efficiency = 0.40; 
  limit_battery_power = 36*max_current;
  
  if velocity == 0
	  power_motor = 0;
      efficiency = min_efficiency;
  else
	    %assuming motor acheives max RPM at 22 km/h
		if velocity < 22
        %efficiency is linear to velocity.
		 efficiency = ((max_efficiency-min_efficiency)/22)*velocity + min_efficiency; 
        else 
		 efficiency = max_efficiency;
        end
 	     %calculate power post efficiency loss.	   
	     power_motor = power_support/efficiency;
         
         %if battery is empty, driver will have to provide all the power.
		if  battery_empty == 1
            power_driver = power_support;
            power_motor = 0;
        elseif  power_motor > limit_battery_power 
           % the battery cannot provide more than the max current limit. 
		   % so the total power required by the motor post its efficiency losses 
		   % has to be limited and the driver has to provide the extra power for the actual demand.
		   power_driver = (power_motor - limit_battery_power)*efficiency;  
		   power_motor = limit_battery_power;
        end
  end
  
  % this parameter will be exported to workspace to show the losses
  power_losses = power_motor*(1-efficiency);
  
  %% send the new power distribution.
  power(1)= power_motor;
  power(2)= power_driver; 
  power(3)= power_losses; % to display the loss on a graph
  power(4)= efficiency; % this to send efficiency to workspace
end