function [el_k,el_f] = el_kk_plate(D,NU,ntype,npe,fc,el_x,el_y,nfunc,ndfn);
 
% Gauss points array
gauss = [0.0,-1/sqrt(3),-sqrt(3/5),-0.86113631;0.0,1/sqrt(3),0.0,...
    -0.33998104;0.0,0.0,sqrt(3/5),0.33998104;0.0,0.0,0.0,0.86113631];
% Gauss weights array

weight = [2.0,1.0,5/9,0.34785485;0.0,1.0,8/9,0.65214515;...
    0.0,0.0,5/9,0.65214515;0.0,0.0,0.0,0.34785485];
% Gauss points array for quad element 4 nodes

ngp=4;
npea=16;

el_f = zeros(npea,1);
el_k = zeros(npea,npea);

for ngi =1:ngp 
    for ngj =1:ngp
     xi = gauss(ngi,ngp);
    eta = gauss(ngj,ngp);
    
[sf,sfL,dsfx,dsfy,J,ddsfx,ddsfy,ddsfxy]=shape_2d_plate(nfunc,npea,npe,xi,eta,el_x,el_y)
%
    for i=1:npea
        el_f(i) = el_f(i)+fc*sf(i)*weight(ngi,ngp)*J*weight(ngj,ngp);
    end
    
    if ntype==1
        for i=1:npea
            for j=1:npea
                el_k(i,j) = el_k(i,j)+(D*ddsfx(i)*ddsfx(j)...
                    +D*NU*ddsfx(i)*ddsfy(j)...
                    +2*D*(1-NU)*ddsfxy(i)*ddsfxy(j)...
                    +D*NU*ddsfy(i)*ddsfx(j)...
                    +D*ddsfy(i)*ddsfy(j))...
                            *J*weight(ngi,ngp)*weight(ngj,ngp);
            end
        end
    end
    
end
end
end


