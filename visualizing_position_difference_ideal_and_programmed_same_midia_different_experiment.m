%this script is to visualize the consistency in position difference of
%midia groups with same isolation m/z for different experiments 

x = readtable('fitting coefficients midia 117.csv');
x1 = readtable('fitting coefficients midia 11.csv');
x2 = readtable('fitting coefficients midia 12.csv');
x3 = readtable('fitting coefficients midia 127.csv');

x.Var1 = [];
x1.Var1 = [];
x2.Var1 = [];
x3.Var1 = [];

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


posdiffLeftX = left_x - isol_x;
possdiffRightX = right_x - isol_x;

posdiffLeftX1 = left_x1 - isol_x1;
possdiffRightX1 = right_x1 - isol_x1;

posdiffLeftX2 = left_x2 - isol_x2;
possdiffRightX2 = right_x2 - isol_x2;

posdiffLeftX3 = left_x3 - isol_x3;
possdiffRightX3 = right_x3 - isol_x3; 


sz = 30;
figure()
scatter(isol_x,posdiffLeftX,sz,'o')
hold on 
scatter(isol_x1,posdiffLeftX1,sz,'x')
hold on
scatter(isol_x2,posdiffLeftX2,sz,'*')
hold on
scatter(isol_x3,posdiffLeftX3,sz,'.')
hold off 
xlabel('Isolation Mz')
ylabel('Left Position - Isolation M/Z')
legend('MIDIA 11 519_007','MIDIA 11 519_008','MIDIA 12 519_008','MIDIA 12 519_007')


figure()
scatter(isol_x,possdiffRightX,sz,'o')
hold on 
scatter(isol_x1,possdiffRightX1,sz,'+')
hold on 
scatter(isol_x2,possdiffRightX2,sz,'x')
hold on 
scatter(isol_x3,possdiffRightX3,sz,'v')
hold off 
xlabel('Isolation Mz')
ylabel('Right Position - Isolation M/Z')
legend('MIDIA 11 519_007','MIDIA 11 519_008','MIDIA 12 519_008','MIDIA 12 519_007')