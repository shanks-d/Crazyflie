# Crazyflie
31390

Steps to setup your crazyflie with the workstation are given in this link
http://rsewiki.elektro.dtu.dk/index.php/UASTA

aliases used are:
cfstart () {
  roslaunch crazyflie_demo uas_31390_crazyflie_server.launch channel:=$1
}

optitrack () {
  roslaunch crazyflie_demo optitrack.launch marker:=$1
}


Here's some instructions to retrieve the positions and directions of the hoops:

Clone the repository:
git clone https://github.com/DavidWuthier/uas-demo-day.git

Start optitrack (the identifier of the drone doesn't matter):
optitrack 1

and run the MATLAB script uas_get_hoops.m

You should be able to retrieve the positions p_h1, ..., p_h4 and the unit vectors u_h1, ..., u_h4 as their orientations.