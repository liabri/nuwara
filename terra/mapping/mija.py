#!/usr/bin/env python3

# output the percentage of blue pixels, aka water.

from PIL import Image
im = Image.open('final-indexed.png').convert('RGB')

water = 0
total = 0

for pixel in im.getdata():
	total += 1
	if pixel == (25,149,190):
		water += 1

fmija = round(((water/total)*100), 2)
print('water coverage: ' + str(fmija) + '%')