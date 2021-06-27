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