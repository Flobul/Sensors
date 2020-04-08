# Sensors

Lis les valeurs depuis les capteurs de température, de tension et de courant des iPad/iPhone.

Cet outil utilise une librairie privée qui n'est pas officielle sur iPhone/iPad : IOKit.

```
iPad:~ root# sensors test
Usage: sensors 
iPad:~ root# sensors 

IOKit Sensors Info >>


=> Current sensors (A): (25 current sensors found)
-------------------------
PMU rtc_ldo = 0.000458;
PMU ldo11 = 0.003067;
PMU lcm1 = 0.000046;
PMU ldo8 = 0.000137;
PMU buck2 = 0.000534;
PMU buck5 = 0.000000;
PMU ldo12 = 0.000366;
PMU buck1 = 0.000000;
PMU ldo5 = 0.000000;
PMU lcm2 = 0.000046;
PMU buck3 = 0.002808;
PMU ldo4 = 0.000046;
PMU ich = 0.000244;
PMU ldo9 = 0.000732;
PMU ldo3 = 0.000290;
PMU buck4 = 0.003357;
PMU vbus = 0.348038;
PMU buck0 = 2.197311;
PMU ldo2 = 0.000092;
PMU ldo6 = 0.000000;
PMU ldo10 = 0.000290;
PMU lcm3 = 0.000000;
PMU ldo1 = 0.000122;
PMU ich_avg = 0.000000;
PMU ldo7 = 0.001755;

=> Voltage sensors (V): (27 voltage sensors found)
-------------------------
PMU buck5 = 1.067505;
PMU ldo3 = 3.009033;
PMU ldo6 = 3.496094;
PMU buck4 = 1.207886;
PMU ldo2 = 1.702881;
PMU lcm3 = 0.003220;
PMU ldo10 = 2.916260;
PMU ldo1 = 2.994385;
PMU ldo7 = 3.013916;
PMU buck1 = 0.000000;
PMU rtc_ldo = 2.506104;
PMU adc_in7 = 0.001221;
PMU ldo11 = 2.607422;
PMU adc_in31 = 0.000000;
PMU buck3 = 1.809082;
PMU vbus = 4.749390;
PMU lcm1 = 0.003220;
PMU ldo8 = 2.999268;
PMU buck0 = 1.069336;
PMU ldo12 = 1.003418;
PMU vbat = 4.262695;
PMU ldo5 = 2.977295;
PMU buck2 = 0.944824;
PMU lcm2 = 0.008057;
PMU vcc_main = 4.559937;
PMU ldo4 = 3.000488;
PMU ldo9 = 1.298828;

=> Thermal sensors (°C): (30 thermal sensors found)
-------------------------
near WiFi (top side) = 20.363647;
gas gauge battery = 20.299988;
CCC Temp Sensor1 = 21.250000;
PMU tjunc = 20.719986;
CCC Temp Sensor0 = 22.937500;
PMU tbat = 18.888901;
near NAND (top side) = 19.683914;
PMGR SOC Die Temp Sensor1 = 22.234375;
PMU ldo5_temp = 21.164017;
near prox (top side) = 19.356323;
Max: CCC Temp Sensor1 = 22.265625;
PMGR SOC Die Temp Sensor0 = 21.953125;
AMC ODTS = 0.000000;
Max: CCC Temp Sensor0 = 23.953125;
near SoC (bottom side) = 19.775864;
Max: PMGR SOC Die Temp Sensor1 = 22.906250;
PMU cbuck_b_temp = 21.516754;
cool spot (top side) = 19.028748;
near RF PA (top side) = 19.379318;
Max: PMGR SOC Die Temp Sensor0 = 22.968750;
PMU buck52_temp = 20.458542;
Avg: CCC Temp Sensor1 = 20.890625;
near PMU (bottom side) = 19.729889;
Avg: CCC Temp Sensor0 = 22.781250;
PMU cbuck_a_temp = 21.340378;
near front camera (top side) = 18.888901;
Avg: PMGR SOC Die Temp Sensor1 = 22.109375;
NAND CH0 temp = 21.000000;
PMU tcal = 51.266144;
Avg: PMGR SOC Die Temp Sensor0 = 21.890625;
``` 
