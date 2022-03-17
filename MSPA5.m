close all
clc
clear all
set(0,'DefaultFigureWindowStyle','docked')
% This example shows how to calculate and plot both the
% fundamental TE and TM eigenmodes of an example 3-layer ridge
% waveguide using the full-vector eigenmode solver.  

% Refractive indices:
n1 = 3.34;          % Lower cladding
% n2 = 3.44;          % Core
n2 = linspace(3.305,3.44,10);
n3 = 1.00;          % Upper cladding (air)

% Layer heights:
h1 = 2.0;           % Lower cladding
h2 = 1.3;           % Core thickness
h3 = 0.5;           % Upper cladding

% Horizontal dimensions:
rh = 1.1;           % Ridge height
rw = 1.0;           % Ridge half-width
% rw = linspace(0.325,1,10);
side = 1.5;         % Space on side

% Grid size:
dx = 0.0125;        % grid size (horizontal)
dy = 0.0125;        % grid size (vertical)

lambda = 1.55;      % vacuum wavelength
nmodes = 1;         % number of modes to compute

for k =1:length(n2)
    
    [x,y,xc,yc,nx,ny,eps,edges] = waveguidemesh([n1,n2(k),n3],[h1,h2,h3], ...
        rh,rw,side,dx,dy);
    
    % First consider the fundamental TE mode:

    [Hx,Hy,neff(k)] = wgmodes(lambda,n2(k),nmodes,dx,dy,eps,'000A');   %k=nmodes
    
%     fprintf(1,'neff = %.6f\n',neff);
    
    figure(k);
    subplot(121);
    contourmode(x,y,Hx);
    title('Hx (TE mode)'); xlabel('x'); ylabel('y');
    for v = edges, line(v{:}); end
    
    subplot(122);
    contourmode(x,y,Hy);
    title('Hy (TE mode)'); xlabel('x'); ylabel('y');
    for v = edges, line(v{:}); end
    
    % Next consider the fundamental TM mode
    % (same calculation, but with opposite symmetry)
    
%     [Hx,Hy,neff] = wgmodes(lambda,n2,k,dx,dy,eps,'000S');
%     
%     fprintf(1,'neff = %.6f\n',neff);
%     
% %     figure(k+1);
%     subplot(223);
%     contourmode(x,y,Hx(:,:,k));
%     title('Hx (TM mode)'); xlabel('x'); ylabel('y');
%     for v = edges, line(v{:}); end
%     
%     subplot(224);
%     contourmode(x,y,Hy(:,:,k));
%     title('Hy (TM mode)'); xlabel('x'); ylabel('y');
%     for v = edges, line(v{:}); end

end

figure(length(n2)+1);
plot(n2,neff);
xlabel('n2')
ylabel('neff')
title('n2 VS neff')