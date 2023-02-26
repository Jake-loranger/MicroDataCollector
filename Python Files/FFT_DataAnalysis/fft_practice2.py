import numpy as np 
from scipy import fftpack
import matplotlib.pyplot as plt 

# Contrust time domian signal 

Fs = 2000           #sampling frequency
tstep = 1 / Fs      #sample time interval
f0 = 170            #signal freq
N = int(5 * Fs / f0)    #number of samples
fstep = Fs / N      #freq interval 

t = np.linspace(0, (N-1)*tstep, N)  #time steps
f = np.linspace(0, (N-1)*fstep, N)  #frequency steps

y = 1 * np.sin(2 * np.pi * f0 * t)   
#y = 1 * np.sin(2 * np.pi * f0 * t) + 4 * np.sin(2 * np.pi * 3 * f0 * t)   

# Perform FTT to convert to frequency domain

X = np.fft.fft(y)   #outputs complex numbers
X_mag = np.abs(X) / N

f_plot = f[0: int(N/2+1)] 
x_mag_plot = 2* X_mag[0: int(N/2+1)]
x_mag_plot[0] = x_mag_plot[0] /2 


# Display data
fig, [ax1, ax2] = plt.subplots(ncols= 1, nrows= 2)
ax1.plot(t, y, ".-")
ax2.plot(f_plot, x_mag_plot, ".-")
ax1.set_xlabel("time (sec)")
ax2.set_xlabel("freq (Hz)")
ax1.grid()
ax2.grid()
plt.show()
