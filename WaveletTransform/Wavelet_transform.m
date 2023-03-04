% TP3

% Nettoyage
close all
clear

% Définition du signal
% Axe temporelle
t = linspace(0,1,2^12);
% Signal sinuzoïdale entre 0 et 1 seconde, 2^12 points
sinu = sin(2*pi*t);
figure(1)
plot(t,sinu)
xlabel("Temps en secondes");
ylabel("Signal sinuzoïdal");


% Définition du bruit blanc
Bruit = 0.5*randn(size(sinu));
Sig = sinu + Bruit;

% Plot du signal bruité
figure(2)
plot(t,Sig,'k');
xlabel("Temps en secondes");
ylabel("Signal sinuzoïdal bruité");

% Plot sur la même figure des 2 signaux précédents
hold on 
plot(t,sinu,'y')
hold off

% Transformée en ondelettes

Jmin = 1;
WTreg=perform_wavelet_transf(transpose(sinu),Jmin,1);
figure(3)
plot_wavelet(WTreg,Jmin)

% Représentations dyadiques
figure(4)
n=12;
subplot(2,2,1), sig1 = CreateDyad(n,sinu);     % Signal sinuzoidal
subplot(2,2,2), sig2 = CreateDyad(n,Bruit);    % Bruit
subplot(2,1,2), sig3 = CreateDyad(n,Sig);      % Signal bruité

% Seuillage et transformation inverse
thr = 2;    % Seuil
WTreg2=perform_wavelet_transf(transpose(Sig),Jmin,1);
ythard = wthresh(WTreg2,'h',thr);
invSig = perform_wavelet_transf(transpose(ythard),Jmin,-1);

figure(5)
plot(Sig,'k')
title("Seuil = 2")
hold on
h2 = plot(sinu,'y')
set(h2, 'LineWidth', 3)
h3 = plot(invSig,'b')
set(h3, 'LineWidth', 3)
hold off

%Génération nouveau signal y0 
N=4096;
name="piece-regular";
x0=load_signal(name,N);
x0=rescale(x0,0.05,0.95);
sigma=0.05;
y0=x0+randn(size(x0))*sigma;
figure(5)
plot(y0)
hold on 
plot(x0)
hold off
%Transformée en ondelettes y0
figure(6)
Jmin = 1;
WTreg=perform_wavelet_transf(transpose(y0),Jmin,1);
plot_wavelet(WTreg,Jmin)
