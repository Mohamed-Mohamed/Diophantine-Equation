function [ S, R ] = Diophantine ( A, B, d, Am_poles, A0_poles )
%% Coded by
% Mohamed Mohamed El-Sayed Atyya
% mohamed.atyya94@eng-st.cu.edu.eg
%%  Function Objective
% This function is used to solve Diophantine Equation :
%                          A * R + z^(-d) * B * S
% To get the controller polynomials S and R
%
% The plant tansfer function :
%                                                z^(-d) B(z^-1)
%                       Gp(z^-1)  =  --------------------------
%                                                     A(z^-1)
%
% The controller tansfer function :
%                                                   S(z^-1)
%                       Gc(z^-1)  =  --------------------------
%                                                   R(z^-1)
%% Inputs
% A                  : the coefficients of the denominator of Gp
% B                  : the coefficients of the numerator of Gp
% d                   : delay of Gp
% Am_poles   : closed loop required poles
% A0_poles    : observer poles
%% Outputs
% S                  : the coefficients of the numerator of Gc
% R                  :  the coefficients of the denominator of Gc
%% Function Body
% orders
na=length(A)-1;
nb=length(B)-1;
nr=nb+d-1;
ns=na-1;
nalpha=na+nb+d-1;
a0=A(1);
A=A/a0;
B=B/a0;
if nalpha == length(Am_poles)+length(A0_poles)
        % Am
        Am=1;
        for i=1:length(Am_poles)
                Am=conv(Am,[1,-Am_poles(i)]);
        end
        % A0
        A0=1;
        for i=1:length(A0_poles)
                if i <=  nalpha-length(Am_poles)
                        A0=conv(A0,[1,-A0_poles(i)]);
                end
        end
        % AmA0
        Am0=conv(Am,A0);
        % Diophantine
        D=zeros(nalpha,nalpha);
        for i=1:nr
                D(i:length(A)+i-1,i)=A';
        end
        for i=1:nalpha-nr
                D(d+i-1:nb+d+i-1,nr+i)=B';
        end
        alpha=Am0(2:end)';
        a=zeros(1,nalpha);
        a(1:na)=A(2:end);
        I=alpha-a';
        RS=inv(D)*I;
        R=[1, RS(1:nr)'];
        S=RS(nr+1:end)';
else
        if nalpha > length(Am_poles)+length(A0_poles)
                display('The Required Closed Loop Poles is not Enough')
        elseif nalpha < length(Am_poles)+length(A0_poles)
                display('The Required Closed Loop Poles is excess')
        end
end
end