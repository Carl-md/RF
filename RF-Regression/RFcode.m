clc
clear all
%��������
A=xlsread('GFSJy.xlsx','ԭʼ����','B13887:N14606');
%�����������
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
%% RFѵ��
%RFѵ����
model = regRF_train(X_tr,Y_tr,400,7);
%RF������
Y_hat = regRF_predict(X_te,model);
%RF���Լ�
Y = regRF_predict(X_test,model);
%������ͳ��ָ��mse��mae
mse1 = sum((Y_hat-Y_te).^2)./16;
mae1 = sum(abs(Y_hat-Y_te))/16;
disp( ['MSE1 = ', num2str( mse1 )] );
disp( ['MAE1 = ', num2str( mae1 )] );
%��ͼ
figure(1);
plot(Y_te, 'color', [0,0.75,0] );
hold on;
plot(Y_hat, 'b' );
hold off;
axis tight;
title('������Ԥ����');
legend('Ŀ��ֵ', '������Ԥ��ֵ');
ylabel('����ֵ/W')
xlabel('ʱ��/h')
%���Լ�ͳ��ָ��mse��mae
mse2 = sum((Y_test-Y).^2)./16;
mae2 = sum(abs(Y_test-Y))/16;
disp( ['MSE2 = ', num2str( mse2 )] );
disp( ['MAE2 = ', num2str( mae2 )] );
%��ͼ
figure(2);
plot(Y, 'color', [0,0.75,0] );
hold on;
plot(Y_test, 'b' );
hold off;
axis tight;
title('���Լ�Ԥ����');
legend('���Լ�Ԥ��ֵ','Ŀ��ֵ');
ylabel('����ֵ/W')
xlabel('ʱ��/h')