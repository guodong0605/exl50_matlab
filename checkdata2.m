function checkdata2(shotnum,t1,t2)
% 用于获取当前炮号对应的电磁诊断的数据
% t1 Start time  unit:Second
% t2 End   time  unit:Second
% Example: checkdata(420,-1,12);

if nargin < 1
    shotnum=currentshot();
    if shotnum<4000
    t1=0;
    t2=12;
    end
    t1=0;
    t2=4;
        
end
step=0.01;
t3=1;
t4=t2;
datatime=[num2str(t1),':',num2str(t2),':',num2str(step)];

[ipf1,t]=exl50db(shotnum,'IPF1',datatime);
[ipf2,~]=exl50db(shotnum,'IPF2',datatime);
[ipf3,~]=exl50db(shotnum,'IPF3',datatime);
[ipf4,~]=exl50db(shotnum,'IPF4',datatime);
[ipf5,~]=exl50db(shotnum,'IPF5',datatime);
[ipf6,~]=exl50db(shotnum,'IPF6',datatime);
[itf,~]=exl50db(shotnum,'ITF',datatime);

m_ipf1=abs(mean(ipf1(t3*1/step:t4*1/step)));
m_ipf2=abs(mean(ipf2(t3*1/step:t4*1/step)));
m_ipf3=abs(mean(ipf3(t3*1/step:t4*1/step)));
m_ipf4=abs(mean(ipf4(t3*1/step:t4*1/step)));
m_ipf5=abs(mean(ipf5(t3*1/step:t4*1/step)));
m_ipf6=abs(mean(ipf6(t3*1/step:t4*1/step)));
m_itf=abs(mean(itf(t3*1/step:t4*1/step)));


%-------------密度-电流------------------
[ip,t_ip]=exl50db(shotnum,'IP',datatime);
[ne,t_ne]=exl50db(shotnum,'MWI_NE001',datatime);
tt=t_ne(1:length(ne));
figure;set (gcf,'Position',[600,300,500,450]); %figure 5
[hax,hline1,hline2]=plotyy(t_ip,ip,tt,ne);
grid on;
% set(gca, 'FontWeight', 'normal', 'FontSize', 16, 'LineWidth', 2, 'XMinorTick', 'on', 'YMinorTick', 'on','ticklength',[0.02 0.02],'Xgrid','off')
title('Ip&ne');
set(hline1,'linewidth',2.5)
set(hline2,'linewidth',2.5)
ylabel(hax(1),'Ip(ka)');
ylabel(hax(2),'ne(10^{17})');
try
m_ne=abs(mean(ne(t3*1/step:t4*1/step)));
catch
m_ne=0;    
end
ip_max=max(smooth(ip(1*1/step:11*1/step),100));

%-------------------微波功率-------------------------------
%%
[m1_pin,t]=exl50db(shotnum,'m1_pin',datatime);
[m2_pin,~]=exl50db(shotnum,'m2_pin',datatime);
[m1_pout,~]=exl50db(shotnum,'m1_pout',datatime);
[m2_pout,~]=exl50db(shotnum,'m2_pout',datatime);
[m3_pin,~]=exl50db(shotnum,'m3_pin',datatime);
% m3_pin=m3_pin.*1e2;
figure;set (gcf,'Position',[1100,300,500,450]);% figure 6
stackplot({{t,m1_pin-m1_pout,'$P_{ECRH}$'}}, [], [], [],  ['Shot',num2str(shotnum)], 'Time (s)');%figure 6
grid on;
hold on;plot(t,m2_pin-m2_pout,'r','linewidth',2.5);
hold on;plot(t,m3_pin,'g','linewidth',2.5);
legend('M1','M2','M3')
m1_in=abs(mean(m1_pin(t3*1/step:t4*1/step)));
m1_out=abs(mean(m1_pout(t3*1/step:t4*1/step)));
m2_in=abs(mean(m2_pin(t3*1/step:t4*1/step)));
m2_out=abs(mean(m1_pout(t3*1/step:t4*1/step)));
m1_p=m1_in-m1_out;
m2_p=m2_in-m2_out;
m3_p=abs(mean(m3_pin(t3*1/step:t4*1/step)));
%%
%-------------------------------------------------
filename = 'C:\Users\Lenovo\Desktop\data.xlsx';
data=[shotnum,ip_max,m_ne,m1_p,m2_p,m3_p,m_itf,m_ipf1,m_ipf2,m_ipf3,m_ipf4,m_ipf5,m_ipf6];
sheet = 1;
xlRange = ['A',num2str(shotnum)];
xlswrite(filename,data,sheet,xlRange)

end