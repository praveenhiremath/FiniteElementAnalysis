% Praveenkumar Hiremath - matriculation number 57955
function [ kg,glof ] = shape(n,nnod,COORD,vcN,C,NT)


r12=nnod*2;

kg=zeros(r12,r12);

DN=[-1,1,0;-1,0,1];

dyu=zeros(r12,1);

ckg=zeros(r12,1);

% glof=zeros(r12,1);
% 
% NT=NT';
% dis=size(NT,1);
% 
% for t=1:dis
% 
%     v=2*NT(t);
%     dyu(v)=0.05;
% end    
% 


for i=1:n
    

% dglof=zeros(r12,1);    
    

kgi=zeros(r12,r12);    
    
a=vcN(i,1);
b=vcN(i,2);
c=vcN(i,3); 

f1=[(a*2)-1,(a*2),(b*2)-1,(b*2),(c*2)-1,(c*2)];

cord=[COORD(a,1),COORD(a,2);COORD(b,1),COORD(b,2);COORD(c,1),COORD(c,2)];

J= DN*cord;
J=J';
dn1= inv(J)*[DN(1,1);DN(2,1)];
dn2= inv(J)*[DN(1,2);DN(2,2)]; 
dn3= inv(J)*[DN(1,3);DN(2,3)];


B=[dn1(1,1),0,dn2(1,1),0,dn3(1,1),0;0,dn1(2,1),0,dn2(2,1),0,dn3(2,1);dn1(2,1),dn1(1,1),dn2(2,1),dn2(1,1),dn3(2,1),dn3(1,1)]


ke=B'*C*B*det(J)*0.5;


 g=a*2;
 f=g-1;
 o=b*2;p=o-1;
 r=c*2;s=r-1;
% % 
% % g1=dyu(f);f2=dyu(g);o1=dyu(p);q1=dyu(o);r1=dyu(s);s1=dyu(r);
% % 
% % cu=[g1,f2,o1,q1,r1,s1]';
% % 
% % intf = 2*ke*cu*det(J); 
% % 
% % dglof(f)= intf(1);
% % dglof(g)= intf(2);
% % dglof(p)= intf(3);
% % dglof(o)= intf(4);
% % dglof(s)= intf(5);
% dglof(r)= intf(6);

 for l=1:2
    for m=1:6

        kgi(f,f1(m))=ke(m,l);
        kgi(f1(m),f)=kgi(f,f1(m));
    end 
    f=g;
end

% for l=1:3
%     for m=1:3
% 
%         a = vcN(i,l);
%         b = vcN(i,m);
%         kgi(a*2,b*2) = ke(l*2,m*2);
%         kgi((a*2)-1,(b*2)-1) = ke(l,m);
%         kgi(a*2,(b*2)-1) = ke(l,m*2);
%         kgi((a*2)-1,b*2) = ke(l*2,m);
% 
%     end 
% end

g=b*2;
f=g-1;

for l=3:4
    for m=1:6

        kgi(f,f1(m))=ke(m,l);
        kgi(f1(m),f)=kgi(f,f1(m));
    end 
    f=g;
end

g=c*2;
f=g-1;

for l=5:6
    for m=1:6

        kgi(f,f1(m))=ke(m,l);
        kgi(f1(m),f)=kgi(f,f1(m));
       
    end 
    f=g;
end

    

glof=1;

% glof=glof+dglof;
kg=kg+kgi;




end

end

