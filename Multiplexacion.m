
Fs=8000
f=4000;
n=(f+8000)/8000

for t=1:length(y2)
    x2(t)=real(y2(t))*cos(2*pi*4000*t);
end

for t=1:length(y3)
    x3(t)=real(y3(t))*cos(2*pi*8000*t);
end

RGB=real(y')+x2+x3;

Fourier=fftshift(fft(RGB));
f=linspace(-Fs/2,Fs/2,length(y));

Wp = [0.5 0.8];
Ws = [0.4 0.9];
Rp=20;
Rs=80;
[n,Wn] = buttord(Wp,Ws,Rp,Rs) ;
[b,a] = butter(n,Wn,'bandpass');


m = filter(b,a,RGB);
Fourier2=fftshift(fft(m));

figure(1)
subplot(211)
plot(f,Fourier)
subplot(212)
plot(f,Fourier2)

figure(2)
freqz(b,a)