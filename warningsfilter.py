import warnings

# This warning is raised from tensorflow v1.4 at import time.
# It's irrelevant and should be ignored.
warnings.filterwarnings('ignore', "compiletime version 3.5 of module 'tensorflow.python.framework.fast_tensor_util' does not match runtime version 3.6", category=RuntimeWarning)
