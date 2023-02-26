import matplotlib.pyplot as plt 
import numpy as np
import pandas as pd 
from scipy import fftpack
import csv

# Parces data from csv into lists

fileName = "/Users/jacobloranger/Desktop/12Mouth2.csv"
with open(fileName) as csvfile: 
    time = [] 
    amplitude = [] 
    reader = csv.reader(csvfile)
    counter = 0

    for row in reader: 
        if counter >= 1: 
            time.append(float(row[1]))
            amplitude.append(float(row[0]))
        counter += 1

#Performs fast fourier transform

y_fft = np.fft.fft(amplitude)
Y_mag = np.abs(y_fft) / len(time)
x_fft = fftpack.fftfreq(len(amplitude), d=0.1)


# Plots time domian and freq domain data

fig, [ax1, ax2] = plt.subplots(ncols= 1, nrows= 2)
ax1.plot(time,amplitude)
ax2.plot(x_fft, Y_mag)
ax1.set_xlabel("time (sec)")
ax2.set_xlabel("freq (Hz)")
ax2.set_xlim(-5, 5)
ax2.set_ylim(0,10)
ax1.grid()
ax1.set_xticks(np.arange(0, 30, 5))
ax2.grid()
plt.show()