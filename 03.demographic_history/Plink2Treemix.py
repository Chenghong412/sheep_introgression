# -*- coding: utf-8 -*-
#!/usr/bin/env python3

import sys,os,logging,click
import gzip

logging.basicConfig(filename='{0}.log'.format(os.path.basename(__file__).replace('.py','')),
                    format='%(asctime)s: %(name)s: %(levelname)s: %(message)s',level=logging.DEBUG,filemode='w')
logging.info(f"The command line is:\n\tpython3 {' '.join(sys.argv)}")

@click.command()
@click.option('-i','--input',type=str,help='The input file',required=True)
@click.option('-o','--output',type=str,help='The output file',required=True)
def main(input,output):
    Input = gzip.open(input,'rt')
    Output = gzip.open(f'{output}.gz',"wt")
    Input.readline()
    Header = False
    PopList,AlleleList = [],[]
    for line in Input:
        line = line.strip().split()
        if line[2] not in PopList : 
            PopList.append(line[2])
            AlleleList.append(f'{line[6]},{int(line[7])-int(line[6])}')
        elif line[2] == PopList[0] and Header == False :
            HeaderLine = ' '.join(PopList)
            Output.write(f'{HeaderLine}\n')
            Header = True
            Allele = ' '.join(AlleleList)
            Output.write(f'{Allele}\n')
            AlleleList = []
            AlleleList.append(f'{line[6]},{int(line[7])-int(line[6])}')
        elif line[2] == PopList[0] and Header == True :
            Allele = ' '.join(AlleleList)
            Output.write(f'{Allele}\n')
            AlleleList = []
            AlleleList.append(f'{line[6]},{int(line[7])-int(line[6])}')
        else: AlleleList.append(f'{line[6]},{int(line[7])-int(line[6])}')
    Allele = ' '.join(AlleleList)
    Output.write(f'{Allele}\n')
if __name__ == '__main__':
    main()
