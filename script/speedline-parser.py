# speedline-prser.py
# author: bashow
# 2020/03/18

import sys

def is_float(parameter):
    try:
        float(parameter)
        return True
    except ValueError:
        return False


def speedline_to_json(speedline, jsonpath):

    with open(speedline, 'r') as fsl:
        read_data = fsl.readlines()


    with open(jsonpath, 'w') as fjson:
        fjson.write('{')
        fjson.write('\n')
        for index in read_data:

            if ( index != '\n' ):
                list = index[:-1].split(': ', 1)
                fjson.write('"' + list[0].replace(' ', '_') + '": ')

                if ( is_float(list[1]) ):
                    if (list[1] != 'NaN'):
                        fjson.write(list[1])
                    else:
                        fjson.write('"' + list[1] + '"')

                else:
                    fjson.write('"' + list[1].replace(' ', '') + '"')

                if (index != read_data[-1]):
                    fjson.write(',')

                fjson.write('\n')

        fjson.write('}')

if __name__ == '__main__':

    args = sys.argv
    if len(sys.argv) == 3:
            speedline_to_json(args[1], args[2])
    else:
        # print('No argument')
        sys.exit()
