function changecolor(h1)
if nargin<1
    h1=gca;
end
temp=get(h1,'Children');
n=size(temp,1);
newcolor=mycolor(n);
for i=1:n
    set(temp(i),'Color',newcolor(i,:));
end