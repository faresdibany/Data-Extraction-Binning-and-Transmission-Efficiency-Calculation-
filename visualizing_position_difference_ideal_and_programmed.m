%this code is to import all fitting coefficients of all midia groups, and
%calculate the difference in values between fitted m/z and isolation m/z,
%and visualizes the differences and the consistency of the differences. 

x = readtable('fitting coefficients midia 8.csv');
x1 = readtable('fitting coefficients midia 9.csv');
x2 = readtable('fitting coefficients midia 10.csv');
x3 = readtable('fitting coefficients midia 11.csv');
x4 = readtable('fitting coefficients midia 12.csv');
x5 = readtable('fitting coefficients midia 13.csv');
x6 = readtable('fitting coefficients midia 14.csv');
x7 = readtable('fitting coefficients midia 15.csv');
x8 = readtable('fitting coefficients midia 16.csv');
x9 = readtable('fitting coefficients midia 17.csv');



x.Var1 = [];
x1.Var1 = [];
x2.Var1 = [];
x3.Var1 = [];
x4.Var1 = [];
x5.Var1 = [];
x6.Var1 = [];
x7.Var1 = [];
x8.Var1 = [];
x9.Var1 = [];

left_x = table2array(x(3,:));
isol_x = table2array(x(2,:));
right_x = table2array(x(5,:));

left_x1 = table2array(x1(3,:));
isol_x1 = table2array(x1(2,:));
right_x1 = table2array(x1(5,:));

left_x2 = table2array(x2(3,:));
isol_x2 = table2array(x2(2,:));
right_x2 = table2array(x2(5,:));

left_x3 = table2array(x3(3,:));
isol_x3 = table2array(x3(2,:));
right_x3 = table2array(x3(5,:));

left_x4 = table2array(x4(3,:));
isol_x4 = table2array(x4(2,:));
right_x4 = table2array(x4(5,:));

left_x5 = table2array(x5(3,:));
isol_x5 = table2array(x5(2,:));
right_x5 = table2array(x5(5,:));

left_x6 = table2array(x6(3,:));
isol_x6 = table2array(x6(2,:));
right_x6 = table2array(x6(5,:));

left_x7 = table2array(x7(3,:));
isol_x7 = table2array(x7(2,:));
right_x7 = table2array(x7(5,:));

left_x8 = table2array(x8(3,:));
isol_x8 = table2array(x8(2,:));
right_x8 = table2array(x8(5,:));

left_x9 = table2array(x9(3,:));
isol_x9 = table2array(x9(2,:));
right_x9 = table2array(x9(5,:));

%calculate the difference between left and right positions and isolation m/z for each
%midia group
posdiffLeftX = left_x - isol_x;
possdiffRightX = right_x - isol_x;

posdiffLeftX1 = left_x1 - isol_x1;
possdiffRightX1 = right_x1 - isol_x1;

posdiffLeftX2 = left_x2 - isol_x2;
possdiffRightX2 = right_x2 - isol_x2;

posdiffLeftX3 = left_x3 - isol_x3;
possdiffRightX3 = right_x3 - isol_x3;

posdiffLeftX4 = left_x4 - isol_x4;
possdiffRightX4 = right_x4 - isol_x4;

posdiffLeftX5 = left_x5 - isol_x5;
possdiffRightX5 = right_x5 - isol_x5;

posdiffLeftX6 = left_x6 - isol_x6;
possdiffRightX6 = right_x6 - isol_x6;

posdiffLeftX7 = left_x7 - isol_x7;
possdiffRightX7 = right_x7 - isol_x7;

posdiffLeftX8 = left_x8 - isol_x8;
possdiffRightX8 = right_x8 - isol_x8;

posdiffLeftX9 = left_x9 - isol_x9;
possdiffRightX9 = right_x9 - isol_x9;

%calculates the standard deviation of the differences 
stdLeftX = std(posdiffLeftX);
stdLeftX1 = std(posdiffLeftX1);
stdLeftX2 = std(posdiffLeftX2);
stdLeftX3 = std(posdiffLeftX3);
stdLeftX4 = std(posdiffLeftX4);
stdLeftX5 = std(posdiffLeftX5);
stdLeftX6 = std(posdiffLeftX6);
stdLeftX7 = std(posdiffLeftX7);
stdLeftX8 = std(posdiffLeftX8);
stdLeftX9 = std(posdiffLeftX9);


stdRightX = std(possdiffRightX);
stdRightX1 = std(possdiffRightX1);
stdRightX2 = std(possdiffRightX2);
stdRightX3 = std(possdiffRightX3);
stdRightX4 = std(possdiffRightX4);
stdRightX5 = std(possdiffRightX5);
stdRightX6 = std(possdiffRightX6);
stdRightX7 = std(possdiffRightX7);
stdRightX8 = std(possdiffRightX8);
stdRightX9 = std(possdiffRightX9);

%calculates the mean of the differences 
meanLeftX = mean(posdiffLeftX);
meanLeftX1 = mean(posdiffLeftX1);
meanLeftX2 = mean(posdiffLeftX2);
meanLeftX3 = mean(posdiffLeftX3);
meanLeftX4 = mean(posdiffLeftX4);
meanLeftX5 = mean(posdiffLeftX5);
meanLeftX6 = mean(posdiffLeftX6);
meanLeftX7 = mean(posdiffLeftX7);
meanLeftX8 = mean(posdiffLeftX8);
meanLeftX9 = mean(posdiffLeftX9);

meanRightX = mean(possdiffRightX);
meanRightX1 = mean(possdiffRightX1);
meanRightX2 = mean(possdiffRightX2);
meanRightX3 = mean(possdiffRightX3);
meanRightX4 = mean(possdiffRightX4);
meanRightX5 = mean(possdiffRightX5);
meanRightX6 = mean(possdiffRightX6);
meanRightX7 = mean(possdiffRightX7);
meanRightX8 = mean(possdiffRightX8);
meanRightX9 = mean(possdiffRightX9);

%plotting of the difference of the left and right positions, with respect
%to the isolation m/z value, to monitor the influence of m/z range to the
%difference between fitted and programmed values. 
sz = 30;
figure()
scatter(isol_x,posdiffLeftX,sz,'o')
hold on 
scatter(isol_x,posdiffLeftX,sz,'+')
hold on 
scatter(isol_x1,posdiffLeftX1,sz,'x')
hold on
scatter(isol_x2,posdiffLeftX2,sz,'*')
hold on
scatter(isol_x3,posdiffLeftX3,sz,'.')
hold on
scatter(isol_x4,posdiffLeftX4,sz,'o')
hold on
scatter(isol_x5,posdiffLeftX5,sz,'s')
hold on
scatter(isol_x6,posdiffLeftX6,sz,'d')
hold on
scatter(isol_x7,posdiffLeftX7,sz,'^')
hold on 
scatter(isol_x8,posdiffLeftX8,sz,'>')
hold on 
scatter(isol_x9,posdiffLeftX9,sz,'<')
hold off 
xlabel('Isolation Mz')
ylabel('Left Position - Isolation M/Z')
legend('MIDIA 8','MIDIA 9','MIDIA 10','MIDIA 11','MIDIA 12','MIDIA 13','MIDIA 14','MIDIA 15','MIDIA 16','MIDIA 17')


figure()
scatter(isol_x,possdiffRightX,sz,'o')
hold on 
scatter(isol_x1,possdiffRightX1,sz,'+')
hold on 
scatter(isol_x2,possdiffRightX2,sz,'x')
hold on 
scatter(isol_x3,possdiffRightX3,sz,'v')
hold on 
scatter(isol_x4,possdiffRightX4,sz,'^')
hold on 
scatter(isol_x5,possdiffRightX5,sz,'>')
hold on 
scatter(isol_x6,possdiffRightX6,sz,'<')
hold on 
scatter(isol_x7,possdiffRightX7,sz,'*')
hold on 
scatter(isol_x8,possdiffRightX8,sz,'p')
hold on
scatter(isol_x9,possdiffRightX9,sz,'h')
hold off 
xlabel('Isolation Mz')
ylabel('Right Position - Isolation M/Z')
legend('MIDIA 8','MIDIA 9','MIDIA 10','MIDIA 11','MIDIA 12','MIDIA 13','MIDIA 14','MIDIA 15','MIDIA 16','MIDIA 17')




%this is to plot the standard deviation and the mean of each difference in
%position value for each midia group 

% errbar = [stdLeftX; stdLeftX1; stdLeftX2; stdLeftX3; stdLeftX4; stdLeftX5;...
%     stdLeftX6; stdLeftX7; stdLeftX8; stdLeftX9];
% r = 1:10;
% names = ["Midia 8", "Midia 9","Midia 10","Midia 11","Midia 12","Midia 13","Midia 14","Midia 15", "Midia 16","Midia 17"]
% y = [meanLeftX' meanLeftX1' meanLeftX2' meanLeftX3'...
%     meanLeftX4' meanLeftX5' meanLeftX6' meanLeftX7' meanLeftX8' meanLeftX9']
% figure()
% hb = bar(r,y)
% set(gca,'xticklabel',names)    
% legend('Mean and Standard Deviation of Left Position - Isolation Mz')
% hold on 
% er = errorbar(r,y,errbar);
% hold off 
% 
% 
% errbar1 = [stdRightX; stdRightX1; stdRightX2; stdRightX3; stdRightX4; stdRightX5;...
%     stdRightX6; stdRightX7; stdRightX8; stdRightX9];
% r1 = 1:10;
% names = ["Midia 8", "Midia 9","Midia 10","Midia 11","Midia 12","Midia 13","Midia 14","Midia 15", "Midia 16","Midia 17"]
% y1 = [meanRightX' meanRightX1' meanRightX2' meanRightX3'...
%     meanRightX4' meanRightX5' meanRightX6' meanRightX7' meanRightX8' meanRightX9']
% figure()
% hb1 = bar(r1,y1)
% set(gca,'xticklabel',names)    
% legend('Mean and Standard Deviation of Left Position - Isolation Mz')
% hold on 
% er1 = errorbar(r1,y1,errbar1);
% hold off 
% % hold on 
% % for k1 = 1:10
% %     errorbar(errbar(k1,:) ,'.k', 'LineWidth',2)
% % end
% % hold off 