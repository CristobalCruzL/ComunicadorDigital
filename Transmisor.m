%%%%%%%%%%%%%%%%%%%%%%% 1 Transmisión %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%% 1.1 Leer imágen y obtener las matrices RGB%%%%%%%%%%%%%

A=imread('camaleon.png');%cargar imagen
imshow(A)
impixelinfo

r = A(:,:,1); % Obtener la matriz roja
g = A(:,:,2); % Obtener la matriz verde
b = A(:,:,3); % Obtener la matriz azul

%%%%%%%%%%%% 1.2 crear series de datos binarias %%%%%%%%%%%%%%%%%%%%%%%%%%

B=r(150:200,50:100,1);%%Parte de la imagen roja
C=g(150:200,50:100,1);%%Parte de la imagen verde 
D=b(150:200,50:100,1);%%Parte de la imagen azul

%%%%%%%%%%Aqui se pasa la imagen de 256 posibles intensidades a 4 posibles.

for i=1:length(B)
    for j=1:length(B)
       if B(i,j)<=64
            B(i,j)=0;
        elseif B(i,j)<=128 & B(i,j)>64
            B(i,j)=1;
        elseif B(i,j)<=192 & B(i,j)>128
            B(i,j)=2;
        else
            B(i,j)=3;
        end
    end
end

for i=1:length(C)
    for j=1:length(C)
       if C(i,j)<=64
            C(i,j)=0;
        elseif C(i,j)<=128 & C(i,j)>64
            C(i,j)=1;
        elseif C(i,j)<=192 & C(i,j)>128
            C(i,j)=2;
        else
            C(i,j)=3;
        end
    end
end

for i=1:length(D)
    for j=1:length(D)
       if D(i,j)<=64
            D(i,j)=0;
        elseif D(i,j)<=128 & D(i,j)>64
            D(i,j)=1;
        elseif D(i,j)<=192 & D(i,j)>128
            D(i,j)=2;
        else
            D(i,j)=3;
        end
    end
end

%%%%%%%%%%%%% modulación FSK %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

nsamp=900;
Fs=16000;
M=8;
freq_sep1=1000;
freq_sep2=2000;
freq_sep3=500;

u=reshape(B,2601,1);%roja
u2=reshape(C,2601,1);%verde
u3=reshape(D,2601,1);%azul

y = fskmod(u,M,freq_sep1,nsamp,Fs); %roja
y2 = fskmod(u2,M,freq_sep2,nsamp,Fs); %verde
y3 = fskmod(u3,M,freq_sep3,nsamp,Fs); %azul

T=y+y2+y3;
h=real(T);
%soundsc(h);
Fsampling=8000;
audiowrite('transmision2.wav',h,Fsampling);

%FFT2=fft(fftshift(y));
%f2=linspace(-Fs/2,Fs/2,length(y));
%FFT3=fft(fftshift(y2));
%f3=linspace(-Fs/2,Fs/2,length(y2));
%FFT4=fft(fftshift(y3));
%f4=linspace(-Fs/2,Fs/2,length(y3));
%FFT5=fft(fftshift(T));
%f5=linspace(-Fs/2,Fs/2,length(T));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Gráficos %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%axis([-1 50 -2 2])
%grid on

%figure(1)
%subplot(131)
%imshow(B,[0 3])
%grid on
%title('matriz R')
%subplot(132)
%imshow(C,[0 3])
%grid on
%title('matriz G')
%subplot(133)
%imshow(D,[0 3])
%grid on
%title('matriz B')
%impixelinfo
%3 componentes juntas
%figure(4)
%imshow(cat(3,B,C,D),[0 3]);

%figure(2)
%subplot(411)
%plot(f2,abs(FFT2))
%grid on
%subplot(412)
%plot(f3,abs(FFT3))
%grid on
%subplot(413)
%plot(f4,abs(FFT4))
%grid on
%subplot(414)
%plot(f5,abs(FFT5))
%grid on



