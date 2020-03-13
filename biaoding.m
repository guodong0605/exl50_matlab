clear;clc;
shotnum=1016;
close all;
t1=-2;t2=10;%用于取各个物理量的平均值
step=0.01;
datatime=[num2str(t1),':',num2str(t2),':',num2str(step)];
num=1;
%%
num=1;
[ip,t]=exl50db(shotnum,'IP',datatime);
[ipf1,~]=exl50db(shotnum,'IPF1',datatime);
[ipf2,~]=exl50db(shotnum,'IPF2',datatime);
[ipf3,~]=exl50db(shotnum,'IPF3',datatime);
[ipf4,~]=exl50db(shotnum,'IPF4',datatime);
[ipf5,~]=exl50db(shotnum,'IPF5',datatime);
[ipf6,~]=exl50db(shotnum,'IPF6',datatime);
figure;stackplot({{t,ipf1,'IPF(A)'}}, [], [], [], ['PF Current'], 'Time (s)');
hold on;plot(t,ipf2,'linewidth',2.5);
hold on;plot(t,ipf3,'linewidth',2.5);
hold on;plot(t,ipf4,'linewidth',2.5);
hold on;plot(t,ipf5,'linewidth',2.5);
hold on;plot(t,ipf6,'linewidth',2.5);
l1=legend('Ipf1','Ipf2','Ipf3','Ipf4','Ipf5','Ipf6');
set(l1,'fontname', 'Times New Roman', 'FontWeight', 'normal', 'FontSize', 12);
xlim([-2,10])
mkdir('C:\Users\Lenovo\Desktop\Flux\',num2str(shotnum));
savepath=['C:\Users\Lenovo\Desktop\Flux\',num2str(shotnum),'\',[num2str(shotnum),'IPF'],'.fig'];
saveas(gcf,savepath);

figure;stackplot({{t,smooth(ip,num)/1,'$Ip(kA)$'}}, [], [], [], ['Ip'], 'Time (s)');%figure 3
savepath=['C:\Users\Lenovo\Desktop\Flux\',num2str(shotnum),'\',[num2str(shotnum),'IP'],'.fig'];
saveas(gcf,savepath);
%%
shotnum=2341;t1=-1;t2=10;
step=1/1e5;
datatime=[num2str(t1),':',num2str(t2),':',num2str(step)];
[cube,t]=exl50db(shotnum,'mp001t',datatime);
[ref,~]=exl50db(shotnum,'mp002t',datatime);
[inner,~]=exl50db(shotnum,'mp003t',datatime);
[outer,~]=exl50db(shotnum,'mp004t',datatime);

% figure;stackplot({{t,cube,'$\rm Cube(V)$'},{t,ref,'$\rm Ref(V)$'},{t,inner,'$\rm Inner(V)$'}}, [], [], [], ['Coil Current'], 'Time (s)');
figure;stackplot({{t,cube,'$\rm cube(V)$'},{t,-ref,'$\rm Ref(V)$'},{t,outer,'$\rm Outer(V)$'}}, [], [], [], ['Coil Current'], 'Time (s)');
% figure;stackplot({{t,outer./ref,'ratio'}}, [], [], [],  ['Shot',num2str(1)], 'Time (s)'); % figure 2clc
%%
%------------ITF IP 标定---------------
shotnum=2160;t1=0;t2=15;
step=1/1e3;
datatime=[num2str(t1),':',num2str(t2),':',num2str(step)];
[ip,t]=exl50db(shotnum,'ip',datatime);
[itf,~]=exl50db(shotnum,'itf',datatime);
figure;stackplot({{t,ip,'$\rm Ip(kA)$'},{t,itf,'$\rm Itf(kA)$'}}, [], [], [], ['ITF correction'], 'Time (s)');
%%
itf(5.5e3:end)=itf(5.5e3:end)-itf(5.5e3);
%%
% close all;
itf1=diff(smooth(itf));
itf2=smooth((itf1*1e3).*t(1:end-1),100);
figure;plot(itf2)
figure;plot(t(1:end-1),ip(1:end-1)-itf2/36)

%%
figure;plot((itf(5.5e3:15e3)-itf(5.5e3))./ip(5.5e3:15e3));
% figure;plot((itf(1:15e3)-itf(1))./ip(1:15e3));

figure;stackplot({{t,(itf(1:15e3)-itf(1))./ip(1:15e3),'$\rm Ip(kA)$'}}, [], [], [], ['ITF correction'], 'Time (s)');

%%
shotnum=2638;t1=0;t2=14;
step=1/1e2;
datatime=[num2str(t1),':',num2str(t2),':',num2str(step)];
[ip,t]=exl50db(shotnum,'ip03',datatime);
ip=-ip*5.84*1.12;
[itf, ~]=exl50db(shotnum,'itf',datatime);
[ipf1, tt]=exl50db(shotnum,'ipf1',datatime);
[ipf2, ~]=exl50db(shotnum,'ipf2',datatime);
[ipf3, ~]=exl50db(shotnum,'ipf3',datatime);
[ipf4, ~]=exl50db(shotnum,'ipf4',datatime);
[ipf5, ~]=exl50db(shotnum,'ipf5',datatime);
[ipf6, ~]=exl50db(shotnum,'ipf6',datatime);
% figure;stackplot({{t,ip,'$\rm Ip(kA)$'},{tt,ipf1,'$\rm Itf(kA)$'}}, [], [], [], ['ITF correction'], 'Time (s)');
% figure;stackplot({{t,(ipf1/1000)./smooth(ip,100),'$\rm Ip(kA)$'}}, [], [], [], ['IPF correction'], 'Time (s)');

figure;stackplot({{t,ip,'$\rm Ip(kA)$'}}, [], [], [], ['IP correction'], 'Time (s)');
hold on;plot(t,ip+(0.3*ipf1+0.2*ipf3+0.5*ipf5)./1e3,'r','linewidth',2);
hold on;plot(t,ip-(itf-itf(1))/36,'g','linewidth',2);
hold on;plot(t,ip+(0.3*ipf1+0.2*ipf3+0.5*ipf6)/1e3-(itf-itf(1))/36,'k','linewidth',2);
legend('Ip_m','Ip+IPF','Ip-ITF','Ip-ITF+IPF')

%%
shotnum=2464;
[y6,~]=exl50db(shotnum,'ipf3');
[y5,t]=exl50db(shotnum,'ipf4');

% [y06,~]=exl50db(shotnum,'ipf06');
% [y05,tt]=exl50db(shotnum,'ipf05');

figure;plot(t,y5,'-r');
hold on;plot(t,y6,'-k');
legend('IPF3','IPF4');
%%
figure;plot(tt,y05,'-r');
hold on;plot(tt,y06,'-k');
legend('IPF5','IPF6');
%%
shotnum=3094;
t1=0;t2=10;step=0.01;
datatime=[num2str(t1),':',num2str(t2),':',num2str(step)];
[ip,t]=exl50db(shotnum,'IP',datatime);
[ne,~]=exl50db(shotnum,'ne',datatime);
[ep,~]=exl50db(shotnum,'mir001');
[y, t1]=equilibrium(ep,1e5,0, 10, 1000, 0);

figure;set (gcf,'Position',[300,50,580,800]); % figure 1
ypic=subposition(3);
subplot('position',ypic{1});
[hax,hline1,hline2]=plotyy(t,ip,t,ne);  %----------------------------------- plotyy（1）
set(gca, 'FontWeight', 'normal', 'FontSize', 12, 'LineWidth', 1, 'XMinorTick', 'on', 'YMinorTick', 'on','ticklength',[0.01 0.01],'Xgrid','off')
title(['shot',num2str(shotnum)]);
set(hline1,'linewidth',2.5)
set(hline2,'linewidth',2.5)
ylabel(hax(1),'Ip(ka)');
ylabel(hax(2),'ne(10^{17})');
set(gca, 'XTickLabel',[])
legend({'Ip','ne'},'fontsize',16);
ylim([0,max(ip)*1.2])
setytick(gca,5)

subplot('position',ypic{2},'linewidth',2.5);             %----------------------------------- plotyy（2）
ax(2)=plot(t1,y*21); 
ylabel('Ep(V)')
set(gca, 'XTickLabel',[])
set(gca, 'FontWeight', 'normal', 'FontSize', 15, 'LineWidth', 1, 'XMinorTick', 'on', 'YMinorTick', 'on','ticklength',[0.01 0.01],'Xgrid','off')
legend({'EP'},'fontsize',12);

ylim([0,max(y*21)*1.2])
setytick(gca,5)

subplot('position',ypic{3},'linewidth',2.5);             %----------------------------------- plotyy（2）
autoSpectroscopy(ep,1e5,1024*2,0,10,1);
colorbar('off')
set(gca, 'FontWeight', 'normal', 'FontSize', 15, 'LineWidth', 1, 'XMinorTick', 'on', 'YMinorTick', 'on','ticklength',[0.01 0.01],'Xgrid','off')

%%
shotnum=3102;
[y,t]=exl50db(shotnum,'mir002');
isat=(y*101)/1e3;  figure;plot(t,isat) 
figure;plot(y,isat)
%%
shotnum=3161;
[ep01,t]=exl50db(shotnum,'ep001');
[ep02,~]=exl50db(shotnum,'ep002');
[ep03,~]=exl50db(shotnum,'ep003');
[ep04,~]=exl50db(shotnum,'ep004');
[ep05,~]=exl50db(shotnum,'ep005');
[ep06,~]=exl50db(shotnum,'ep006');
[ep07,~]=exl50db(shotnum,'ep007');
[ep08,~]=exl50db(shotnum,'ep008');
[ep09,~]=exl50db(shotnum,'ep009');
[ep10,~]=exl50db(shotnum,'ep010');
[teep,neep,tt]=getTene(ep01,ep02,ep03,0,10);
%%
t1=-2;t2=10;
step=0.01;
datatime=[num2str(t1),':',num2str(t2),':',num2str(step)];
% [flux3646,t]=exl50dbN(3646,'flux\d*',datatime);
% [flux3647,~]=exl50dbN(3647,'flux\d*',datatime);


[itf,t]=exl50db(3646,'itf',datatime);
[ipf4,t]=exl50db(3647,'ipf4',datatime);
[flux31_itf,~]=exl50db(3646,'flux032',datatime); flux31_itf=flux31_itf./100*1e3;
[flux31_ipf,~]=exl50db(3647,'flux032',datatime); flux31_ipf=flux31_ipf./100*1e3;
yy=polyfit(flux31_itf,itf,1);
yy2=polyval(yy,flux31_ipf);


%%
figure;stackplot({{flux31_ipf,yy2,'$Current$'}}, [], [], [], ['Coil vs Flux'], '$\phi(mWb)$');
hold on; plot(flux31_ipf,ipf4,'linewidth',2.5);
hold on; plot(flux31_ipf,yy2/0.320,'--k','linewidth',2.5);
legend('ITF(kA)','IPF4(A)','ITF/320(A)')

%%
figure;stackplot({{t,itf,'$\rm Itf(kA)$'},{t,flux31,'$\rm\phi(mWb)$'}}, [], [], [], ['ITF Current'], 'Time (s)');
figure;stackplot({{itf,flux31,'$\rm \phi(mWb)$'}}, [], [], [], [''], 'ITF (kA)');

%%
figure;stackplot({{t,ipf4,'$\rm IPF(A)$'},{t,flux31,'$\rm\phi(mWb)$'}}, [], [], [], ['IPF Current'], 'Time (s)');
figure;stackplot({{ipf4,flux31,'$\rm \phi(mWb)$'}}, [], [], [], [''], 'IPF (A)');

%%
figure;stackplot({{itf,flux26,'$\rm Ip(kA)$'},{ipf4,flux26,'$Phi$'}}, [], [], [], ['Coil Current'], 'Time (s)');
%%



