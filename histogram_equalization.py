# These functions are useful for histogram equalization of images
# Source is this guy
# https://lmcaraig.com/image-histograms-histograms-equalization-and-histograms-comparison/

import cv2
from matplotlib import pyplot as plt

def show_grayscale_equalized(image):
    grayscale_image = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
    eq_grayscale_image = cv2.equalizeHist(grayscale_image)
    plt.imshow(eq_grayscale_image, cmap='gray')
    plt.show()


def show_rgb_equalized(image):
    channels = cv2.split(image)
    eq_channels = []
    for ch, color in zip(channels, ['B', 'G', 'R']):
        eq_channels.append(cv2.equalizeHist(ch))

    eq_image = cv2.merge(eq_channels)
    eq_image = cv2.cvtColor(eq_image, cv2.COLOR_BGR2RGB)
    plt.imshow(eq_image)
    plt.show()


def show_hsv_equalized(image):
    H, S, V = cv2.split(cv2.cvtColor(image, cv2.COLOR_BGR2HSV))
    eq_V = cv2.equalizeHist(V)
    eq_image = cv2.cvtColor(cv2.merge([H, S, eq_V]), cv2.COLOR_HSV2RGB)
    plt.imshow(eq_image)
    plt.show()
