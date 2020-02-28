clc;
clear all;
close all;
format long g;


[Year] = xlsread('Matlab Midelt','Sheet1','E2:E8761');
Year1=zeros(24,1);
hour=transpose(1:24);
Demand=529;

for k=1:1:24
    
    
for i=k:24:8760
    
    Year1(k) = Year1(k)+ Year(i);

end
end 
Year1=Year1./356;

figure; hold on; 

plot(hour, Year1)

Supply=sum(Year1)
Demand=529*17
grid on
title('Average Thermal output each hour')
xlabel('Hour of the day')
ylabel('Thermal output MW')








% Energy=0;
% Under=0;
% Over=0;
% Daily_mean=627;

% for a=1:24
%     if Year1(a)<Daily_mean
%         Under=Under+(Daily_mean-Year1(a));
%     else 
%         Over=Over+(Year1(a)-Daily_mean);
%     end
%     
%     Energy=Energy+Year1(a);
%     
% end
% 
% Under 
% Over