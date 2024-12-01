import os
import re
import string
import random

def filesave(instance, filename):
    path = 'products_image/'
    image = str(re.sub(r"\s+", "", instance.products_name.lower()))
    ext = "." + filename.split('.')[-1]
    randtext = ''.join(random.choice(string.ascii_letters) for i in range(15))
    filename_reformat = image + '-' + randtext + ext
    return os.path.join(path, filename_reformat)