clc;
clear all;
close all;
format long g;


[Year] = xlsread('SolarData','Worksheet','E1:E8760');
January = zeros(24,1);
February = zeros(24,1);
March = zeros(24,1);
April = zeros(24,1);
May = zeros(24,1);
June = zeros(24,1);
July = zeros(24,1);
August = zeros(24,1);
September = zeros(24,1);
October = zeros(24,1);
November = zeros(24,1);
December = zeros(24,1);

hour=transpose(1:24);

for k=1:1:24
    
    
for i=k:24:744
    
    January(k) = January(k)+ Year(i);
    
end

for i=744+k:24:1416
    
    February(k) = February(k)+ Year(i);
    
end
for i=1416+k:24:2160
    
    March(k) = March(k)+ Year(i);
    
end
for i=2160+k:24:2856
    
    April(k) = April(k)+ Year(i);
    
end
for i=2856+k:24:3624
    
    May(k) = May(k)+ Year(i);
    
end
for i=3624+k:24:4344
    
    June(k) = June(k)+ Year(i);
    
end
for i=4344+k:24:5088
    
    July(k) = July(k)+ Year(i);
    
end
for i=5088+k:24:5832
    
    August(k) = August(k)+ Year(i);
    
end
for i=5832+k:24:6552
    
    September(k) = September(k)+ Year(i);
    
end
for i=6552+k:24:7296
    
    October(k) = October(k)+ Year(i);
    
end
for i=7296+k:24:8016
    
    November(k) = November(k)+ Year(i);
    
end
for i=8016+k:24:8760
    
    December(k) = December(k)+ Year(i);
    
end
end

January=January./31;
February=February./28;
March=March./31;
April=April./30;
May=May./31;
June=June./30;
July=July./31;
August=August./31;
September=September./30;
October=October./31;
November=November./30;
December=December./31;

figure; hold on; 
x=subplot(2,2,1);
plot(hour,January, hour, February, hour, March);
legend('January','February','March')
axis([0 24 0 1000])
xlabel('Hour')
ylabel('W/m^2')
grid on


x2=subplot(2,2,2);
plot(hour, April,hour, May, hour, June);
legend('April','May','June')
axis([0 24 0 1000])
xlabel('Hour')
ylabel('W/m^2')
grid on

x3=subplot(2,2,3);
plot(hour,July, hour, August, hour, September);
legend('July','August','September')
axis([0 24 0 1000])
xlabel('Hour')
ylabel('W/m^2')
grid on

x4=subplot(2,2,4);
plot(hour, October, hour, November, hour, December);
legend('October','November','December')
axis([0 24 0 1000])
xlabel('Hour')
ylabel('W/m^2')
grid on