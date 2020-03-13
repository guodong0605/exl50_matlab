function checkipf(shotnum,t1,t2)
step=0.01;
%%----------------save data of basic discharge parameter--------------------
datatime=[num2str(t1),':',num2str(t2),':',num2str(step)];

[ipf1,t]=exl50db(shotnum,'IPF1',datatime);
[ipf2,~]=exl50db(shotnum,'IPF2',datatime);
[ipf3,~]=exl50db(shotnum,'IPF3',datatime);
[ipf4,~]=exl50db(shotnum,'IPF4',datatime);
[ipf5,~]=exl50db(shotnum,'IPF5',datatime);
[ipf6,~]=exl50db(shotnum,'IPF6',datatime);

[upf1,t2]=exl50db(shotnum,'UPF01',datatime);
[upf2,~]=exl50db(shotnum,'UPF02',datatime);
[upf3,~]=exl50db(shotnum,'UPF03',datatime);
[upf4,~]=exl50db(shotnum,'UPF04',datatime);
[upf5,~]=exl50db(shotnum,'UPF05',datatime);
[upf6,~]=exl50db(shotnum,'UPF06',datatime);

[ip,t3]=exl50db(shotnum,'ip',datatime);

% [ypf1,t4]=exl50db(shotnum,'YPF1',datatime);
% [ypf3,~]=exl50db(shotnum,'YPF3',datatime);
% [ypf4,~]=exl50db(shotnum,'YPF4',datatime);
% [ypf5,~]=exl50db(shotnum,'YPF5',datatime);


figure;set (gcf,'Position',[200,50,639,581],'WindowStyle','Normal'); % figure 1
stackplot({{t3,ip,'IP(kA)'},{t,ipf1,'IPF(A)'}}, [], [], [], ['Shot',num2str(shotnum)], 'Time (s)');
hold on;plot(t,ipf2,'linewidth',2.5);
hold on;plot(t,ipf3,'linewidth',2.5);
hold on;plot(t,ipf4,'linewidth',2.5);
hold on;plot(t,ipf5,'linewidth',2.5);
hold on;plot(t,ipf6,'linewidth',2.5);
legend('Ipf1','Ipf2','Ipf3','Ipf4','Ipf5','Ipf6');
ylim([1.1*min([min(ipf1),min(ipf2),min(ipf3),min(ipf4),min(ipf5),min(ipf6)]),1.1*max([max(ipf1),max(ipf2),max(ipf3),max(ipf4),max(ipf5),max(ipf6)])])
set(gca,'fontname', 'Times New Roman', 'FontWeight', 'normal', 'FontSize', 16, 'LineWidth', 2, 'XMinorTick', 'on', 'YMinorTick', 'on','ticklength',[0.02 0.02],'Xgrid','off');
%%
figure;stackplot({{t,ipf1,'IPF1(A)'},{t,ipf2,'IPF2(A)'},{t,ipf3,'IPF3(A)'},{t,ipf4,'IPF4(A)'},{t,ipf5,'IPF5(A)'},{t,ipf6,'IPF6(A)'}}, [], [], [], ['Shot',num2str(shotnum),'IPF'], 'Time (s)');
figure;stackplot({{t2,upf1,'UPF1(V)'},{t2,upf2,'UPF2(V)'},{t2,upf3,'UPF3(V)'},{t2,upf4,'UPF4(V)'},{t2,upf5,'UPF5(V)'},{t2,upf6,'UPF6(V)'}}, [], [], [], ['Shot',num2str(shotnum),'UPF'], 'Time (s)');
% figure;stackplot({{t4,ypf1,'YPF1(V)'},{t4,ypf3,'UPF3(V)'},{t4,ypf4,'UPF4(V)'},{t4,ypf5,'UPF5(V)'}}, [], [], [], ['Shot',num2str(shotnum),'YPF'], 'Time (s)');

%%
savepath=['C:\Users\Lenovo\Desktop\data\',[num2str(shotnum),'Current'],'.emf'];
saveas(gcf,savepath);


end