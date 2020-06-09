clc
clear all
%加载数据
A=xlsread('GFSJy.xlsx','原始数据','B13887:N14606');
%随机打乱数据
A(find(A(:,1)==0),:)=[];
B = A(1:450,:);
C = A(451:end,:);
n = randperm(size(B,1));
tr=B(n(1:430),:);
te=B(n(431:end),:);
X_tr=tr(:,2:end);
Y_tr=tr(:,1);
X_te=te(:,2:end);
Y_te=te(:,1);
X_test=C(:,2:end);
Y_test=C(:,1);
%% RF训练
%RF训练集
model = regRF_train(X_tr,Y_tr,400,7);
%RF辅助集
Y_hat = regRF_predict(X_te,model);
%RF测试集
Y = regRF_predict(X_test,model);
%辅助集统计指标mse和mae
mse1 = sum((Y_hat-Y_te).^2)./16;
mae1 = sum(abs(Y_hat-Y_te))/16;
disp( ['MSE1 = ', num2str( mse1 )] );
disp( ['MAE1 = ', num2str( mae1 )] );
%绘图
figure(1);
plot(Y_te, 'color', [0,0.75,0] );
hold on;
plot(Y_hat, 'b' );
hold off;
axis tight;
title('辅助集预测结果');
legend('目标值', '辅助集预测值');
ylabel('功率值/W')
xlabel('时刻/h')
%测试集统计指标mse和mae
mse2 = sum((Y_test-Y).^2)./16;
mae2 = sum(abs(Y_test-Y))/16;
disp( ['MSE2 = ', num2str( mse2 )] );
disp( ['MAE2 = ', num2str( mae2 )] );
%绘图
figure(2);
plot(Y, 'color', [0,0.75,0] );
hold on;
plot(Y_test, 'b' );
hold off;
axis tight;
title('测试集预测结果');
legend('测试集预测值','目标值');
ylabel('功率值/W')
xlabel('时刻/h')