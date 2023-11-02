import cv2 as cv
import numpy as np
import os

path = r'C:\dev\dip_project\images\4cam_splc\canong3_canonxt_sub_01.tif'

img = cv.imread(path)
if img is None:
    print("Image not found")
else:
    cv.imshow('Image', img)
    cv.waitKey(0)
    cv.destroyAllWindows()