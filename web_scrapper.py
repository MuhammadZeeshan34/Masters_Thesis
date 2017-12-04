import requests, re
from bs4 import BeautifulSoup
import pdb
from urllib3.exceptions import MaxRetryError
import re # regular expresions to remove numbers and special symbols
import nltk
import os
from nltk.stem.snowball import SnowballStemmer # To stemm words to their base form
#from nltk.corpus import stopwords


class MyParser:
      """
      Class to parse given number of web pages to scrap text information for given word and to save cleaned text in specified file
      """
       def __init__(strTosearch = 'pizza', numOfSites = 10, filePathToSave, stemmer_language):
              self.string_to_search = strToSearch
              self.num_of_sites_to_visit = numOfSites
              self.path_to_save_result = filePathToSave
              self.google_search_url  = 'http://www.google.com/search'
              self.stemmer = SnowballStemmer(stemmer_language)


        def ParseIt():
                                                
                file_with_stem =  open(os.path.join(path_to_save_result,stemmed.txt), "w")
                file_without_stem = open(os.path.join(path_to_save_result,not_stammed.txt),"w")
                subString = "url?q"
                count = 1;
                 
                #Setting User-Agent
                my_headers = { 'User-agent' : 'Mozilla/11.0' }

                start = 0
                num = 0
                while num < self.num_of_sites_to_visit:
                        num = start + 100
                        #Parameters in payload
                        payload = { 'q' : self.string_to_search, 'start' : str(start), 'num' : str(num) }
                        
                        
                        start = num                                                         
                        #Getting the response
                        
                        response = requests.get( self.google_search_url, params = payload, headers = my_headers )
                        
                         
                        # Extract received response to get text 
                        soup = BeautifulSoup( response.text, 'html.parser' )
                       
                        #Getting all h3 tags with class 'r'
                        h3tags = soup.find_all( 'h3', class_='r' )                        
                        
                        for h3 in h3tags:
                                #print(h3);
                                if subString in str(h3):                                        
                                        #print("Opening " + str(h3));
                                        subUrl =  re.search('url\?q=(.+?)\&sa', h3.a['href']).group(1)
                                        #subUrl =  re.search('url', h3.a['href']).group(1)                                        
                                        subUrl = str(subUrl)                 
                                        #print("Parsing " + subUrl);
                                        #print("Count: " + str(count));
                                        count=count+1;

                                        try:
                                              # After receing first page containing 100 number of site URL, shall parse indivual sites
                                                subR = requests.get( subUrl, headers = my_headers,
                                                                        auth=('user', 'pass'))  # Get data from specific URL
                                                subSoup = BeautifulSoup( subR.text, 'html.parser' ) # Parseing html data
                                                for script in soup(["script", "style"]):
                                                        script.extract()    # rip it out
                                                text = soup.get_text(separator=' ')  # Removing all html tags from extracted data

                                                text_ = re.sub("[^a-zA-Z]+", " ", text); # Geting only alphabets
                                                words = text_.lower().split()  # spliting into words and lower order
                                                stopwords = nltk.corpus.stopwords.words('english')
                                                
                                                words = [w for w in words if not w in stopwords] # Removing stop words
                                                words = [w for w in words if len(w) > 1 ] #Omiting words having length < 2
                                                text1 = ' '.join(words for words in words if words)
                                                file_without_stem.write(str(text1.encode('utf-8'))) # writing them to file with out stemming
                                                file2.write(" ")
                                                words_ = []
                                                for w in words:
                                                        words_.append(stemmer.stem(w)) # Steming words to their base form
                                                #words_ = [w for w in words_ if len(w) > 1 ] #Omiting words having length < 2
                                                words_.append(" ")
                                                text2 = ' '.join(words_ for words_ in words_ if words_)    # Joining all words             
                                                file_with_stem.write(str(text2.encode('utf-8'))) # writing them to file with stemming
                                                file.write(" ")
                                        except Exception as e:
                                                print(e)
                file.close()
                               
       
