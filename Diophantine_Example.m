%% Coded by
% Mohamed Mohamed El-Sayed Atyya
% mohamed.atyya94@eng-st.cu.edu.eg
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all; clear all; clc;
%% Plant input
A=[1  -1.846  0.8187];
B=[0.06762  0.113];
d=2;
%% Required Poles
Am_poles=[0.5 0.6];
A0_poles=[0.2 0.2];
%% Diophantine Solution
[ S, R ] = Diophantine ( A, B, d, Am_poles, A0_poles );
%% Plotting
% plant
Gp=tf(B,A,0.2);
figure(1)
step(Gp,30)
set(gcf,'color','w')
% closed loop
Gc=tf(S,R,0.2);
Gcl=feedback(Gp*Gc,1);
figure(2)
step(Gcl,30)
set(gcf,'color','w')