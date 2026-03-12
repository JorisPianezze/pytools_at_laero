#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
CNRM, Université de Toulouse, Météo-France, CNRS, Toulouse, France
Created on 12 Avril 2020 - Marc Mandement - marc.mandement@meteo.fr
Script to modify the binary topography.dir file (tested on srtm_ne_250 and srtm_europe)
MODIFICATION
Q. Rodier 17/12/2020 : adapt to any topography .dir database.
"""

import matplotlib as mpl; mpl.use('Agg')
import matplotlib.pyplot as plt
import numpy as np
from mpl_toolkits.axes_grid1 import AxesGrid

def truncate_colormap(cmap, minval=0.0, maxval=1.0, n=100):
   n_cm = mpl.colors.LinearSegmentedColormap.from_list('trunc({n},{a:.2f},{b:.2f})'.format(n=cmap.name, a=minval, b=maxval),cmap(np.linspace(minval, maxval, n)))
   return n_cm

# Warning : the topography file are usually heavy and need > 4Go RAM memory
directory='/home/rodierq/RELIEF/' # Your directory
file=directory+'srtm_europe.dir'  # The topography file

with open(file, 'rb') as f:
   raw_data=np.fromfile(f,dtype='i2')

#Read the database
data=raw_data.reshape((18000,18000)) #This numbers must match the rows and cols written in the .hdr file
data=data[::-1,::] #Inverse coordinates Y X
modified_data=np.copy(data)

# Subset you are interested in (being plotted later), to decrease memory usage and plot
modified_data=data[3000:7000,5000:9000] #Here is an example of south-west France over the Pyrenees

#Initial data in the subdomain for plot
initial_data_sub=np.copy(modified_data)
#
#
# MODIFY YOUR OROGRAPHY HERE
#
#
modified_data[:750,:] = 250. #Example of erase the Pyrenees
#
#

# Plot before and after modification
cmap = truncate_colormap(plt.get_cmap('terrain'), 0.2, 1)
cmap.set_under('lightblue')

# Limit values of contour plot
vmin,vmax=0,2500

fig = plt.figure(figsize=(12,9))
ax = AxesGrid(fig, 111, nrows_ncols=(2,1),axes_pad=0.05,cbar_location="right",cbar_mode="single",cbar_size="4%",cbar_pad=0.4)

ax[0].contourf(initial_data_sub,np.linspace(vmin,vmax,41),cmap=cmap,vmin=vmin,vmax=vmax,extend='both')
bb=ax[1].contourf(modified_data,np.linspace(vmin,vmax,41),cmap=cmap,vmin=vmin,vmax=vmax,extend='both')
ax[0].set_title("Before and after modification",fontsize=25)
ax[0].tick_params(axis='both',labelsize=20) ; ax[1].tick_params(axis='both',labelsize=20)

#Colorbar
cbar=plt.colorbar(bb, cax = ax.cbar_axes[0])
cbar.ax.tick_params(labelsize=25)

fig.tight_layout()
fig.savefig(directory+"Orography.png")
plt.close()

#Write the modified orography
file_modified=directory+'srtm_europe_modif.dir'
raw_data.tofile(file_modified)
