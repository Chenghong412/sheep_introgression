import sys
# usage
USAGE = "\nusage: python convert_fasta2phylip.py [input fasta file] [output phy file]\n"
def parseFasta(filename):
    fas = {}
    id = None
    with open(filename, 'r') as fh:
        for line in fh:
            if line[0] == '>':
                header = line[1:].rstrip()
                id = header.split()[0]
                fas[id] = []
            else:
                fas[id].append(line.rstrip())
        for id, seq in fas.iteritems():
            fas[id] = ''.join(seq)
    return fas
if len(sys.argv) !=3:
    print USAGE
    sys.exit()
fas = parseFasta(sys.argv[1])
outfile = sys.argv[2]
sequence_list = [] # To keep order of sequence
sequence_dict = {}
for rec in fas:
    sequence_list.append(rec)
    sequence_dict[rec] = fas[rec]
# Test length of the alignment:
alignment_length = 0
for gene in sequence_dict:
    if (alignment_length != 0) and (len(sequence_dict[gene]) != alignment_length):
        print "Error in alignment length, exit on error !!!"
        sys.exit()
    else:
        alignment_length = len(sequence_dict[gene])
number_of_seq = len(sequence_dict)
longest_id = sorted(sequence_dict.keys(), key = lambda k: len(k))[-1]
# Write alignment in Phylip format
phyfile = open(outfile, "w")
phyfile.write(str(number_of_seq)+" "+str(alignment_length)+"\n")
for gene in sequence_list:
    phyfile.write(gene.ljust(len(longest_id), ' ') + "   " + sequence_dict[gene] + "\n")
phyfile.close()
