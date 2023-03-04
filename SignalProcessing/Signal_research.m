

% Chargement de l'audio
[y,Fs]=audioread('2_TP1.wav');



% Tracé du signal, on repère 10 bandes
Tp = (0:16383)/Fs';
figure(4),clf
plot(Tp,y)
grid;title('Signal');xlabel('Temps')



%% SOLUTION

% Récupération des intervalles de fréquences des bandes
interv = FindIntervalles(y,10);

% Chaque num correspond aux 2 fréquences (abscisse) qui permettent d'identifier le
% numéro à l'aide de la matrice de correspondance
num1 = FindFreq(y,Fs,interv(1,1),interv(1,2));          % 0
num2 =  FindFreq(y,Fs,interv(2,1),interv(2,2));         % 6
num3 =  FindFreq(y,Fs,interv(3,1),interv(3,2));         % 6
num4 =  FindFreq(y,Fs,interv(4,1),interv(4,2));         % 6
num5 = FindFreq(y,Fs,interv(5,1),interv(5,2));          % 1
num6 =  FindFreq(y,Fs,interv(6,1),interv(6,2));         % 5
num7 = FindFreq(y,Fs,interv(7,1),interv(7,2));          % 2
num8 =  FindFreq(y,Fs,interv(8,1),interv(8,2));         % 4
num9 =  FindFreq(y,Fs,interv(9,1),interv(9,2));         % 8
num10 =  FindFreq(y,Fs,12180,12820);                    % 9

function f=FindFreq(points,Fs,a,b)

    ecart=b-a;
    Y=fftshift(fft(points(a:b),ecart)); 

    freq=-ecart/2:(ecart/2)-1;
    freq=freq*Fs/ecart;

    % Plot du graphique
    %plot(freq,abs(Y));
    %axis([0 4000 0 max(Y)])

    [~,indices]=findpeaks(abs(Y),NPeaks=2,MinPeakDistance=5,MinPeakHeight=150);
    f=[abs(freq(indices(1))),abs(freq(indices(2)))];

end

function intervalles = FindIntervalles(y,nbBandes)
    intervalles = zeros(nbBandes,2);
    x = 1;
    for j = 2:length(y)-1
        if (y(j)~=0 && y(j-1)==0)
            intervalles(x,1) = j;
            
        end
        if (y(j)==0 && y(j-1)~=0)
            intervalles(x,2) = j;
            x = x+1;
        end
    end
end
