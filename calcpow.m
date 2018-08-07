function maxpower = calcpow(velocity)
% returns the maximum power that the electrical subsystem will offer. 
% The input argument is velocity of the bike in km/hr.
%the graceful degradation of motor power slope is 
%(250-0)/(limit_velocity - start velocity of gradual decrease) 

maxpower = (250/(25-22))*(25 - velocity);

% set limits to the degradation curve.
if maxpower<0
maxpower = 0;
elseif maxpower > 250
maxpower = 250;    
end

end