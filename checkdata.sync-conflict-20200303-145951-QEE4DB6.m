function checkdata(shotnum,t1,t2)
% 用于获取当前炮号对应的电磁诊断的数据
% t1 Start time  unit:Second
% t2 End   time  unit:Second
% Example: checkdata(420,-1,12);
close all;
t3=3;t4=8;%用于取各个物理量的平均值
step=0.01;
%%----------------save data of basic discharge parameter--------------------
datatime=[num2str(t1),':',num2str(t2),':',num2str(step)];
try 
[ip,~]=exl50db(shotnum,'IP',datatime);
[ipf1,t]=exl50db(shotnum,'IPF1',datatime);
[ipf2,~]=exl50db(shotnum,'IPF2',datatime);
[ipf3,~]=exl50db(shotnum,'IPF3',datatime);
[ipf4,~]=exl50db(shotnum,'IPF4',datatime);
[ipf5,~]=exl50db(shotnum,'IPF5',datatime);
[ipf6,~]=exl50db(shotnum,'IPF6',datatime);
[itf,~]=exl50db(shotnum,'ITF',datatime);
figure;set (gcf,'Position',[0,0,500,650]); % figure 1
stackplot({{t,ip,'IP(kA)'},{t,itf,'IP(kA)'},{t,ipf1,'IPF(A)'}}, [], [], [], ['Shot',num2str(shotnum)], 'Time (s)');%{t,itf,'TF(kA)'},
hold on;plot(t,ipf2,'linewidth',2.5);
hold on;plot(t,ipf3,'linewidth',2.5);
hold on;plot(t,ipf4,'linewidth',2.5);
hold on;plot(t,ipf5,'linewidth',2.5);
hold on;plot(t,ipf6,'linewidth',2.5);
legend('Ipf1','Ipf2','Ipf3','Ipf4','Ipf5','Ipf6');
xlim([-2,10]);
mkdir('C:\Users\Lenovo\Desktop\data\',num2str(shotnum));
savepath=['C:\Users\Lenovo\Desktop\data\',num2str(shotnum),'\',[num2str(shotnum),'线圈电流'],'.emf'];
saveas(gcf,savepath);
m_ipf1=abs(mean(ipf1(t3*1e2:t4*1e2)));
m_ipf2=abs(mean(ipf2(t3*1e2:t4*1e2)));
m_ipf3=abs(mean(ipf3(t3*1e2:t4*1e2)));
m_ipf4=abs(mean(ipf4(t3*1e2:t4*1e2)));
m_ipf5=abs(mean(ipf5(t3*1e2:t4*1e2)));
m_ipf6=abs(mean(ipf6(t3*1e2:t4*1e2)));
m_itf=abs(mean(itf(t3*1e2:t4*1e2)));
m_ip=abs(mean(ip(t3*1e2:t4*1e2)));std_ip=std(ip(t3*1e2:t4*1e2));
catch
  m_ipf1=0;  
  m_ipf2=0; 
  m_ipf3=0; 
  m_ipf4=0; 
  m_ipf5=0; 
  m_ipf6=0; 
  m_ip=0; std_ip='null';
  m_itf=0; 
end
    
%%
%-------------等离子体电流数据--------------
try
[ip01,~]=exl50db(shotnum,'IP01',datatime);
[ip02,~]=exl50db(shotnum,'IP02',datatime);
[ip03,~]=exl50db(shotnum,'IP03',datatime);
[ip04,~]=exl50db(shotnum,'IP04',datatime);
% k1=(ip01((t2-t1)*100)-ip01((0-t1)*100))/(t2-t1);x1=k1*[t1:0.01:t2]+ip01((0-t1)*100);
% k2=(ip02((t2-t1)*100)-ip02((0-t1)*100))/(t2-t1);x2=k2*[t1:0.01:t2]+ip02((0-t1)*100);
% k3=(ip03((t2-t1)*100)-ip03((0-t1)*100))/(t2-t1);x3=k3*[t1:0.01:t2]+ip03((0-t1)*100);
% k4=(ip04((t2-t1)*100)-ip04((0-t1)*100))/(t2-t1);x4=k4*[t1:0.01:t2]+ip04((0-t1)*100);
figure;set (gcf,'Position',[500,0,550,450]);
stackplot({{t,6.54*ip01,'IP(kA)'}}, [], [], [],  ['Shot',num2str(shotnum)], 'Time (s)'); % figure 2
hold on;plot(t,-4.67*ip02,'linewidth',2.5);
hold on;plot(t,-6.54*ip03,'linewidth',2.5);
hold on;plot(t,-4.67*ip04,'linewidth',2.5);
%%
figure;set (gcf,'Position',[500,0,550,450]);
stackplot({{t,6.54*ip01,'IP(kA)'}}, [], [], [],  ['Shot',num2str(shotnum)], 'Time (s)'); % figure 2
hold on;plot(t,-4.67*ip02,'linewidth',2.5);
hold on;plot(t,-6.54*ip03,'linewidth',2.5);
hold on;plot(t,-4.67*ip04,'linewidth',2.5);
%%
legend('ip135','ip165','ip315','ip345')
savepath=['C:\Users\Lenovo\Desktop\data\',num2str(shotnum),'\',[num2str(shotnum),'等离子体电流'],'.emf'];
saveas(gcf,savepath);
catch
     msgbox('No IP data','Warning');
end
%%
%---------------------Flux--------------------------
try
[flux,t_flux]=exl50dbN(shotnum,'flux\d*',datatime);
num=1;
figure;set (gcf,'Position',[1050,0,550,450]); %figure 3
stackplot({{t_flux,smooth(flux(:,15),num)/1,'$\phi(Wb)$'}}, [], [], [], ['Shot',num2str(shotnum)], 'Time (s)');%figure 3
hold on;plot(t_flux,smooth(flux(:,16),num)/1,'linewidth',2.5);
hold on;plot(t_flux,smooth(flux(:,18),num)/1,'linewidth',2.5);
hold on;plot(t_flux,smooth(flux(:,19),num)/1,'linewidth',2.5);
hold on;plot(t_flux,smooth(flux(:,20),num)/1,'linewidth',2.5);
hold on;plot(t_flux,smooth(flux(:,21),num)/1,'linewidth',2.5);
hold on;plot(t_flux,smooth(flux(:,33),num),'--','linewidth',2.5);
hold on;plot(t_flux,smooth(flux(:,34),num),'--','linewidth',2.5);
hold on;plot(t_flux,smooth(flux(:,36),num),'--','linewidth',2.5);
hold on;plot(t_flux,smooth(flux(:,37),num),'--','linewidth',2.5);
hold on;plot(t_flux,-smooth(flux(:,38),num),'--','linewidth',2.5);
hold on;plot(t_flux,smooth(flux(:,39),num),'--','linewidth',2.5);
legend('Flux15','Flux16','Flux18','Flux19','Flux20','Flux21','Flux33','Flux34','Flux36','Flux37','Flux38','Flux39')
savepath=['C:\Users\Lenovo\Desktop\data\',num2str(shotnum),'\',[num2str(shotnum),'上下磁通环'],'.emf'];
saveas(gcf,savepath);
catch 
    msgbox('No Flux data','Warning');
end
%%
%-------------FUO   FDO-  等离子体位置-----------------
try
figure;set (gcf,'Position',[0,480,500,450]); %figure 4
stackplot({{t_flux,smooth(flux(:,15),num),'$\phi$'}}, [], [], [],  ['Shot',num2str(shotnum)], 'Time (s)');
hold on;plot(t_flux,smooth(flux(:,21),num),'linewidth',3);
hold on;plot(t_flux,smooth(flux(:,33),num),':','linewidth',3);
hold on;plot(t_flux,smooth(flux(:,39),num),':','linewidth',3);
legend('FUI','FUO','FDI','FDO')
savepath=['C:\Users\Lenovo\Desktop\data\',num2str(shotnum),'\',[num2str(shotnum),'等离子体位置'],'.emf'];
saveas(gcf,savepath);
catch
    msgbox('No flux data','Warning');
end
%%
%-------------密度-电流------------------
try
[ip,t_ip]=exl50db(shotnum,'IP',datatime);
[ne,~]=exl50db(shotnum,'MWI_NE001',datatime);
    figure;set (gcf,'Position',[500,480,500,450]); %figure 5
    yyaxis left
    stackplot({{t_ip,ip,'$Ip(kA)$'}}, [], [], [], ['Shot',num2str(shotnum)], 'Time (s)');
    yyaxis right
    plot(t_ip,ne,'linewidth',2.5)
    ylabel('ne(10^{17}/m^3)')
    savepath=['C:\Users\Lenovo\Desktop\data\',num2str(shotnum),'\',[num2str(shotnum),'电流&密度'],'.emf'];
    saveas(gcf,savepath);
    m_ne=abs(mean(ne(t3*1e2:t4*1e2)));std_ne=std(ne(t3*1e2:t4*1e2));
    
catch
     m_ne='null';std_ne='null';
end
%%
%-------------------微波功率-------------------------------
try
[m1_pin,t]=exl50db(shotnum,'m1_pin',datatime);
[m2_pin,~]=exl50db(shotnum,'m2_pin',datatime);
[m1_pout,~]=exl50db(shotnum,'m1_pout',datatime);
[m2_pout,~]=exl50db(shotnum,'m2_pout',datatime);
figure;set (gcf,'Position',[1000,480,500,450]);% figure 6
stackplot({{t,m1_pin,'$P_{ECRH}$'}}, [], [], [],  ['Shot',num2str(shotnum)], 'Time (s)');%figure 6
hold on;plot(t,m1_pout,':','linewidth',2.5);
hold on;plot(t,m2_pin,'linewidth',2.5);
hold on;plot(t,m2_pout,':','linewidth',2.5);
legend('M1_{Pin}','M1_{Pout}','M2_{Pin}','M2_{Pout}')
savepath=['C:\Users\Lenovo\Desktop\data\',num2str(shotnum),'\',[num2str(shotnum),'微波功率'],'.emf'];
saveas(gcf,savepath);
m1_in=abs(mean(m1_pin(t3*1e2:t4*1e2)));
m1_out=abs(mean(m1_pout(t3*1e2:t4*1e2)));
m2_in=abs(mean(m2_pin(t3*1e2:t4*1e2)));
m2_out=abs(mean(m1_pout(t3*1e2:t4*1e2)));
m1_p=m1_in-m1_out;
m2_p=m2_in-m2_out;
catch
    m1_p='null';m2_p='null';
end
%%
%-------------------------------------------------

str=datestr(datetime('now'),'yyyy-mm-dd HH:MM:SS');
date=str(1:10); time=str(12:end);
filename = 'C:\Users\Lenovo\Desktop\data.xlsx';
data=[shotnum,{date},{time},m_ip,std_ip,m_ne,std_ne,m1_p,m2_p,m_itf,m_ipf1,m_ipf2,m_ipf3,m_ipf4,m_ipf5,m_ipf6];
sheet = 1;
xlRange = ['A',num2str(shotnum)];
xlswrite(filename,data,sheet,xlRange)

end