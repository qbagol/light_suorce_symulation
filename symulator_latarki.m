#####----------| Symulator zrodla fotonow |----------#####

% Aby wybrac ksztalt zrodla wspisz "prostokat" lub 'kolo'

type='kolo';

% k to dlugosc krawedzi probki ktora jest kwadratem 
% h to odleglosc zrodla od probki 
% hh to odleglosc miedzy plytkami zrodla 

k=3;
h=100;
hh=50;

% photons to liczba fotonow

photons=500

% alpha beta gamma to katy rotacji zrodla w przestrzeni 

alpha=0;
beta=0;
gamma=0;

                      ##---| PROSTOKAT |---##

% P1a i P1b to dlugości krawędzi pierwszej płytki zrodla fotonów
% P2a i P2b to dlugości krawędzi drugiej płytki zrodla fotonów

P1a=1;
P1b=10;
P2a=10;
P2b=1;

                         ##---| KOLO |---##
                         
% R1 to promien pierwszej płytki zrodla fotonów      
% R2 to promien drugiej płytki zrodla fotonów     

R1=2;
R2=1; 

###########################################################################              


promien=h/hh;
alpha=alpha*pi/180;
beta=beta*pi/180;
gamma=gamma*pi/180;


Rx=[1 0 0
    0 cos(alpha) -sin(alpha)
    0 sin(alpha) cos(alpha)];
    
Ry=[ cos(beta)  0  sin(beta)
     0          1  0
    -sin(beta)  0  cos(beta)];
    
Rz=[ cos(gamma) -sin(gamma) 0
     sin(gamma)  cos(gamma) 0
     0              0       1];

switch type 
case 'prostokat'
 xx=[-h,-(P1a)/2,-(P1b)/2];
 yy=[-h,(P1a)/2,-(P1b)/2];
 zz=[-h,-(P1a)/2,(P1b)/2];
 vv=[-h,(P1a)/2,(P1b)/2];

 xxx=[-h-hh,-(P2a)/2,-(P2b)/2];
 yyy=[-h-hh,(P2a)/2,-(P2b)/2];
 zzz=[-h-hh,-(P2a)/2,(P2b)/2];
 vvv=[-h-hh,(P2a)/2,(P2b)/2];

 xxxx=[0,-(k)/2,-(k)/2];
 yyyy=[0,(k)/2,-(k)/2];
 zzzz=[0,-(k)/2,(k)/2];
 vvvv=[0,(k)/2,(k)/2];

 p=[xx;yy;vv;zz;xx]*Rx*Ry*Rz ;
 q=[xxx;yyy;vvv;zzz;xxx]*Rx*Ry*Rz ;
 pp=[xxxx;yyyy;vvvv;zzzz;xxxx];

 photons_matrix1 =(-(P1a)/2)+((P1a)/2-(-(P1a)/2))*rand(1,photons);
 photons_matrix2 =(-(P1b)/2)+((P1b)/2-(-(P1b)/2))*rand(1,photons);
 photons_matrix3 =(-(P2a)/2)+((P2a)/2-(-(P2a)/2))*rand(1,photons);
 photons_matrix4 =(-(P2b)/2)+((P2b)/2-(-(P2b)/2))*rand(1,photons);
 ph0=photons_matrix1*0-h;
 ph3=photons_matrix1*0-h-hh;

 photons_MM=[ph0' , photons_matrix1' , photons_matrix2']*Rx*Ry*Rz;
 photons_NN=[ph3' , photons_matrix3' , photons_matrix4']*Rx*Ry*Rz;

 plot3(p(:,1),p(:,2),p(:,3))
 hold on
 plot3(q(:,1),q(:,2),q(:,3))
 hold on
 plot3(pp(:,1),pp(:,2),pp(:,3))

 axis("equal");
 for i =(1:photons)
  x=photons_MM(i,1)+h;
  y=-(photons_MM(i,2)-photons_NN(i,2));
  y=photons_MM(i,2)-y*promien;
  z=-(photons_MM(i,3)-photons_NN(i,3));
  z=photons_MM(i,3)-z*promien;
  if z<(k/2) 
   if z>(-k/2) 
    if y<(k/2) 
     if y>(-k/2)
       plot3([photons_NN(i,1);photons_MM(i,1);x],[photons_NN(i,2);photons_MM(i,2);y],[photons_NN(i,3);photons_MM(i,3);z],"r")
     else plot3([photons_NN(i,1);photons_MM(i,1);x],[photons_NN(i,2);photons_MM(i,2);y],[photons_NN(i,3);photons_MM(i,3);z],"y")
     endif
    else plot3([photons_NN(i,1);photons_MM(i,1);x],[photons_NN(i,2);photons_MM(i,2);y],[photons_NN(i,3);photons_MM(i,3);z],"y")
    endif
   else plot3([photons_NN(i,1);photons_MM(i,1);x],[photons_NN(i,2);photons_MM(i,2);y],[photons_NN(i,3);photons_MM(i,3);z],"y")
   endif
  else plot3([photons_NN(i,1);photons_MM(i,1);x],[photons_NN(i,2);photons_MM(i,2);y],[photons_NN(i,3);photons_MM(i,3);z],"y")
  endif 
 endfor
 
case 'kolo'
 photons=(photons^0.5);
 photons= real(photons);
 t = linspace(0,2*pi,100)'; 
 circsxR1= R1*cos(t); 
 circsyR1= R1*sin(t); 
 circsxR2= R2*cos(t); 
 circsyR2= R2*sin(t); 
 axis equal 
 crsR1=[(t*0)-(h+hh), circsxR1, circsyR1 ]*Rx*Ry*Rz;
 crsR2=[(t*0)-(h),    circsxR2, circsyR2 ]*Rx*Ry*Rz;
 plot3(crsR1(:,1),crsR1(:,2),crsR1(:,3));
 hold on
 plot3(crsR2(:,1),crsR2(:,2),crsR2(:,3)); 
 
 xxxx=[0,-(k)/2,-(k)/2];
 yyyy=[0,(k)/2,-(k)/2];
 zzzz=[0,-(k)/2,(k)/2];
 vvvv=[0,(k)/2,(k)/2];
 pp=[xxxx;yyyy;vvvv;zzzz;xxxx];
 plot3(pp(:,1),pp(:,2),pp(:,3))
 
 tt= 2*pi*rand(photons,1);
 ttt= 2*pi*rand(photons,1);
 hhh=tt*0-h-hh;
 hhhh=tt*0-h;
 photons_matrix5 =(R1)*rand(1,photons);
 photons_matrix6 =(R1)*rand(1,photons);
 photons_matrix7 =(R2)*rand(1,photons);
 photons_matrix8 =(R2)*rand(1,photons);
 photons_matrix5=photons_matrix5';
 photons_matrix6=photons_matrix6';
 photons_matrix7=photons_matrix7';
 photons_matrix8=photons_matrix8';
 
 for j =(1:photons)
  photons_NNN=[hhh ,photons_matrix5(j,1)*cos(tt), photons_matrix6(j,1)*sin(tt)];
  photons_MMM=[hhhh ,photons_matrix7(j,1)*cos(ttt), photons_matrix8(j,1)*sin(ttt)];
  photons_NNN=real(photons_NNN);
  photons_MMM=real(photons_MMM);
  photons_NNN=photons_NNN*Rx*Ry*Rz;
  photons_MMM=photons_MMM*Rx*Ry*Rz;
  
   for i =(1:photons)
   x=photons_MMM(i,1)+h;
   y=-(photons_MMM(i,2)-photons_NNN(i,2));
   y=photons_MMM(i,2)-y*promien;
   z=-(photons_MMM(i,3)-photons_NNN(i,3));
   z=photons_MMM(i,3)-z*promien;
   
   if z<(k/2) 
    if z>(-k/2) 
     if y<(k/2) 
      if y>(-k/2)
        plot3([photons_NNN(i,1);photons_MMM(i,1);x],[photons_NNN(i,2);photons_MMM(i,2);y],[photons_NNN(i,3);photons_MMM(i,3);z],"r")
      else plot3([photons_NNN(i,1);photons_MMM(i,1);x],[photons_NNN(i,2);photons_MMM(i,2);y],[photons_NNN(i,3);photons_MMM(i,3);z],"y")
       endif
     else plot3([photons_NNN(i,1);photons_MMM(i,1);x],[photons_NNN(i,2);photons_MMM(i,2);y],[photons_NNN(i,3);photons_MMM(i,3);z],"y")
     endif
    else plot3([photons_NNN(i,1);photons_MMM(i,1);x],[photons_NNN(i,2);photons_MMM(i,2);y],[photons_NNN(i,3);photons_MMM(i,3);z],"y")
    endif
   else plot3([photons_NNN(i,1);photons_MMM(i,1);x],[photons_NNN(i,2);photons_MMM(i,2);y],[photons_NNN(i,3);photons_MMM(i,3);z],"y")
   endif 
  endfor
 endfor
endswitch 
