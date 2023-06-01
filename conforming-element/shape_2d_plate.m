function [sf,sfL,dsfx,dsfy,J,ddsfx,ddsfy,ddsfxy]=shape_2d_plate(nfunc,npea,npe,xi,eta,el_x,el_y)
%
sf = zeros(npea,1);
sfL = zeros(npea,1);
dsfxiL= zeros(npea,1);
dsfetaL= zeros(npea,1);
ddsfxiL= zeros(npea,1);
ddsfxietaL= zeros(npea,1);
ddsfetaL= zeros(npea,1);
dsf = zeros(npea,1);
ddsf = zeros(npea,1);
gdsf = zeros(npea,1);
gddsf = zeros(npea,1);
dsfxi = zeros(npea,1);
dsfeta = zeros(npea,1);
ddsfxi=zeros(npea,1);
ddsfeta=zeros(npea,1);
ddsfxieta=zeros(npea,1);
ddsfx=zeros(npea,1);
ddsfy=zeros(npea,1);
ddsfxy=zeros(npea,1);


     sfL(1) = (1/4)*(1-xi)*(1-eta);
    sfL(2) = (1/4)*(1+xi)*(1-eta);
    sfL(3) = (1/4)*(1+xi)*(1+eta);
    sfL(4) = (1/4)*(1-xi)*(1+eta);

    dsfxiL(1)=(1/4)*(eta-1);
    dsfxiL(2)=(1/4)*(1-eta);
    dsfxiL(3)=(1/4)*(1+eta);
    dsfxiL(4)=(1/4)*(-1-eta);
    
    ddsfxiL(1)=0;
    ddsfxiL(2)=0;
    ddsfxiL(3)=0;
    ddsfxiL(4)=0;
    
    
    ddsfxietaL(1)=(1/4);
    ddsfxietaL(2)=(-1/4);
    ddsfxietaL(3)=(1/4);
    ddsfxietaL(4)=(-1/4);

    dsfetaL(1)=(1/4)*(xi-1);
    dsfetaL(2)=(1/4)*(-1-xi);
    dsfetaL(3)=(1/4)*(1+xi);
    dsfetaL(4)=(1/4)*(1-xi);
    
    ddsfetaL(1)=0;
    ddsfetaL(2)=0;
    ddsfetaL(3)=0;
    ddsfetaL(4)=0;
   
if nfunc==1

%  sf(1) = (1/8)*(1-xi)*(1-eta)*(2-xi-eta-xi^2-eta^2);
%     sf(2) = (1/8)*(1+xi)*(1-eta)*(1-xi)^2;
%     sf(3) = (1/8)*(1-xi)*(1+eta)*(1-eta)^2;
%     sf(4) = (1/8)*(1+xi)*(1-eta)*(2+xi-eta-xi^2-eta^2);
%     sf(5) = (1/8)*(-1+xi)*(1-eta)*(1+xi)^2;
%     sf(6) = (1/8)*(1+xi)*(1+eta)*(1-eta)^2;
%     sf(7) = (1/8)*(1+xi)*(1+eta)*(2+xi+eta-xi^2-eta^2);
%     sf(8) = (1/8)*(-1+xi)*(1+eta)*(1+xi)^2;
%     sf(9) = (1/8)*(1+xi)*(-1+eta)*(1+eta)^2;
%     sf(10) = (1/8)*(1-xi)*(1+eta)*(2-xi+eta-xi^2-eta^2);
%     sf(11) = (1/8)*(1-xi)^2*(1+xi)*(1+eta);
%     sf(12) = (1/8)*(1-xi)*(1+eta)^2*(-1+eta);
% 
%     dsfxi(1)=(1/8)*(1-eta)*((2-xi-eta-xi^2-eta^2)*(-1)+(1-xi)*(-1-2*xi));
%     dsfxi(2)=(1/8)*(1-eta)*((1-xi)^2+(1+xi)*2*(1-xi)*(-1));
%     dsfxi(3)=(1/8)*(1+eta)*(1-eta)^2*(-1);
%     dsfxi(4)=(1/8)*(1-eta)*((2+xi-eta-xi^2-eta^2)+(1+xi)*(1-2*xi));
%     dsfxi(5)=(1/8)*(1-eta)*((1+xi)^2+(-1+xi)*2*(1+xi));
%     dsfxi(6)=(1/8)*(1+eta)*(1-eta)^2;
%     dsfxi(7)=(1/8)*(1+eta)*((2+xi+eta-xi^2-eta^2)+(1+xi)*(1-2*xi));
%     dsfxi(8)=(1/8)*(1+eta)*((1+xi)^2+(-1+xi)*2*(1+xi));
%     dsfxi(9)=(1/8)*(-1+eta)*(1+eta)^2;
%     dsfxi(10)=(1/8)*(1+eta)*((2-xi+eta-xi^2-eta^2)*(-1)+(1-xi)*(-1-2*xi));
%     dsfxi(11)=-(1/8)*(1-xi)*2*(1+xi)*(1+eta)+(1/8)*(1-xi)^2*(1+eta);
%     dsfxi(12)=(1/8)*(-1+eta)*(1+eta)^2*(-1);
%     
%     dsfeta(1)=(1/8)*(1-xi)*((2-xi-eta-xi^2-eta^2)*(-1)+(1-eta)*(-1-2*eta));
%     dsfeta(2)=(1/8)*(1+xi)*(1-xi)^2*(-1);
%     dsfeta(3)=(1/8)*(1-xi)*((1-eta)^2+(1+eta)*2*(1-eta)*(-1));
%     dsfeta(4)=(1/8)*(1+xi)*((2+xi-eta-xi^2-eta^2)*(-1)+(1-eta)*(-1-2*eta));
%     dsfeta(5)=(1/8)*(-1+xi)*(1+xi)^2*(-1);
%     dsfeta(6)=(1/8)*(1+xi)*((1-eta)^2+(1+eta)*2*(1-eta)*(-1));
%     dsfeta(7)=(1/8)*(1+xi)*((2+xi+eta-xi^2-eta^2)+(1+eta)*(1-2*eta));
%     dsfeta(8)=(1/8)*(-1+xi)*(1+xi)^2;
%     dsfeta(9)=(1/8)*(1+xi)*((1+eta)^2+(-1+eta)*2*(1+eta));
%     dsfeta(10)=(1/8)*(1-xi)*((2-xi+eta-xi^2-eta^2)+(1+eta)*(1-2*eta));
%     dsfeta(11)=(1/8)*(1-xi)^2*(1+xi);
%     dsfeta(12)=(1/8)*(1-xi)*((1+eta)^2+(-1+eta)*2*(1+eta));
%     
%     
%     ddsfxi(1)=(1/8)*(1-eta)*((-1)*(-1-2*xi)+(1-xi)*(-2)+(-1-2*xi)*(-1));
%     ddsfxi(2)=-(1/8)*2*(-1)*(1+xi)*(1-eta)+(1/8)*(1-xi)*2*(-1)*(1-eta)-(1/8)*(1-xi)*2*(1-eta);
%     ddsfxi(3)= 0;
%     ddsfxi(4)=(1/8)*(1-eta)*((1-2*xi)+(1+xi)*(-2)+(1-2*xi));
%     ddsfxi(5)=(1/8)*(1-eta)*(2*((xi-1)+(1+xi))+2*(1+xi));
%     ddsfxi(6)= 0;
%     ddsfxi(7)=(1/8)*(1+eta)*((1-2*xi)+(1+xi)*(-2)+(1-2*xi));
%     ddsfxi(8)=(1/8)*(1+eta)*(2*(1+xi)+2*((xi-1)+(1+xi)));
%     ddsfxi(9)=0;
%     ddsfxi(10)=(1/8)*(1+eta)*((-1)*(-1-2*xi)+(1-xi)*(-2)+(-1-2*xi)*(-1));
%     ddsfxi(11)=(1/8)*2*(1+xi)*(1+eta)-(1/8)*(1-xi)*2*(1+eta)-(1/8)*(1-xi)*2*(1+eta);
%     ddsfxi(12)= 0;
%     
%     
%     ddsfxieta(1)=(-1/8)*((1-eta)*(-1-2*eta)+(2-xi-eta-xi^2-eta^2)*(-1))-(1/8)*(1-xi)*(-1-2*xi);
%     ddsfxieta(2)=(-1/8)*((1-xi)^2+(1+xi)*2*(1-xi)*(-1));
%     ddsfxieta(3)=(-1/8)*((1-eta)^2+(1+eta)*(2)*(1-eta)*(-1));
%     ddsfxieta(4)=(1/8)*((1-eta)*(-1-2*eta)+(2+xi-eta-xi^2-eta^2)*(-1))+(1/8)*(1+xi)*(1-2*xi)*(-1);
%     ddsfxieta(5)=(-1/8)*((1+xi)^2+(-1+xi)*2*(1+xi));
%     ddsfxieta(6)=(1/8)*((1-eta)^2+(1+eta)*(2)*(1-eta)*(-1));
%     ddsfxieta(7)=(1/8)*((1+eta)*(1-2*eta)+(2+xi+eta-xi^2-eta^2))+(1/8)*(1+xi)*(1-2*xi);
%     ddsfxieta(8)=(1/8)*((1+xi)^2+(-1+xi)*2*(1+xi));
%     ddsfxieta(9)=(1/8)*((1+eta)^2+(-1+eta)*(2)*(1+eta));
%     ddsfxieta(10)=(-1/8)*((1+eta)*(1-2*eta)+(2-xi+eta-xi^2-eta^2))+(1/8)*(1-xi)*(-1-2*xi);
%     ddsfxieta(11)=-(1/8)*(1-xi)*2*(1+xi)+(1/8)*(1-xi)^2;
%     ddsfxieta(12)=(-1/8)*((1+eta)^2+(-1+eta)*(2)*(1+eta));
% 
%    
% 
%     ddsfeta(1)=(1/8)*(1-xi)*((-1)*(-1-2*eta)+(1-eta)*(-2)+(-1-2*eta)*(-1));
%     ddsfeta(2)=0;
%     ddsfeta(3)= (1/8)*(1-xi)*(2*(1-eta)*(-1)+(-1)*(2)*((1+eta)*(-1)+(1-eta)));
%     ddsfeta(4)=(1/8)*(1+xi)*((-1)*(-1-2*eta)+(1-eta)*(-2)+(-1-2*eta)*(-1));
%     ddsfeta(5)=0;
%     ddsfeta(6)= (1/8)*(1+xi)*(2*(1-eta)*(-1)+2*(-1)*((1+eta)*(-1)+(1-eta)));
%     ddsfeta(7)=(1/8)*(1+xi)*((1-2*eta)+(1+eta)*(-2)+(1-2*eta));
%     ddsfeta(8)=0;
%     ddsfeta(9)=(1/8)*(1+xi)*(2*(1+eta)+2*((eta-1)+(1+eta)));
%     ddsfeta(10)=(1/8)*(1-xi)*((1-2*eta)+(1+eta)*(-2)+(1-2*eta));
%     ddsfeta(11)=0;
%     ddsfeta(12)= (1/8)*(1-xi)*(2*(1+eta)+2*((eta-1)+(1+eta)));

sf(1)=(1/16)*(eta-1)^2*(-eta-2)*(xi-1)^2*(-xi-2);
    sf(2)=(1/16)*(eta-1)^2*(-eta-2)*(xi-1)^2*(-xi-1);
    sf(3)=(1/16)*(eta-1)^2*(-eta-1)*(xi-1)^2*(-xi-2);
    sf(4)=(1/16)*(eta-1)^2*(-eta-1)*(xi-1)^2*(-xi-1);
    sf(5)=(1/16)*(eta-1)^2*(-eta-2)*(xi+1)^2*(xi-2);
    sf(6)=(-1/16)*(eta-1)^2*(-eta-2)*(xi+1)^2*(xi-1);
    sf(7)=(1/16)*(eta-1)^2*(-eta-1)*(xi+1)^2*(xi-2);
    sf(8)=(-1/16)*(eta-1)^2*(-eta-1)*(xi+1)^2*(xi-1);
    sf(9)=(1/16)*(eta+1)^2*(eta-2)*(xi+1)^2*(xi-2);
    sf(10)=(-1/16)*(eta+1)^2*(eta-2)*(xi+1)^2*(xi-1);
    sf(11)=(-1/16)*(eta+1)^2*(eta-1)*(xi+1)^2*(xi-2);
    sf(12)=(1/16)*(eta+1)^2*(eta-1)*(xi+1)^2*(xi-1);
    sf(13)=(1/16)*(eta+1)^2*(eta-2)*(xi-1)^2*(-xi-2);
    sf(14)=(1/16)*(eta+1)^2*(eta-2)*(xi-1)^2*(-xi-1);
    sf(15)=(-1/16)*(eta+1)^2*(eta-1)*(xi-1)^2*(-xi-2);
    sf(16)=(-1/16)*(eta+1)^2*(eta-1)*(xi-1)^2*(-xi-1);
    
    dsfxi(1)=(1/16)*(eta-1)^2*(-eta-2)*((xi-1)^2*(-1)+(-xi-2)*(2)*(xi-1));
    dsfxi(2)=(1/16)*(eta-1)^2*(-eta-2)*((xi-1)^2*(-1)+(-xi-1)*(2)*(xi-1));
    dsfxi(3)=(1/16)*(eta-1)^2*(-eta-1)*((xi-1)^2*(-1)+(-xi-2)*(2)*(xi-1));
    dsfxi(4)=(1/16)*(eta-1)^2*(-eta-1)*((xi-1)^2*(-1)+(-xi-1)*(2)*(xi-1));
    dsfxi(5)=(1/16)*(eta-1)^2*(-eta-2)*((xi+1)^2+(xi-2)*(2)*(xi+1));
    dsfxi(6)=(-1/16)*(eta-1)^2*(-eta-2)*((xi+1)^2+(xi-1)*(2)*(xi+1));
    dsfxi(7)=(1/16)*(eta-1)^2*(-eta-1)*((xi+1)^2+(xi-2)*(2)*(xi+1));
    dsfxi(8)=(-1/16)*(eta-1)^2*(-eta-1)*((xi+1)^2+(xi-1)*(2)*(xi+1));
    dsfxi(9)=(1/16)*(eta+1)^2*(eta-2)*((xi+1)^2+(xi-2)*(2)*(xi+1));
    dsfxi(10)=(-1/16)*(eta+1)^2*(eta-2)*((xi+1)^2+(xi-1)*(2)*(xi+1));
    dsfxi(11)=(-1/16)*(eta+1)^2*(eta-1)*((xi+1)^2+(xi-2)*(2)*(xi+1));
    dsfxi(12)=(1/16)*(eta+1)^2*(eta-1)*((xi+1)^2+(xi-1)*(2)*(xi+1));
    dsfxi(13)=(1/16)*(eta+1)^2*(eta-2)*((xi-1)^2*(-1)+(-xi-2)*(2)*(xi-1));
    dsfxi(14)=(1/16)*(eta+1)^2*(eta-2)*((xi-1)^2*(-1)+(-xi-1)*(2)*(xi-1));
    dsfxi(15)=(-1/16)*(eta+1)^2*(eta-1)*((xi-1)^2*(-1)+(-xi-2)*(2)*(xi-1));
    dsfxi(16)=(-1/16)*(eta+1)^2*(eta-1)*((xi-1)^2*(-1)+(-xi-1)*(2)*(xi-1));
    
    ddsfxi(1)=(1/16)*(eta-1)^2*(-eta-2)*((-1)*(2)*(xi-1)+2*((-xi-2)+(xi-1)*(-1)));
    ddsfxi(2)=(1/16)*(eta-1)^2*(-eta-2)*((-1)*(2)*(xi-1)+2*((-xi-1)+(xi-1)*(-1)));
    ddsfxi(3)=(1/16)*(eta-1)^2*(-eta-1)*(2*(xi-1)*(-1)+2*((-xi-2)+(xi-1)*(-1)));
    ddsfxi(4)=(1/16)*2*(-xi-1)*(eta-1)^2*(-eta-1)+(1/16)*(xi-1)*2*(-1)*(eta-1)^2*(-eta-1)+(1/16)*(xi-1)*2*(-1)*(eta-1)^2*(-eta-1);
    ddsfxi(5)=(1/16)*(eta-1)^2*(-eta-2)*(2*(xi+1)+2*((xi-2)+(xi+1)));
    ddsfxi(6)=(-1/16)*(eta-1)^2*(-eta-2)*(2*(xi+1)+2*((xi-1)+(xi+1)));
    ddsfxi(7)=(1/16)*(eta-1)^2*(-eta-1)*(2*(xi+1)+2*((xi-2)+(xi+1)));
    ddsfxi(8)=(-1/16)*(eta-1)^2*(-eta-1)*(2*(xi+1)+2*((xi-1)+(xi+1)));
    ddsfxi(9)=(1/16)*(eta+1)^2*(eta-2)*(2*(xi+1)+2*((xi-2)+(xi+1)));
    ddsfxi(10)=(-1/16)*(eta+1)^2*(eta-2)*(2*(xi+1)+2*((xi-1)+(xi+1)));
    ddsfxi(11)=(-1/16)*(eta+1)^2*(eta-1)*(2*(xi+1)+2*((xi-2)+(xi+1)));
    ddsfxi(12)=(1/16)*(eta+1)^2*(eta-1)*(2*(xi+1)+2*((xi-1)+(xi+1)));
    ddsfxi(13)=(1/16)*(eta+1)^2*(eta-2)*((-1)*2*(xi-1)+2*((-xi-2)+(-1)*(xi-1)));
    ddsfxi(14)=(1/16)*(eta+1)^2*(eta-2)*((-1)*2*(xi-1)+2*((-xi-1)+(-1)*(xi-1)));
    ddsfxi(15)=(-1/16)*(eta+1)^2*(eta-1)*((-1)*2*(xi-1)+2*((-xi-2)+(-1)*(xi-1)));
    ddsfxi(16)=(-1/16)*(eta+1)^2*(eta-1)*((-1)*2*(xi-1)+2*((-xi-1)+(-1)*(xi-1)));
    
    ddsfxieta(1)=(1/16)*((xi-1)^2*(-1)+(-xi-2)*(2)*(xi-1))*((eta-1)^2*(-1)+(-eta-2)*2*(eta-1));
    ddsfxieta(2)=(1/16)*((xi-1)^2*(-1)+(-xi-1)*(2)*(xi-1))*((eta-1)^2*(-1)+(-eta-2)*2*(eta-1));
    ddsfxieta(3)=(1/16)*((xi-1)^2*(-1)+(-xi-2)*(2)*(xi-1))*((eta-1)^2*(-1)+(-eta-1)*2*(eta-1));
    ddsfxieta(4)=(1/16)*((xi-1)^2*(-1)+(-xi-1)*(2)*(xi-1))*((eta-1)^2*(-1)+(-eta-1)*2*(eta-1));
    ddsfxieta(5)=(1/16)*((xi+1)^2+(xi-2)*(2)*(xi+1))*((eta-1)^2*(-1)+(-eta-2)*2*(eta-1));
    ddsfxieta(6)=(-1/16)*((xi+1)^2+(xi-1)*(2)*(xi+1))*((eta-1)^2*(-1)+(-eta-2)*2*(eta-1));
    ddsfxieta(7)=(1/16)*((xi+1)^2+(xi-2)*(2)*(xi+1))*((eta-1)^2*(-1)+(-eta-1)*2*(eta-1));
    ddsfxieta(8)=(-1/16)*((xi+1)^2+(xi-1)*(2)*(xi+1))*((eta-1)^2*(-1)+(-eta-1)*2*(eta-1));
    ddsfxieta(9)=(1/16)*((xi+1)^2+(xi-2)*(2)*(xi+1))*((eta+1)^2+(eta-2)*2*(eta+1));
    ddsfxieta(10)=(-1/16)*((xi+1)^2+(xi-1)*(2)*(xi+1))*((eta+1)^2+(eta-2)*2*(eta+1));
    ddsfxieta(11)=(-1/16)*((xi+1)^2+(xi-2)*(2)*(xi+1))*((eta+1)^2+(eta-1)*2*(eta+1));
    ddsfxieta(12)=(1/16)*((xi+1)^2+(xi-1)*(2)*(xi+1))*((eta+1)^2+(eta-1)*2*(eta+1));
    ddsfxieta(13)=(1/16)*((xi-1)^2*(-1)+(-xi-2)*(2)*(xi-1))*((eta+1)^2+(eta-2)*2*(eta+1));
    ddsfxieta(14)=(1/16)*((xi-1)^2*(-1)+(-xi-1)*(2)*(xi-1))*((eta+1)^2+(eta-2)*2*(eta+1));
    ddsfxieta(15)=(-1/16)*((xi-1)^2*(-1)+(-xi-2)*(2)*(xi-1))*((eta+1)^2+(eta-1)*2*(eta+1));
    ddsfxieta(16)=(-1/16)*((xi-1)^2*(-1)+(-xi-1)*(2)*(xi-1))*((eta+1)^2+(eta-1)*2*(eta+1));
    
    
    
    dsfeta(1)=(1/16)*(xi-1)^2*(-xi-2)*((eta-1)^2*(-1)+(-eta-2)*(2)*(eta-1));
    dsfeta(2)=(1/16)*(xi-1)^2*(-xi-1)*((eta-1)^2*(-1)+(-eta-2)*(2)*(eta-1));
    dsfeta(3)=(1/16)*(xi-1)^2*(-xi-2)*((eta-1)^2*(-1)+(-eta-1)*(2)*(eta-1));
    dsfeta(4)=(1/16)*(xi-1)^2*(-xi-1)*((eta-1)^2*(-1)+(-eta-1)*(2)*(eta-1));
    dsfeta(5)=(1/16)*(xi+1)^2*(xi-2)*((eta-1)^2*(-1)+(-eta-2)*(2)*(eta-1));
    dsfeta(6)=(-1/16)*(xi+1)^2*(xi-1)*((eta-1)^2*(-1)+(-eta-2)*(2)*(eta-1));
    dsfeta(7)=(1/16)*(xi+1)^2*(xi-2)*((eta-1)^2*(-1)+(-eta-1)*(2)*(eta-1));
    dsfeta(8)=(-1/16)*(xi+1)^2*(xi-1)*((eta-1)^2*(-1)+(-eta-1)*(2)*(eta-1));
    dsfeta(9)=(1/16)*(xi+1)^2*(xi-2)*((eta+1)^2+(eta-2)*(2)*(eta+1));
    dsfeta(10)=(-1/16)*(xi+1)^2*(xi-1)*((eta+1)^2+(eta-2)*(2)*(eta+1));
    dsfeta(11)=(-1/16)*(xi+1)^2*(xi-2)*((eta+1)^2+(eta-1)*(2)*(eta+1));
    dsfeta(12)=(1/16)*(xi+1)^2*(xi-1)*((eta+1)^2+(eta-1)*(2)*(eta+1));
    dsfeta(13)=(1/16)*(xi-1)^2*(-xi-2)*((eta+1)^2+(eta-2)*(2)*(eta+1));
    dsfeta(14)=(1/16)*(xi-1)^2*(-xi-1)*((eta+1)^2+(eta-2)*(2)*(eta+1));
    dsfeta(15)=(-1/16)*(xi-1)^2*(-xi-2)*((eta+1)^2+(eta-1)*(2)*(eta+1));
    dsfeta(16)=(-1/16)*(xi-1)^2*(-xi-1)*((eta+1)^2+(eta-1)*(2)*(eta+1));
    
    ddsfeta(1)=(1/16)*(xi-1)^2*(-xi-2)*((-1)*(2)*(eta-1)+2*((-eta-2)+(eta-1)*(-1)));
    ddsfeta(2)=(1/16)*(xi-1)^2*(-xi-1)*((-1)*(2)*(eta-1)+2*((-eta-2)+(eta-1)*(-1)));
    ddsfeta(3)=(1/16)*(xi-1)^2*(-xi-2)*((-1)*(2)*(eta-1)+2*((-eta-1)+(eta-1)*(-1)));
    ddsfeta(4)=(1/16)*(xi-1)^2*(-xi-1)*((-1)*(2)*(eta-1)+2*((-eta-1)+(eta-1)*(-1)));
    ddsfeta(5)=(1/16)*(xi+1)^2*(xi-2)*((-1)*(2)*(eta-1)+2*((-eta-2)+(eta-1)*(-1)));
    ddsfeta(6)=(-1/16)*(xi+1)^2*(xi-1)*((-1)*(2)*(eta-1)+2*((-eta-2)+(eta-1)*(-1)));
    ddsfeta(7)=(1/16)*(xi+1)^2*(xi-2)*((-1)*(2)*(eta-1)+2*((-eta-1)+(eta-1)*(-1)));
    ddsfeta(8)=(-1/16)*(xi+1)^2*(xi-1)*((-1)*(2)*(eta-1)+2*((-eta-1)+(eta-1)*(-1)));
    ddsfeta(9)=(1/16)*(xi+1)^2*(xi-2)*((2)*(eta+1)+2*((eta-2)+(eta+1)));
    ddsfeta(10)=(-1/16)*(xi+1)^2*(xi-1)*((2)*(eta+1)+2*((eta-2)+(eta+1)));
    ddsfeta(11)=(-1/16)*(xi+1)^2*(xi-2)*((2)*(eta+1)+2*((eta-1)+(eta+1)));
    ddsfeta(12)=(1/16)*(xi+1)^2*(xi-1)*((2)*(eta+1)+2*((eta-1)+(eta+1)));
    ddsfeta(13)=(1/16)*(xi-1)^2*(-xi-2)*((2)*(eta+1)+2*((eta-2)+(eta+1)));
    ddsfeta(14)=(1/16)*(xi-1)^2*(-xi-1)*((2)*(eta+1)+2*((eta-2)+(eta+1)));
    ddsfeta(15)=(-1/16)*(xi-1)^2*(-xi-2)*((2)*(eta+1)+2*((eta-1)+(eta+1)));
    ddsfeta(16)=(-1/16)*(xi-1)^2*(-xi-1)*((2)*(eta+1)+2*((eta-1)+(eta+1)));
    
else
 %% Shape functions of 8 node rectangular element
 
    sf(1)=(1/4)*(1-xi)*(1-eta)*(-1-xi-eta);
    sf(2)=(1/4)*(1+xi)*(1-eta)*(-1+xi-eta);
    sf(3)=(1/4)*(1+xi)*(1+eta)*(-1+xi+eta);
    sf(4)=(1/4)*(1-xi)*(1+eta)*(-1-xi+eta);
    sf(5)=(1/2)*(1-xi^2)*(1-eta);
    sf(6)=(1/2)*(1+xi)*(1-eta^2);
    sf(7)=(1/2)*(1-xi^2)*(1+eta);
    sf(8)=(1/2)*(1-xi)*(1-eta^2);
    
    
    dsfxi(1)=-(1/4)*(1-eta)*(-1-xi-eta)-(1/4)*(1-xi)*(1-eta);
    dsfxi(2)=(1/4)*(1-eta)*(-1+xi-eta)+(1/4)*(1+xi)*(1-eta);
    dsfxi(3)=(1/4)*(1+eta)*(-1+xi+eta)+(1/4)*(1+xi)*(1+eta);
    dsfxi(4)=-(1/4)*(1+eta)*(-1-xi+eta)-(1/4)*(1-xi)*(1+eta);
    dsfxi(5)=-xi*(1-eta);
    dsfxi(6)= -(1/2)*eta^2+1/2;
    dsfxi(7)=-xi*(1+eta);
    dsfxi(8)=(1/2)*eta^2-1/2;
    
    dsfeta(1)=-(1/4)*(1-xi)*(-1-xi-eta)-(1/4)*(1-xi)*(1-eta);
    dsfeta(2)=-(1/4)*(1+xi)*(-1+xi-eta)-(1/4)*(1+xi)*(1-eta);
    dsfeta(3)=(1/4)*(1+xi)*(-1+xi+eta)+(1/4)*(1+xi)*(1+eta);
    dsfeta(4)=(1/4)*(-1-xi+eta)*(1-xi)+(1/4)*(1-xi)*(1+eta);
    dsfeta(5)=(1/2)*xi^2-1/2;
    dsfeta(6)=-(1+xi)*eta;
    dsfeta(7)=-(1/2)*xi^2+1/2;
    dsfeta(8)= -(1-xi)*eta;
    
end

% Calculate Jacobian matrix and its determinant

rj=zeros(2,2);

N=zeros(3,2);
for i=1:npe
    
    rj(1,1)= rj(1,1) + dsfxiL(i)*el_x(i);
    rj(1,2)= rj(1,2) + dsfxiL(i)*el_y(i);
    rj(2,1)= rj(2,1) + dsfetaL(i)*el_x(i);
    rj(2,2)= rj(2,2) + dsfetaL(i)*el_y(i);
    
    
    
end   
J=det(rj);
rjinv = inv(rj);

GGJ=[(rj(1,1))^2, (rj(1,2))^2,2*rj(1,1)*rj(1,2);
    (rj(2,1))^2,(rj(2,2))^2, 2*rj(2,1)*rj(2,2);
    rj(1,1)*rj(2,1),rj(1,2)*rj(2,2),rj(1,1)*rj(2,2)+rj(2,1)*rj(1,2)];
GGJinv=inv(GGJ);

for i=1:npea
    dsfx(i) = rjinv(1,1)*dsfxi(i)+rjinv(1,2)*dsfeta(i);
    dsfy(i) = rjinv(2,1)*dsfxi(i)+rjinv(2,2)*dsfeta(i);
end

N=zeros(3,2);
for i=1:npe 
    N(1,1)= N(1,1) + ddsfxiL(i)*el_x(i);
    N(1,2)= N(1,2) + ddsfxiL(i)*el_y(i);
    N(2,1)= N(2,1) + ddsfetaL(i)*el_x(i);
    N(2,2)= N(2,2) + ddsfetaL(i)*el_y(i);
    N(3,2)= N(3,2) + ddsfxietaL(i)*el_x(i);
    N(3,2)= N(3,2) + ddsfxietaL(i)*el_y(i);
    
end
for i=1:npea
    ddsfx(i)= GGJinv(1,1)*(ddsfxi(i)-(N(1,1)*dsfx(i)+N(1,2)*dsfy(i)))...
        +GGJinv(1,2)*(ddsfeta(i)-(N(2,1)*dsfx(i)+N(2,2)*dsfy(i)))...
        +GGJinv(1,3)*(ddsfxieta(i)-(N(3,1)*dsfx(i)+N(3,2)*dsfy(i)));
    ddsfy(i)= GGJinv(2,1)*(ddsfxi(i)-(N(1,1)*dsfx(i)+N(1,2)*dsfy(i)))...
        +GGJinv(2,2)*(ddsfeta(i)-(N(2,1)*dsfx(i)+N(2,2)*dsfy(i)))...
        +GGJinv(2,3)*(ddsfxieta(i)-(N(3,1)*dsfx(i)+N(3,2)*dsfy(i)));
    ddsfxy(i)=GGJinv(3,1)*(ddsfxi(i)-(N(1,1)*dsfx(i)+N(1,2)*dsfy(i)))...
        +GGJinv(3,2)*(ddsfeta(i)-(N(2,1)*dsfx(i)+N(2,2)*dsfy(i)))...
        +GGJinv(3,3)*(ddsfxieta(i)-(N(3,1)*dsfx(i)+N(3,2)*dsfy(i)));
end
table(ddsfx,ddsfy,ddsfxy)
end




