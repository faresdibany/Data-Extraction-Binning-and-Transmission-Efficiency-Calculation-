%This code is to import the transmission efficiency of each Midia group of
%an experiment. After importing it, the intensities of every scan is taken
%as real data, to be fitted against, where we then compare fitted data to
%real data, with the goal of extracting the ideal m/z range of each scan,
%and monitor the offset between it and the programmed values. 

clc;    % Clear the command window.
close all;  % Close all figures (except those of imtool.)
clear;  % Erase all existing variables. Or clearvars if you want.
workspace;  % Make sure the workspace panel is showing.
format long g;
format compact;
fontSize = 20;

%extracting the isolation m/z for each midia group
D = readtable('DiaFrameMsMsWindows.csv');
%finding the midia group 11
qq = find(D.WindowGroup == 11);
D = D(qq,:);
isol = D.IsolationMz;
isol(end) = [];

%here it is seen that the efficiency file is called the median, as for this
%experiment, the median was needed, as there was imminent scarcity in
%intensities. For good fitting, one must decrease the amount of zeros in
%the real data as possible.
ef = readtable('median ef11.csv');
% ef(1:3,:) = [];
% ef(:,1) = [];
% ef(:,451:end) = [];
% ef = str2double(ef);

ef = table2array(ef);
% ef = table2array(ef);

%creating the mass range, and putting it next to the efficiency matrix, to
%know where each signal is, with respect to the mass range 
mass = [50:0.126:1700]';
eff = horzcat(mass,ef);
mas = eff(:,1);

%getting real data for each scan, in this case from 40 to 450
for i =40:450;
    y{i} = ef(:,i)
end 
% Y = y{330};
% rf = find(Y==0);

% yy = nonzeros(Y);
% uu = ismember(Y,yy);
% uuu = find(uu==1);
% Y = Y(uuu);

%initializing empty cell arrays to be filled with the loop below 
yf = cell(1,450);
coef = cell(1,450);
yf1 = cell(1,450);
coef1 = cell(1,450);
corr1 = cell(1,450);
corr = cell(1,450);
combined = cell(450,1);
correl = cell(1,450);
indices = cell(1,450);
xx = cell(1,450);
ind = cell(1,450);

%running a loop, where k represents the scans from 280 to 410. 
for k = 280:410;
    %Y is real data for each scan
    Y = y{k};
    %xdata is the whole mass range 
    xdata = mas;
    
    zer = find(Y==0);
   
    xx{k} = xdata;
    
%     indices{k} = [ind_max ind_min];
    %creating the objective function, where xdata is the mass value, b(1)
    %is the mass point for the transmission curve to begin, and b(2) is the
    %left edge of the curve's width 
    hyprb = @(b,x) (0.5.*(1+tanh(((xdata-b(1)))/(2.*b(2)))))
    %initial parameter value guess, b(1) and b(2) 
    B0 = [isol(k)-11, 0.7];
    %lower bounds of the parameters 
    lb = [isol(k)-20,0.5];
    %upper bounds of the parameters
    ub = [isol(k)+6,2];
    %fitting the objective function to the measured data, with the
    %parameter conditions 
    x = lsqcurvefit(hyprb,B0,xdata,Y,lb,ub)
    
    %saving the parameter values, from equation x, into the coef cell array
    coef{k} = x;
    %creating the fitted array, with the parameter values, produced from
    %the best fit 
    yfit = ((0.5.*(1+tanh(((xdata-x(1))/(2.*x(2)))))));
    yf{k} = yfit;
    
    %repeating the same process, for the right edge of the transmission
    %curve
    hyprb1 = @(d,x) (1-(0.5.*(1+tanh((xdata-(d(1)))/(2.*d(2))))));
    %initial guesses differ from left edge, as one takes into account the
    %curve width, in m/z values 
    B10 = [isol(k)+26,1.6];
    lb1 = [isol(k)+10,0.5];
    ub1 = [isol(k)+30,2];
    x1 = lsqcurvefit(hyprb1,B10,xdata,Y,lb1,ub1)
    
    coef1{k} = x1;
    yfit1 = (1-(0.5.*(1+tanh(((xdata-x1(1))/(2.*x1(2)))))));
    yf1{k} = yfit1;
    
    %multiplying the fitted edges, to acquire the whole curve, if a
    %comparision between it and the real curve is needed 
    combined{k} = yf{k}.*yf1{k};
    combe = combined{k};
    ind{k} = find(combe~=0);
    
    %calculating the correlation between the left edge and the right edge and
    %the whole curve,and the real data only for efficiency between 2 and 98%, as it is most
    %relevant. 
    w = find(yfit(:)<=0.98 & yfit(:)>=0.02);
    w1 = find(yfit1(:)<=0.98& yfit1(:)>=0.02);
    w2 = find(combined{k}(:)<=0.98 & combined{k}(:) >=0.02);
    simulated = yfit(w);
    real = Y(w);
    real1 = Y(w1);
    simulated1 = yfit1(w1);
    simulated2 = combined{k}(w2);
    real2 = Y(w2);
    cor = corrcoef(simulated,real);
    cor1 = corrcoef(simulated1,real1);
    cor2 = corrcoef(simulated2,real2);
    correl{k} = [cor(1,2); cor1(1,2); cor2(1,2)];
end 

for wq = 280:410;
    ww(:,wq) = combined{wq,1};
end 
% save combined18.mat combined
% coefficient_matrix = cell(1,450);
%combining all coefficients in one matrix
for ii = 280:410;
    coefficient = [coef{1,ii}(1,1);coef{1,ii}(1,2);coef1{1,ii}(1,1);coef1{1,ii}(1,2);correl{ii}];
    coefficient_matrix(1:7,ii) = coefficient;
end 

coefficient_matrix = coefficient_matrix(:,280:410);
%adding names for the rows of the coefficient matrix 
names = ["Scans";"Isolation Mz";"Left Mass";"Left Width";"Right Mass";"Right Width";"Left Local Correlation";"Right Local Correlation";"Combined Local Correlation"];
s = [280:410];
isolation = isol(280:410)';
parameter_values = [s;isolation;coefficient_matrix];
final_matrix = [names parameter_values];

%writing matrix and saving it as csv
% writematrix(final_matrix,'fitting coefficients midia 18.csv');

%testing the fitting, before saving it 
cc = y{330};
ccc = combined{330};

figure()
plot(ccc)

figure()
plot(cc)


wqw = find(ww<=0.01);
ww(wqw)=0;
ww(:,411:450) = 0;


ef(:,1:279) = 0;
figure()
mesh(ww)

figure()
mesh(ef)