# ebike_model
## Introduction
This simulink model aims at modelling of energy requirements for an ebike/Pedelec

## Install

This model requires `MATLAB-SIMULINK` version `R2016a` at least.
Toolboxes required: Basic inbuilt toolboxes are sufficient

## Description
  
### Code
 - `run_sim.m` is the main file that needs to be run from `MATLAB`.
 - `run_sim.m` also runs the file `prepare_sim` which does the extraction of .gpx data as a time-series distribution of elevation and x , y  information.
 - `loadgpx.m` is a specific implementation serving the information requirement for this project. this is not a general purpose implementation and is used for demonstration. However, programmers can extend this to serve their needs.
 
 `track` is a Nx6 array where each row is a track point
 
 `Columns 1-3` are the X, Y, and Z coordinates
 
 `Column  4` is the distance between the track point and its predecessor in km
 
 `Column  5` is the cumulative track length in km
 
 `Column  6` is the slope between a track point and its predecessor in percent (%).
 
 - `plot_track` plots a rudimentary 3D plot of the route based on the x, y , elevation information deciphered from the .gpx file.
 
 - `ebike.slx` simulink file with the model of the ebike, its motor and the battery that need not be opened by the user to run the `run_sim.m` file. But, they are encouraged to open and play with it.
 
 - `const.m` defines all the constants used in the project
 
 - `assign_speed.m` uses kinematic equations to find instantaneous `velocity v(t)`, `acceleration a(t)` and a function that can 
impute that resonable `velocity v(t)` using the information available from the x and y and elevation of the .gpx file. 

 - `calcpow.m` implements the legal motor shutoff requirements for the pedelec by the EU road transport safety authorities

 - `display_on_screen.m` implements a chart based display of the parameters of the ebike and whether it has enough energy to meet the track requirements. 

 - `RPM_motor_power.m` This computes the effective instantaneous power post efficiency losses in the motor. It also computes the instantaneous Power which the battery cannot provide beyond its current limit or when it is empty under which the power that support system requests from the motor will have to be given by the rider.

### Data
 - `track_01_simplified.gpx` file for elevation information and distance calculation
 GPS interchange file.
 `lat` latitude
 `lon` longitude
 `ele` elevation in meters [m] above sea level
