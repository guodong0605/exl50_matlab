R=1e6; r=2; L=2e-3;C=5e-9;
f=linspace(1,1e6,1e3);
A=(((R+r)/R-f.^2*L*C).^2+(f*C*r+f*L/R).^2).^(0.5);

temp=(f.*C*r+f.*L/R)./((R+r)/R-f.^2*L*C);
phi=atan(-temp)/pi*180;

figure;stackplot({{f/1e3,A,'Amplitude'}}, [], [], [], 'AC analysis', 'f(kHz)');
figure;stackplot({{f/1e3,phi,'$\phi$'}}, [], [], [], 'AC analysis', 'f(kHz)');