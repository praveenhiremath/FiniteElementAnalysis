
clc
%% Template for Assignment for Selected Topics of Finite Element Method -- Summer term 2015
% Lecturer in charge: Geralf Hütter, TU Bergakademie Freiberg, Institute of Mechanics and Fluid Dynamics
% Web: http://tu-freiberg.de/en/fakult4/imfd/studium-und-lehre/lectures
%
% !! Warning : Running this code will delete the current workspace. Save any required date in advance!
% default settings:
set(0,'DefaultFigureColor','w') %white background
set(0,'DefaultAxesFontSize',14); %larger fonts
set(0,'DefaulttextFontSize',14);
%%
%
clear all
% load mesh
%   COORD(nnodes,2) : list of coordinates of all nodes
%   node_connectivity(nelem,nodes_per_elem): list containing connectivity of all elements
%   NodesBottom,NodesTop,NodesHole,NodesLeft, NodesRight: List containing numbers of nodes at respective boundaries
%   Choose the suitable mesh:
%   A) without hole
%load 'Mesh_Tri_uniform' 
%load 'Mesh_Quad_uniform' 
%   B) plate with hole, triangular elements
load 'Mesh_Tri_vCoarse'
%load 'Mesh_Tri_Coarse'
%load 'Mesh_Tri_Fine' 
%load 'Mesh_Tri_vFine' 
%   C) plate with hole, quadrilateral elements
%load 'Mesh_Quad_Coarse' 
%load 'Mesh_Quad_Coarse' 
%load 'Mesh_Quad_Fine' 
%load 'Mesh_Quad_vFine'

nnodes=size(COORD,1);
nelem=size(node_connectivity,1);

%%
%%% Visualisation of the Mesh
% 

figure('Name','Nodes')
hold all
%plot all nodes
plot(COORD(:,1),COORD(:,2),'k.') 

%highlight predefined node sets
plot(COORD(NodesBottom,1),COORD(NodesBottom,2),'v')
plot(COORD(NodesLeft,1),COORD(NodesLeft,2),'<')
plot(COORD(NodesHole,1),COORD(NodesHole,2),'o')
plot(COORD(NodesTop,1),COORD(NodesTop,2),'^')
plot(COORD(NodesRight,1),COORD(NodesRight,2),'>')

legend('nodes','bottom','left','hole','top','right')


%%
figure('Name','Elements')
%plot all element boundaries
hold all
for e=1:nelem
    currnodes=[node_connectivity(e,:), node_connectivity(e,1)];
    plot(COORD(currnodes,1),COORD(currnodes,2),'b-')
end

e=200000;
v=0.15;

C=materialr(e,v);
[KG,FG]=shape(nelem,nnodes,COORD,node_connectivity,C,NodesTop);


NR=NodesRight;NL=NodesLeft;NH=NodesHole;NB=NodesBottom;NT=NodesTop;
NL=NL';NH=NH';NB=NB';NT=NT';

U=zeros(nnodes*2,1);

dis=size(NT,1);

for t=1:dis

    v=2*NT(t);
    U(v)=0.05;
end




Fint=KG*U;

RKG=KG;
RFG=Fint;



a=size(NB,1);

b=size(NL,1);

c=size(NT,1);

d=a+b+c;

red=zeros(1,d);
for i=1:a
    
    red(i)=2*NB(i);
    
end


i2=1;
for i=(a+1):(a+b)
    
    red(i)=(2*NL(i2))-1;
    i2=i2+1;
end

i3=1;
for i=(a+b+1):d
    
    red(i)=(2*NT(i3));
    i3=i3+1;
end

RFG(red,:)=[];
RKG(red,:)=[];           
RKG(:,red)=[];

RU=RFG'*inv(RKG);






        





