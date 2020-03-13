function [flux,t]=checkflux3d(shotnum,t1,t2)
step=0.1;
datatime=[num2str(t1),':',num2str(t2),':',num2str(step)];

[flux,t]=exl50dbN(shotnum,'flux\d*',datatime);
%%
num=1:41;
for i=1:size(flux,2)
    pos=num(i)*ones(size(flux,1));
    plot3(t,pos,flux(:,i),'r.-');
    hold on
end

grid on