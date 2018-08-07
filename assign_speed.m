function track_data = assign_speed(gpx_data)                               
%ASSIGNSPEED assigns a driving speed to each track point.
% ROUTE = ASSIGNSPEED(TRACK_DATA) extends the gpx data by adding columns
% for velocity, time and acceleration.
%
% GPX_DATA  is a Nx8 array where each row is a track point.
%   Columns 1-3 are the X, Y, and Z coordinates.
%   Column  4 is the distance between the track point and its predecessor
%   Column  5 is the cumulative track length
%   Column  6 is the slope between the track point and its predecessor.
%
% TRACK_DATA  is a Nx11 array where each row is a track point.
%   Columns 1-3 are the X, Y, and Z coordinates.
%   Column  4 is the distance between the track point and its predecessor
%   Column  5 is the cumulative track length
%   Column  6 is the slope between a track point and its predecessor in percent (%).
%   Column  7 is the speed in km/h
%   Column  8 is the time in hours
%   Column  9 is the accumulated time in hours
%   Column  10 is the acceleration in m/s^2.
%
% See also loadgpx 

% set track_data for speed, time per segment, cumulated time and acceleration to zero
track_data = gpx_data;
track_data(:,const.COL_SPEED:const.COL_ACC) = 0;

% assign speed to each trackpoint 
%track_data = assign_fixed_speed( track_data );

track_data = assign_slope_based_speed( track_data );
track_data = compute_time_and_acceleration( track_data );

end

%% local functions

function out = assign_fixed_speed( in )
out = in;
% assign fixed speed of 20 km/h
out(:,const.COL_SPEED) = 22;
end

function out = assign_slope_based_speed( in )
out = in;
% assign speed based on the slope (given as a percentage in %) of the segment
out(:,const.COL_SPEED) = 20-80*(sin(atan(out(:,const.COL_SLOPE)/100)));

out(out(:,const.COL_SPEED)<5,const.COL_SPEED)=5;    

end

function out = compute_time_and_acceleration( in )
out = in;

out(1,const.COL_SEG_TIME) = 0;  % time
out(1,const.COL_CUM_TIME) = 0;  % cumulated time
out(1,const.COL_ACC) = 0;  		% acceleration

for i = 2:size(in, 1)
    % compute average and delta speed over segment
    %u - Initial speed, v - final speed.
    u = out(i-1,const.COL_SPEED);
    v = out(i, const.COL_SPEED);
    
    Avgspeed = (v+u)/2;
    Deltaspeed = v-u;
    
    % compute segment time in hours from average speed
    out(i, const.COL_SEG_TIME) = out(i, const.COL_SEG_DST)/Avgspeed;

    % compute accumulated time in hours
    out(i, const.COL_CUM_TIME) = out(i, const.COL_SEG_TIME) + out(i-1,const.COL_CUM_TIME);
    % compute acceleration in m/s^2 from delta speed between two gps coordinates   
    out(i, const.COL_ACC) = (Deltaspeed)/(out(i, const.COL_SEG_TIME));
    out(i, const.COL_ACC)=out(i, const.COL_ACC)*1000/(3600*3600);
end

end
