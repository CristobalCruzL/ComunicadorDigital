%%%%%%%%%%%%%%%%%% 2 Recepción%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%% Grabacion %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

F=15000;
grabacion = audiorecorder(F,8,1);
soundsc(h,F);
disp('Empezar grabacion');
recordblocking(grabacion,2340900/F);
disp('Finalizo la grabacion ...');
%play(grabacion);
%d=audioread('transmision2.wav');% leer archivo grabado
%%%%%%%%%%%%%% Obtencion de datos %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%f_nyquist=F/2;
d=getaudiodata(grabacion);% recuperar vector del audio
%FFT=fft(fftshift(d));
%f=linspace(-F/2,F/2,length(d));

%%%%%%%%%%%%%%%%%%% Demodulacion %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

nsamp2=900;
Fs2=16000;
freq_sep1=1000;
freq_sep2=2000;
freq_sep3=500;

conv=fskdemod(d,8,freq_sep1,nsamp2,Fs2); %rojo
conv2 = fskdemod(d,8,freq_sep2,nsamp2,Fs); %verde
conv3 = fskdemod(d,8,freq_sep3,nsamp2,Fs); %azul

%%%%%%%%%%%%%%%%%Recomposicion de la señal%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

p=reshape(conv,51,51);
p1=reshape(conv2,51,51);
p2=reshape(conv3,51,51);


%%%%%%%%%%%% Graficos %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%figure(1)
%plot(f,abs(FFT))
%hold on
%plot(f,abs(FFT2))


%figure(2)
%subplot(121)
%imshow(p,[0 3])
%title('Imagen Recibida para la matriz R')
%impixelinfo
%subplot(122)
%imshow(B,[0 3])
%title('Imagen Transmitida para la matriz R')
%impixelinfo

%3 componentes juntas
figure(3)
subplot(131)
imshow(cat(3,p,p1,p2))
title('Imagen recibida')
subplot(132)
imshow(double(cat(3,B,C,D)))
title('Imagen Transmitida')
subplot(133)
imshow(cat(3,r(150:200,50:100,1),g(150:200,50:100,1),b(150:200,50:100,1)))
title('Imagen Original')

%%%%%%%%%%%%%%%% evaluación de la recepción %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

pixeles_enviados_vs_recibidas_1=[B==p];
porcentaje_de_acierto_rojo=sum(sum(pixeles_enviados_vs_recibidas_1))/(length(B)*length(B))

pixeles_enviados_vs_recibidas_2=[C==p1];
porcentaje_de_acierto_verde=sum(sum(pixeles_enviados_vs_recibidas_2))/(length(C)*length(C))

pixeles_enviados_vs_recibidas_3=[D==p2];
porcentaje_de_acierto_azul=sum(sum(pixeles_enviados_vs_recibidas_3))/(length(D)*length(D))
