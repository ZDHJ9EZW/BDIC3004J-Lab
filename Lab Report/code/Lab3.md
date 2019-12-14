# Lab 3 Report - Design of the Taxi Meter

## Lab Targets

This lab will design a taxi meter. The detailed functions are following.

The initial money is 6 yuan.

When the distance is bigger than 3km, the money adds 1.2yuan every kilometre. 

When the money is bigger than 20yuan, the money of every kilometre added 50%, i.e.1.8yuna /km.

There are three states. ‘start’, ‘stop’ and ‘pause’. ‘start’ means money sets to initial state and distance increases from zero. ‘stop’ means that money return back to initial state and distance is eliminated. When the car pauses, do not count money and distance for this time.

The car has 4 different blocks of speed.

After simulations in the computer, the results ought to be showed in the hardware requirements: show the varying values in the eight 7-segments.