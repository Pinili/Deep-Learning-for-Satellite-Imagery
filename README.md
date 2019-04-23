# Identification of Invasive Plant Species from Satellite Imagery using a Machine Learning approach

This is an independent undergraduate thesis-project to classify <i>Rhamnus cathartica</i> utilising a deep learning model in Convolutional Neural Networks (CNN).

All coding dependencies and datasets in this project is published under UWSpace with the original paper titled:
<br>__Identification of Invasive Plant Species using a Machine Learning approach__. 

![Zoning Code Sample](https://github.com/Pinili/Deep-Learning-for-Satellite-Imagery/blob/master/1-classes.png)

| Included in this repository                   |
| --------------------------------------------- |
| IDL script to process Sentinel-2 datasets     |
| Python script to prepare IAS datasets for ML  |
| Jupyter notebook used to generate CNN tests   |

## IDL script to process Sentinel-2 datasets

The script takes each of the tile’s metadata file named “MTD_MSIL1C.xml”, located in the root directory of each folder, and reorganized each of the bands from resolution groups of 10m, 20m, and 60m to one giant bundle displayed on ENVI with a resolution of 10m.


## Python script to prepare IAS datasets for ML

The script takes variable inputs for the following:
- File directory containing the georeferenced image file to crop
- Shapefile containing all of the points to crop
- Radius of area to crop
- Output directory to store the cropped images
and outputs all cropped images to the output directory.

Requires this script in the same directory: https://www.arcgis.com/home/item.html?id=15ca63aebb4647a4b07bc94f3d051da5


## Jupyter notebook used to generate CNN tests

This notebook displays the short procedure used to:
1. Preprocess data
2. Efficiently train a quick model
3. Analysing results
4. Output predictions



