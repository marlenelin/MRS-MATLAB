===version functionalities===
vis app 1.0
+ ppt
- drift adjust
- log scaling

==inputapp==
1. CHANGE the current folder to the folder containing all 3 .mlapp
1. TYPE 'inputapp' 
2. ADJUST parameters in the input fields
3. SELECT the reconstruction data file (.mat)
4. SELECT display
The display app would pop up momentarily
(WARNING: Select data from the dataset folder directly to ensure all files generated get saved correctly to the dataset folder)

==displayapp==
1. ADJUST Scale w.r.t., Slice #, MetMap
2. SELECT Save under the Slice view radio button groups
All-slice views w.r.t. metmap NAA Cho Cre30 Cre39 Glx mi would be saved

3. SELECT either Single-voxel intensity or contour in Spectrum view
4. ADJUST the fields/color schemes under Parameters
6. CHECK log scale for log scaling contour lines/data
7. CLICK the single slice plot to select pixel (Slice view >> Single)
The spectrum plot of the selected pixel gets updated and displayed automatically

8. SELECT save/pop-out right next to the log scale checkbox
The single voxel spectrum diagram gets saved/displayed in a separate window

9. SELECT Multi-voxel(contour) in Spectrum view
10. INPUT the row and column range for ROI
11. SELECT Generate
The multivoxel view/save app would pop up

==multiapp==
1. CHECK the slices that you want to view/save
2. ADJUST color schemes
3. SELECT view
Multivoxel contour plots get displayed in separate windows (full-screen)

4. SELECT Save Format
5. SELECT Save
Multivoxel contours saved as either TIP, PDF, or PPT.
(WARNING: Selecting the PPT means the metmaps from earlier would be attached after the multivoxel contour, along with the dataset info, pdf only saves the multivoxel plots)




===LIST OF KNOWN BUGS===
1. Fail to apply separate colormaps to different axes within the same matlab UIFigure; only happens when you click the single-vox graph: the colormap of the slice view becomes identical to the one used in the spectrum view
(the option doesn't seem to be availble with the current matlab (2021), not really sure how i did it in the first place https://www.mathworks.com/matlabcentral/answers/100497-how-can-i-apply-different-colormaps-to-different-axes-on-the-same-figure-in-matlab)

2. Adjustment map
(possible solution: shift in time domain then transform to frequency domain)
For now, I have restored the two adjust fields and the autocalculation part.

3. Log scaling not applied yet
Code section between ====LOG SCALE ===== UNDER CONSTRUCTION ====
(possible: need to readjust CLim)

4. regex for dataset info images
current fix, fix with regard to roi.JPG, loc.png, shim,png, shim.JPG

5.background colornot working after switching back to single from save all metmap

6.cancel handling for closing the param file selection window (load, save params)



===Trivial?===
1. Figure window pops up
Due to calling the colormap(colormap name) function, i believe
(i seem to fix it but there would be a slight glitch when you try to set the background for the single vox graph)
(also if afterwards matlab no longer display images with imshow, plot from the command line, try
set(0,'DefaultFigureVisible','on');)

2. dataset folder names
for now the regex only works with the numeric-only dataset (no month included, there is one with 'Aug' in the folder name, it would not work)

3.template ppt 
C:\Users\athomas\Documents\MATLAB\Merlin_codes\powerpoints\generate-template.pptx 




==ver1.2==
Dr.Joy
===ver1.3==
export data function (checked. how to verify single voxel data)
fix shift adjust