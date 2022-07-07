#!/usr/bin/env python

##############################
# @author: Jamie Farquharson #
# farquharson@jvolcanica.org #
##############################

# coding: utf-8

import sys
import argparse
from urllib.request import Request, urlopen
import os
import re

import bibtexparser
from bibtexparser.bparser import BibTexParser

from string import punctuation

###############################################################################

def create_url_list(input_file):
    '''
    Reads text bibliography and extracts any DOI numbers.
    Appends a url prefix to each doi number.
    '''
    from string import punctuation
    
    outfile = open('{}'.format(input_file))
    doi_list = []
    for line in outfile:
        if "doi" in line.lower():
            try:
                if line[line.find("10.")::].rstrip()[3] != ' ':
                    doi_list.append(line[line.find("10.")::].rstrip())
                    doi_list = [item.rstrip(punctuation) for item in doi_list]
            except:
                continue
    outfile.close()
    url_list = []
    for doi in doi_list:
        ### Need to escape brackets
        if '(' in doi:
            pre = doi[0:doi.find('(')]
            suff = doi[doi.find(')')+1::]
            mid = doi[doi.find('(')+1:doi.find(')')]
            url_list.append("https://dx.doi.org/"+pre+"\("+mid+"\)"+suff)
        elif '. ' in doi:
            url_list.append("https://dx.doi.org/"+doi[0:doi.find('. ')])
        else:
            url_list.append("https://dx.doi.org/"+doi)
    return url_list

###############################################################################

def create_bib_list(url_list, output_file):
    '''
    Downloads reference data from dx.doi.org according to the url passed to urllib.
    Appends to a .bib file.
    '''
    filename = output_file

    headers = dict(Accept='text/bibliography; style=bibtex')
    print("Writing bibtex entries to {}.bib...".format(output_file))

    for url in url_list:
        try:
            with open(filename + ".bib", "a+") as fp:
                req = Request(url, headers=headers)
                bibtext = urlopen(req).read().decode('utf-8')
                bibparser = BibTexParser()
                bibparser.ignore_nonstandard_types = False
                fp.write(print_string(bibtext, bibparser))
        except:
            continue

###############################################################################
'''
Disambiguate citekey with name of first author and year of publication.
'''

def sanitise_author(author):
    '''
    Remove any special characters from lead author name.
    '''
    surname = author.split()[0]
    auth = surname.split()[0].rstrip(punctuation).capitalize()
    auth = re.sub(r'[^\x00-\x7f]',r'_',auth)
    return auth

def author_year(bibdb):
    '''
    Return name of first author and year of publication.
    '''
    author = bibdb.entries[0]["author"]
    year = bibdb.entries[0]["year"]
    return author, year

def cite_key(tup):
    '''
    Create citekey.
    '''
    auth = sanitise_author(tup[0])
    year = tup[1]
    cite_key = auth+"_"+year
    return cite_key

def prefix_string(bibtext, bibparser):
    '''
    Prepare string prefix with new citekey.
    '''
    bibdb = bibtexparser.loads(bibtext, bibparser)
    articleType = str(bibtext).split(',')[0]
    articleType = articleType[0:articleType.find('{')+1]
    prefix = articleType+cite_key(author_year(bibdb))+',\n'
    return prefix

def suffix_string(bibtext):
    '''
    Prepare string suffix with new citekey.
    '''
    suffix = ','.join(str(bibtext).split(',')[1::])
    newtext = ""
    for part in suffix.split("}, "):
        newtext+=part+"},\n"
    return newtext
    
def print_string(bibtext, bibparser):
    '''
    Concatenate text with new citekey.
    '''
    prefix = prefix_string(bibtext, bibparser)
    suffix = suffix_string(bibtext)
    return prefix+suffix
    
###############################################################################

def sanity_check(output_file):
    '''
        Sanity check: print out .bib entries.
        '''
    outfile = open("{}.bib".format(output_file))
    [print(line) for line in outfile]
    outfile.close()

###############################################################################

def main(argv):
    '''
    Accepts a rich-text format reference list. Extracts DOIs and then queries Crossref to retrieve bibliographic data in bibtex format. Creates a .bib file with references.
        
        Usage:
        rtf2bib.py input_filename.rtf output_filename
        rtf2bib.py input_filename.rtf output_filename -v
        -v : prints out formatted bib entries.
        '''

    parser = argparse.ArgumentParser()
    parser.add_argument('-i', '--input',type=str,dest = 'infile',
                            help="Rich-text format file of references (including DOIs)")
    parser.add_argument('-o', '--output',type=str,dest = 'outfile',
                                help="name of desired output file")
    parser.add_argument('-v', '--verbose', dest='v', action='store_true',
                        help="Print out bibliography as a sanity check", default=False)
    args = parser.parse_args()
    
    input_file = args.infile
    output_file = args.outfile
    
    if os.path.isfile(output_file+".bib"):
        print("Output file already exists. ")
        value = input("Overwrite? [y/n]\n")
        if value == "y":
            os.remove(output_file+".bib") #this deletes the file
            url_list = create_url_list(input_file)
            create_bib_list(url_list, output_file)
            if args.v:
                sanity_check(output_file)
        else:
            print("Exiting.")
    else:

        url_list = create_url_list(input_file)
        create_bib_list(url_list, output_file)
        if args.v:
            sanity_check(output_file)

        print("All done!")


if __name__ == "__main__":
    try:
        main(sys.argv[1:])
    except KeyboardInterrupt:
        pass


###############################################################################
