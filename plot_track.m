function plot_track( track )                                               
%PLOT_TRACK creates several plots to visualize the track.
scrsz = get(0,'ScreenSize');
f = figure( const.FIGURE_TRACK);
%left,bottom,width,height
set(f,'Position', [1 0 scrsz(3)/2 scrsz(4)]); 
% plot the height profile
subplot(6,1,1)
    plot( track(:,const.COL_CUM_DST), track(:,const.COL_Z) );
    xlabel( 'distance [km]' );
    ylabel( 'height [m]' );
    
% plot the slope along the route
subplot(6,1,2)
    plot( track(:,const.COL_CUM_DST), track(:,const.COL_SLOPE) );
    xlabel( 'distance [km]' );
    ylabel( 'slope [%]' );
    
% plot the speed along the route
subplot(6,1,3)
    plot( track(:,const.COL_CUM_DST), track(:,const.COL_SPEED) );
    xlabel( 'distance [km]' );
    ylabel( 'speed [km/h]' );
    
% plot the acceleration along the route
subplot(6,1,4)
    plot( track(:,const.COL_CUM_DST), track(:,const.COL_ACC) );
    xlabel( 'distance [km]' );
    ylabel( 'acceleration [m/s^2]' );
    
% create a 3d plot of the route
subplot(6,1,5:6)
    plot3( track(:,const.COL_X), ...
           track(:,const.COL_Y), ...
           1000 * track(:,const.COL_Z), ...
           '.-', ...
           'MarkerSize', 5, ...
           'LineWidth', 1 );
    xlabel( 'X (long) [km]' );
    ylabel( 'Y (lat) [km]' );
    zlabel( 'height [m]' );
    grid( 'on' );
    box( 'on' );
    rotate3d( 'on' );
    colormap( 'Jet' );
end

