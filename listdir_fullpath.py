# This function returns the full path
# It tries to be an analogous of list.files in R...still work to do

import os
import numpy as np

def listdir_fullpath(root_dir, file_pattern=None, file_extension=None, exclude_dir = True):

    # Get everything
    if file_extension is None:
        file_list  = [os.path.join(root_dir, files) for files in os.listdir(root_dir)]
    else:
        file_list = [os.path.join(root_dir, files) for files in os.listdir(root_dir) if files.endswith(file_extension)]
    if file_pattern is not None:
            file_list = [file for file in file_list if file_pattern in file]
    if len(file_list) > 0:
        if exclude_dir:
            files_to_keep = np.bitwise_not(list(map(os.path.isdir, file_list)))
            file_list = np.array(file_list)[files_to_keep]
            file_list = file_list.tolist()

    return sorted(file_list)