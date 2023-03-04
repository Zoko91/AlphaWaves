% TP2


% Chargement des données
for i=1:9
    eval(['Sujet',num2str(i) ' = load("Data/subject_0',num2str(i),'.mat");'])
end
for j=10 : 20 
    eval(['Sujet', num2str(j) ' = load("Data/subject_', num2str(j),'.mat");'])
end


% Test sur le sujet 1 électrode 16: Oz
S1_16 = GetMeanElect(Sujet1,16);
mean(S1_16(1:end,1)); % Yeux fermés moyenne des alphas: 77.7804
mean(S1_16(1:end,2)); % Yeux ouverts moyenne des alphas: 23.7573

% Etude intra individu
allElectrodes = GetMeanALLElect(Sujet1);

% ------ En abscisses on a yeux fermés yeux ouverts de chaque individu et
% en ordonnées les moyennes d'energie des pics 8-12hz (alphas) 
% des 17 electrodes (le temps en 0 + 16 electrodes) 

dataSet = zeros(17,40);
for p = 1:20
    
    sujet = eval(['Sujet',num2str(p)]);
    valeurs = GetMeanALLElect(sujet);
    dataSet(1:17,2*p-1) = valeurs(1:17,1);
    dataSet(1:17,2*p) = valeurs(1:17,2);
end

writematrix(dataSet)

% Calcule la moyenne des alphas avec les yeux fermés et ouverts
function meanElectrodes = GetMeanElect(structure,num)

    s = cell2mat(struct2cell(structure));

    % Récupération de l'indice 
    
    valo = zeros(5);
    x = 1;
    for i = 1:length(s)
        if (s(i,18)==1)
            valo(x) = i;
            x = x+ 1;
        end
    end

    valf = zeros(5);
    y = 1;
    for i = 1:length(s)
        if (s(i,19)==1)
            valf(y) = i;
            y = y+ 1;
        end
    end
   

    % 5120 valeurs pour 10 secondes
    Fs = 512; % 512 samples per seconds
    f = Fs*(0:(5120))/5120;
    idx = f>=8 & f<= 12;
    meanElectrodes = zeros(5,2);

    
    for k = 1:length(valo)

        E1= s(valo(k):valo(k)+5120,num);
        E2= s(valf(k):valf(k)+5120,num);

        sig1 = fft(normalize(E1));
        sig2 = fft(normalize(E2));

        sigg1 = abs(sig1); % Pour les yeux fermés
        sigg2 = abs(sig2); % Pour les yeux ouverts

        sampleSig1 = sigg1(idx);
        sampleSig2 = sigg2(idx);

        meanElectrodes(k,1) = mean(sampleSig1);
        meanElectrodes(k,2) = mean(sampleSig2);

    end
   
end

% Calcule la moyenne des alphas des yeux fermés et ouverts des electrodes
function allMeans = GetMeanALLElect(structure)

    allMeans = zeros(17,2);
    % 1ère ligne de zeros car temps
    for i = 1:16
        vals = GetMeanElect(structure,i+1);
        allMeans(i+1,1) = mean(vals(1:end,1));
        allMeans(i+1,2) = mean(vals(1:end,2));
    end

end

