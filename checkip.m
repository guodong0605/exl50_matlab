function checkip(shotnum,t1,t2)
step=1/1000;
datatime=[num2str(t1),':',num2str(t2),':',num2str(step)];
[itf,~]=exl50db(shotnum,'itf',datatime);
[ip01,t]=exl50db(shotnum,'IP01',datatime);
[ip02,~]=exl50db(shotnum,'IP02',datatime);
[ip03,~]=exl50db(shotnum,'IP03',datatime);
[ip04,~]=exl50db(shotnum,'IP04',datatime);
% k1=(ip01((t2-t1)*100)-ip01((0-t1)*100))/(t2-t1);x1=k1*[t1:0.01:t2]+ip01((0-t1)*100);
% k2=(ip02((t2-t1)*100)-ip02((0-t1)*100))/(t2-t1);x2=k2*[t1:0.01:t2]+ip02((0-t1)*100);
% k3=(ip03((t2-t1)*100)-ip03((0-t1)*100))/(t2-t1);x3=k3*[t1:0.01:t2]+ip03((0-t1)*100);
% k4=(ip04((t2-t1)*100)-ip04((0-t1)*100))/(t2-t1);x4=k4*[t1:0.01:t2]+ip04((0-t1)*100);
figure;set (gcf,'Position',[500,0,550,450]);
stackplot({{t,6.54*ip01+itf/4.86,'IP(kA)'}}, [], [], [],  ['Shot',num2str(shotnum)], 'Time (s)'); % figure 2
hold on;plot(t,-4.8*ip02+itf/25,'linewidth',2.5);
hold on;plot(t,-6.7*ip03-itf/42,'linewidth',2.5);
hold on;plot(t,-12.25*ip04-itf/3.48,'linewidth',2.5);
grid on;
legend('IP01','IP02','IP03','IP04')