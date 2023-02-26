import numpy as np 
from scipy import fftpack
import matplotlib.pyplot as plt

# Create arbitary sin data with noise, 100 points per cycle 
time_step = 0.05
time_vec = np.arange(0,10, time_step)
period = 5 
sig = (np.sin(2*np.pi*time_vec/period) + 0.25 * np.random.randn(time_vec.size))

print(sig)

# # Perform Fast Fourier Transform
# sig_fft = fftpack.fft(sig)
# Amplitude = np.abs(sig_fft)
# Power = Amplitude**2
# Angle = np.angle(sig_fft)

# sample_freq = fftpack.fftfreq(sig.size, d=time_step)


# amp_freq = np.array([Amplitude, sample_freq])
# peak_freq = amp_freq[1, amp_freq[0:].argmax()]


# # Filter Signal (Time Domain)
# high_freq_fft = sig_fft.copy()
# high_freq_fft[np.abs(sample_freq) > peak_freq] = 0
# filtered_sig = fftpack.ifft(high_freq_fft)


# # Chart Time Domain
# plt.plot(time_vec,sig, label = "Original Signal")
# plt.plot(time_vec, filtered_sig, label = "Filtered Signal")
# plt.xlabel("Time (sec)")
# plt.ylabel("Amplitude")


# # Chart Frequency Domain
# # plt.plot(sample_freq,Amplitude)
# # plt.xlabel("Frequency (Hz)")
# # plt.ylabel("Amplitude")

# plt.legend()
# plt.show()


