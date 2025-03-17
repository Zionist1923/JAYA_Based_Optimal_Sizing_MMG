%___________________________________________________________________%
%  JAYA source codes version 1.0                                    %
%                                                                   %
%  Developed in MATLAB R2022b                                       %
%                                                                   %
%  Author and programmer: Dessalegn Bitew                           %
%                                                                   %
%         e-Mail: dessalegnbitew29@gmail.com                        %
%                 dessalegn_bitew@dmu.edu.et                        %
%                                                                   %
%Homepage: https://scholar.google.com/citations?user=I8TKyFUAAAAJ&hl=en %
%                                                                   %
%   Main paper: Aeggegn, Dessalegn Bitew, George Nyauma Nyakoe, and %
% Cyrus Wekesa. "Optimal sizing of grid connected multi-microgrid   %
% system using grey wolf optimization." Results in Engineering 23   %
% (2024): 102421.,                                                  %
%     DOI: https://doi.org/10.1016/j.rineng.2024.102421             %
%                                                                   %
%___________________________________________________________________%


%% JAYA algorithms
clc
clear all
close all

%% Problem Definition

pop = 100;               % Population size
var = 6;                 % Number of design variables
maxGen = 300;            % Maximum number of iterations
mini = [0 0 0 0 0 0];  % Lower Bound of Variables
maxi = [30e6 30e6 300e6 300e6 3e6 300e6];   % Upper Bound of Variables
objective = @function_single;      % Cost Function
 
%% initialize
[row,var] = size(mini);
x = zeros(pop,var);
fnew = zeros(pop,1);
f = zeros(pop,1);
fopt= zeros(pop,1);
xopt=zeros(1,var);

%%  Generation and Initialize the positions 
for i=1:var
    x(:,i) = mini(i)+(maxi(i)-mini(i))*rand(pop,1);
end

for i=1:pop
    f(i) = objective(x(i,:));
end

%%  Main Loop
gen=1;
while(gen <= maxGen)

    [row,col]=size(x);
    [t,tindex]=min(f);
    Best=x(tindex,:);
    [w,windex]=max(f);
    worst=x(windex,:);
    xnew=zeros(row,col);
    
    for i=1:row
        for j=1:col
            xnew(i,j)=(x(i,j))+rand*(Best(j)-abs(x(i,j))) - (worst(j)-abs(x(i,j)));  % 
        end
    end 
    
    for i=1:row
        xnew(i,:) = max(min(xnew(i,:),maxi),mini);   
        fnew(i,:) = objective(xnew(i,:));
    end
    
    for i=1:pop
        if(fnew(i)<f(i))
            x(i,:) = xnew(i,:);
            f(i) = fnew(i);
        end
    end

    fnew = []; xnew = [];
    [fopt(gen),ind] = min(f);
    xopt(gen,:)= x(ind,:);
    gen = gen+1;  
    disp(['Iteration No. = ',num2str(gen), ',   Best Cost = ',num2str(min(f))])
    
end

%% 
writematrix(fopt,'JayaN1.xls');
writematrix(xopt,'BestJayaN1`.xls');
[val,ind] = min(fopt);
Fes = pop*ind;
disp(['Optimum value = ',num2str(val,10)])



 figure(1)
 semilogy(fopt,'linewid',2)
 xlabel('Itteration')
 ylabel('Best Cost');
 legend('JAYA')
 disp(' ' )

