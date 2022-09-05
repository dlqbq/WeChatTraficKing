import os

from os import listdir

def find_csv_filenames(path_to_dir, suffix=".csv" ):

    path_to_dir = os.path.normpath(path_to_dir)

    filenames = listdir(path_to_dir)

    #Check *csv directory

    fp = lambda f: not os.path.isdir(path_to_dir+"/"+f) and f.endswith(suffix)

    return [path_to_dir+"/"+fname for fname in filenames if fp(fname)]

def convert_files(files, ascii, to="utf-8"):

    for name in files:

        print("Convert {0} from {1} to {2}".format(name, ascii, to))

        with open(name) as f:

            for line in f.readlines():

                pass

                print(unicode(line, "cp866").encode("utf-8"))

csv_files = find_csv_filenames('./data/', ".csv")

convert_files(csv_files, "cp866") #cp866 is my ascii coding. Replace with your coding.