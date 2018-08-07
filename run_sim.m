% This script will configure and run the simulation.                       

disp( '#######################' );
prepare_sim;


%% first simulation run
% update model parameters
disp( 'Updating model parameters for racing bike.' );
% send variable to workspace which will be used by simulink.
coeff_friction = [0 0.003; 0.5 0.003]; 
coeff_airdrag = [0 0.4; 0.5 0.4];
frontal_area = [0 0.38; 0.5 0.38];
Initial_Batt_capacity = [0 11; 0.5 11];
Driver_Mass = [0 70; 0.5 70];
Bike_Mass = [0 22; 0.5 22];
Racing_Batt_Init = Initial_Batt_capacity(1,2);
% run simulation
var = sim('ebike.slx','SimulationMode','normal');
racing_bike = var.get('simout');
assignin('base','racing_bike',racing_bike);


%% second simulation run
%Standard bike 
% update model parameters
disp( 'Updating model parameters for standard bike.' );

%% send variables to workspace which will be used by simulink.

%Physical parameters of the bike and rider
coeff_friction = [0 0.006; 0.5 0.006]; 
coeff_airdrag = [0 1.1; 0.5 1.1];
frontal_area = [0 0.5; 0.5 0.5];
Driver_Mass = [0 70; 0.5 70];
Bike_Mass = [0 22; 0.5 22];
Initial_Batt_capacity = [0 11; 0.5 11]; 
Std_Batt_Init = Initial_Batt_capacity(1,2);

%% run simulation
var = sim('ebike.slx','SimulationMode','normal');
std_bike = var.get('simout');
assignin('base','std_bike',std_bike);
plot_track(track);


%% compute statistics from simulation result
                         
%%%%%%%%%%% Generate plots %%%%%%%%%%

scrsz = get(0,'ScreenSize');
fig = figure(1);
set(fig,'Name','Power Distribution','position',[scrsz(3)/2 0 scrsz(3)/2 scrsz(4)/2]);

subplot(3,2,1)
plot(std_bike.time,std_bike.data(:,4),'b',racing_bike.time,racing_bike.data(:,4),'r');
xlabel( 'time [h]' );
ylabel( {'Power';'acceleration [W]--->'});
axis([0 simin(end,1)+0.1 -inf inf]);

subplot(3,2,2)
plot(std_bike.time,std_bike.data(:,6),'b',racing_bike.time,racing_bike.data(:,6),'r');
xlabel( 'time [h]' );
ylabel( 'Power friction [W]--->' );
axis([0 simin(end,1)+0.1 -inf inf]);

subplot(3,2,3)
plot(std_bike.time,std_bike.data(:,5),'b',racing_bike.time,racing_bike.data(:,5),'r');
xlabel( 'time [h]' );
ylabel( 'Power Airdrag [W]--->' );
axis([0 simin(end,1)+0.1 -inf inf]);

subplot(3,2,4)
plot(std_bike.time,std_bike.data(:,7),'b',racing_bike.time,racing_bike.data(:,7),'r');
xlabel( 'time [h]' );
ylabel( {'Power Downhill','slope [W]--->'} );
axis([0 simin(end,1)+0.1 -inf inf]);

subplot(3,2,5)
plot(std_bike.time,std_bike.data(:,3),'b',racing_bike.time,racing_bike.data(:,3),'r');
xlabel( 'time [h]' );
ylabel( {'Max support';'Power limit [W]--->'} );
axis([0 simin(end,1)+0.1 -inf inf]);

subplot(3,2,6)
plot(std_bike.time,std_bike.data(:,9)*100,'b',racing_bike.time,racing_bike.data(:,9)*100,'r');
xlabel( 'time [h]' );
ylabel( 'Efficiency [%]--->');
axis([0 simin(end,1)+0.1 -inf inf]);


% Display Battery RCC and driver energy as subplots.
fig2 = figure(2);
set(fig2,'Position', [scrsz(3)/2 scrsz(4)/2 scrsz(3)/2 scrsz(4)/4]); 
subplot(1,3,1);
plot(std_bike.time,std_bike.data(:,1),'b',racing_bike.time,racing_bike.data(:,1),'r');
xlabel( 'time [h]' );
ylabel( 'Reserve capacity [Ah]--->' );
axis([0 simin(end,1)+0.1 -inf inf]);
subplot(1,3,2);
plot(std_bike.time,std_bike.data(:,2),'b',racing_bike.time,racing_bike.data(:,2),'r');
xlabel( 'time [h]' );
ylabel( 'Driver Energy [Wh]--->' );
axis([0 simin(end,1)+0.1 -inf inf]);
subplot(1,3,3);
plot(std_bike.time,std_bike.data(:,8),'b',racing_bike.time,racing_bike.data(:,8),'r');
xlabel( 'time [h]' );
ylabel( {'Wasted energy due'; 'to efficiency [Wh]'} );
axis([0 simin(end,1)+0.1 -inf inf]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% TASK 6 ANALYSING  RESULTS OF MULTIPLE SIMULATIONS:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% analyze simulation of racing bike
fprintf('\n##############################################################\n');
disp('ANALYSING RESULTS OF MULTIPLE SIMULATIONS:');
disp('SIMULATION 1: RACING BIKE');
BattRCC = racing_bike.data(end,1);
DriverEnergy = racing_bike.data(end,2);
WastedEnergy = racing_bike.data(end,8);

fprintf('1.Battery Energy available after simulation: %f Ampere hours \n', BattRCC);
fprintf('2.Driver Energy spent: %f Watt hours \n', DriverEnergy);
% for displaying on text window
str1 = sprintf('Battery Reserve Capacity : %f Ah',BattRCC);
str2 = sprintf('Energy given by driver : %f Wh',DriverEnergy);

%Calculate remaining battery energy and Conversion from Ah to Watthours
BattEnergy = (Racing_Batt_Init-BattRCC)*36;  
TotalEnergySpentRace = BattEnergy + DriverEnergy;

str3 = sprintf('Energy consumed by the Motor : %f Wh', BattEnergy);
str4 = sprintf('Total energy spent : %f Wh', TotalEnergySpentRace);
str5 = sprintf('Total energy wasted : %f Wh', WastedEnergy);
fprintf('3.Total Energy Spent: %f Watthours \n', TotalEnergySpentRace);
%Determination of feasibility of Riding Track on Racing bike with the given 
%Battery Capacity.
TrackEndTime=simin(end,1); %Get end time of track data
SimTimeOfLastTrack=find(racing_bike.Time>=TrackEndTime, 1, 'first');
BattCapAfterSim=racing_bike.data(SimTimeOfLastTrack,1);
if (BattCapAfterSim>0)
    fprintf('Riding this Track on Racing bike is Feasible!\n');
     str6 = sprintf('This system is feasible to run this track!');
else
    fprintf('Riding this Track on Racing bike is not Feasible!\n')
    str6 = sprintf('This system is not feasible to run this track!');
end    
fprintf('------------------------------------------------------------\n');
%% analyze simulation of standard bike
disp('SIMULATION2: STANDARD BIKE');
BattRCC = std_bike.data(end,1);
DriverEnergy = std_bike.data(end,2);
WastedEnergy = std_bike.data(end,8);

%%%%Display to cmd window %%%%%%%%%%%%%%%%
fprintf('1.Battery Energy available after simulation: %f Ampere hours \n', BattRCC); 
fprintf('2.Driver Energy spent: %f Watt hours \n', DriverEnergy);
BattEnergy = (Std_Batt_Init-BattRCC)*36; %Calculate remaining battery energy and 
                                         %Conversion from Ah to Watthours
TotalEnergySpentStd = BattEnergy + DriverEnergy;
fprintf('3.Total Energy Spent: %f Watt hours \n', TotalEnergySpentStd);
%Determination of feasibility of Riding Track on Standard bike with the given 
%Battery Capacity.
TrackEndTime=simin(end,1); %Get end time of track data
SimTimeOfLastTrack=find(std_bike.Time>=TrackEndTime, 1, 'first');
BattCapAfterSim=std_bike.data(SimTimeOfLastTrack,1);

if (BattCapAfterSim>0)
    fprintf('Riding this Track on Standard bike is Feasible!\n');
    str12 = sprintf('This system is feasible to run this track!');
else
    fprintf('Riding this Track on Standard bike is not Feasible!\n')
    str12 = sprintf('This system is not feasible to run this track!');
end

fprintf('\n');
if (TotalEnergySpentStd > TotalEnergySpentRace)
    fprintf('Standard Bike consumed %f Watthours more than Racing bike\n', TotalEnergySpentStd-TotalEnergySpentRace);
    str13 = sprintf('Standard Bike consumed %f Watthours more than Racing bike\n', TotalEnergySpentStd-TotalEnergySpentRace);
elseif (TotalEnergySpentStd < TotalEnergySpentRace)
    fprintf('Standard Bike consumed %f Watthours more than Racing bike\n', TotalEnergySpentRace-TotalEnergySpentStd);
    str13 = sprintf('Standard Bike consumed %f Watthours more than Racing bike\n', TotalEnergySpentRace-TotalEnergySpentStd);
else
    fprintf('Standard Bike consumed same energy as Racing Bike\n');    
    str13 = sprintf('Standard Bike consumed same energy as Racing Bike\n');
end

%% data for dispay %%
str7 = sprintf('Battery Reserve Capacity : %f Ah',BattRCC);
str8 = sprintf('Energy given by driver : %f Wh',DriverEnergy);
str9 = sprintf('Energy consumed by the Motor : %f Wh', BattEnergy);
str10 = sprintf('Total energy spent : %f Wh', TotalEnergySpentStd );

str11 = sprintf('Total energy wasted : %f Wh', WastedEnergy);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

strt=char(str1,str2,str3,str4,str5,str6,str7,str8,str9,str10,str11,str12,str13);
display_on_screen(strt);

fprintf('##############################################################\n');


%% clean up workspace
disp( 'Cleaning up Workspace.' );
% clear parameters
% clear simulation output
clear;
disp( 'Done.' );
disp( '#######################' );