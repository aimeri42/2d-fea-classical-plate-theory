% ===================
% 2-D FEM
% ME7620: ADV FINITE ELEMENT ANALYSIS
% Astrit Imeri - T00249444
% % ===================
% ncon - connectivity array
% ndfn - number of unknowns (d.o.f) per node
% nelem - number of elements 
% nnod - number of nodes
% nnbc, nebc: number of known NBC and EBC
% inbc,iebc: location of known NBC and EBC
% vnbc,vebc: values of known NBC and EBC
%ntype - 1: 2nd order ODE, 2: 4th order ODE
%nfunc - 1: linear 2: quadratic
%type - 1 if triangular element, 2 if quadrilateral
%gk - global coefficient matrix, gf- global right hand side vector
clear all;
clc;
% Call the input file
%input_file_2d

q2c_c_2x4
%  split_test

npea=16
if type==1 
%     npe=3;
%     if ntype==2
%          ndfn=3;
%     else
%          ndfn=1;
%     if nfunc==2
%           npe=6;
%     end
%     end
else 
    npe=4;
    if ntype==2

    else
        ndfn=4;
    end
end


% End reading data

% Calculate number of total equations to solve

neq = nnod*ndfn;
g_k = zeros(neq,neq);
g_f = zeros(neq,1);
el_x = zeros(npe,1);
el_y = zeros(npe,1);
sx_c=zeros(nelem,1);
sy_c=zeros(nelem,1);
sxy_c=zeros(nelem,1);
xc_c=zeros(nelem,1);
yc_c=zeros(nelem,1);


% Start loop over number of elements to calculate the element matrices
% and assemble them into the global matrices
%

for n=1:nelem
    
    for i=1:npe
        el_x(i) = x(ncon(n,i));
        el_y(i) = y(ncon(n,i));   
    end
 
    el_x;
    el_y;
    if type==1
    [el_k,el_f] = elkk2d(npe,fc,el_x,el_y,ey,ex);

    else
         [el_k,el_f] = el_kk_plate(D,NU,ntype,npe,fc,el_x,el_y,nfunc,ndfn);
    end
    % Assembly
    for i = 1:npe
        nr = (ncon(n,i)-1)*ndfn;
        for ii = 1:ndfn
  nr = nr + 1;
            l = (i-1)*ndfn+ii;
            g_f(nr) = g_f(nr)+el_f(l);
            for j = 1:npe
                nc = (ncon(n,j)-1)*ndfn;
                for jj = 1:ndfn
                    m = (j-1)*ndfn+jj;
                    nc = nc+1;
                    g_k(nr,nc)=g_k(nr,nc)+el_k(l,m);
                end
            end
        end
    end
end

% Apply known forces

for n = 1:nnbc
     nb = inbc(n);
     g_f(nb) = g_f(nb)+vnbc(n);
 end

% Apply known displacements (1-0) method

for nj = 1:nebc
    j = iebc(nj);
    for k=1:neq
        if k~=j
            g_f(k) = g_f(k)-g_k(k,j)*vebc(nj);
            g_k(k,j) = 0;
            g_k(j,k) = 0;
        else
            g_k(j,j) = 1;
            g_f(j) = vebc(nj);
        end
    end
end
sol = g_k\g_f

xx=zeros(nnod,1);yy=xx;
for gnode=1:nnod
    xx(gnode)=x(gnode)+10^2*sol((gnode-1)*ndfn+1);
    yy(gnode)=y(gnode)+10^2*sol((gnode-1)*ndfn+2);
end


sigmax=zeros(nnod,1);
sigmay=zeros(nnod,1);
sigmaxy=zeros(nnod,1);
sw=zeros(nnod,1);
for n=1:nelem
    eta=0.0;
    xi=0.0;
    
    
    for i=1:npe
        nn=ncon(n,i);
        
        el_x(i)=x(nn);
        el_y(i)=y(nn);
        
     for j=1:ndfn
            el_w((i-1)*ndfn+j)=sol((nn-1)*ndfn+j);
        end

        
    end
    
   [sf,sfL,dsfx,dsfy,J,ddsfx,ddsfy,ddsfxy]=shape_2d_plate(nfunc,npea,npe,xi,eta,el_x,el_y)
    
    sx=0.0;
    sy=0.0;
    sxy=0.0;
    
    xc=0;
    yc=0;
 
  for i=1:npea
        sx=sx-C(1,1)*h*el_w(i)*ddsfx(i)-C(1,2)*h*el_w(i)*ddsfy(i);
        sy=sy-C(1,2)*h*el_w(i)*ddsfx(i)-C(2,2)*h*el_w(i)*ddsfy(i);
        sxy=sxy-C(3,3)*2*h*el_w(i)*ddsfxy(i);
  end 
     
    xc=0;
    yc=0;  
       for i=1:npe
        xc=xc+el_x(i)*sfL(i);
        yc=yc+el_y(i)*sfL(i);
         
    end
         
        xcc(n)=xc;
    ycc(n)=yc;
    
    sigmax_c(n)=sx;
    sigmay_c(n)=sy;
    sigmaxy_c(n)=sxy;
    
        for k=1:npe
        npk=ncon(n,k);
        xk = el_x(k);
        yk = el_y(k); 
        
        weight=1/(sqrt((xc-xk)^2+(yc-yk)^2));
        sigmax(npk)=sigmax(npk)+weight*sx;
        sigmay(npk)=sigmay(npk)+weight*sy;
        sigmaxy(npk)=sigmaxy(npk)+weight*sxy;
        
        sw(npk)=sw(npk)+weight;
    end
    end



for i=1:nnod
    sigmax(i)=sigmax(i)/sw(i);
    sigmay(i)=sigmay(i)/sw(i);
    sigmaxy(i)=sigmaxy(i)/sw(i);
    
    
end
svm=zeros(nnod,1);
for i=1:nnod
    sigma=[sigmax(i), sigmaxy(i);
        sigmaxy(i),sigmay(i)];
    sigmap=eig(sigma);
    if sigmap(1) > sigmap(2)
        svm(i)=sigmap(1);
    else
        svm(i)=sigmap(2);
    end
end
sol1 = sol(1:2:end);



TT1=table(x,y,sigmax,sigmay,sigmaxy);
TT1

% stress at the center
TT2=table((xcc)',(ycc)',(sigmax_c)',(sigmay_c)',(sigmaxy_c)');
TT2

TT3=table(sol);
TT3

