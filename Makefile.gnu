# -- makefile --
#
#
#
XP=xsltproc

SSHPORT=1202

2010:
	$(XP) -o r2010.xml r2r.xsl c2010.xml && \
		$(XP) -o c2010.html rowery.xsl r2010.xml && cp c2010.html ../  
	$(XP) -o c2010.txt r2txt.xsl c2010.xml 
	cp c2010.txt ../../ && rm -rf c2010.txt c2010.html

2009:
	$(XP) -o r2009.xml r2r.xsl c2009.xml && \
		$(XP) -o c2009.html rowery.xsl r2009.xml && cp c2009.html ../  
	$(XP) -o c2009.txt r2txt.xsl c2009.xml 
	cp c2009.txt ../../ && rm -rf c2009.txt c2009.html

2008:
	$(XP) -o r2008.xml r2r.xsl c2008.xml && \
		$(XP) -o c2008.html rowery.xsl r2008.xml && cp c2008.html ../  
	$(XP) -o c2008.txt r2txt.xsl c2008.xml 
	cp c2008.txt ../../ && rm -rf c2008.txt c2008.html

2007:
	$(XP) -o r2007.xml r2r.xsl c2007.xml && \
		$(XP) -o c2007.html rowery.xsl r2007.xml && cp c2007.html ../  
	$(XP) -o c2007.txt r2txt.xsl c2007.xml 
	cp c2007.txt ../../ && rm -rf c2007.txt c2007.html

2006:
	$(XP) -o r2006.xml r2r.xsl c2006.xml && \
		$(XP) -o c2006.html rowery.xsl r2006.xml && cp c2006.html ../  
	$(XP) -o c2006.txt r2txt.xsl c2006.xml 
	cp c2006.txt ../../ && rm -rf c2006.txt c2006.html

2005:
	$(XP) -o r2005.xml  r2r.xsl c2005.xml && \
		$(XP) -o c2005.html rowery.xsl r2005.xml && cp c2005.html ../  
	$(XP) -o c2005.txt r2txt.xsl c2005.xml
	cp c2005.txt ../../ && rm -rf c2005.txt c2005.html
	
2004:
	$(XP) -o r2004.xml  r2r.xsl c2004.xml && \
		$(XP) -o c2004.html rowery.xsl r2004.xml && cp c2004.html ../  
	$(XP) -o c2004.txt r2txt.xsl c2004.xml 
	cp c2004.txt ../../ && rm -rf c2004.txt c2004.html 

2003:
	$(XP) -o r2003.xml  r2r.xsl c2003.xml && \
		$(XP) -o c2003.html rowery.xsl r2003.xml && cp c2003.html ../  
	$(XP) -o c2003.txt r2txt.xsl c2003.xml 
	cp c2003.txt ../../ && rm -rf c2003.txt c2003.html 

2002:
	$(XP) -o r2002.xml  r2r.xsl c2002.xml && \
		$(XP) -o c2002.html rowery.xsl r2002.xml && cp c2002.html ../  
	$(XP) -o c2002.txt r2txt.xsl c2002.xml
	cp c2002.txt ../../  && rm -rf c2002.txt c2002.html 

2001:
	$(XP) -o r2001.xml  r2r.xsl c2001.xml && \
		$(XP) -o c2001.html rowery.xsl r2001.xml && cp c2001.html ../  
	$(XP) -o c2001.txt r2txt.xsl c2001.xml
	cp c2001.txt ../../  && rm -rf c2001.txt c2001.html 

2000:
	$(XP) -o r2000.xml  r2r.xsl c2000.xml && \
		$(XP) -o c2000.html rowery.xsl r2000.xml && cp c2000.html ../  
	$(XP) -o c2000.txt r2txt.xsl c2000.xml
	cp c2000.txt ../../ && rm -rf c2000.txt c2000.html 

all: 2009 2008 2007 2006 2005 2004 2003 2002 2001 2000

##
## .... Dist Copying ....
# Pack whole catalogue with dd/mm/yy suffix appended:
# omin katalogi .svn
# ###
# zip -r backup.zip /home -x "/home/cpanel/*"
# tar -cf backup.tar /home --exclude "/home/cpanel"

pack: clean
	cd .. && zip -rp opus00.zip . -x "src/.svn/*" -x ".svn/*"  && cd src

#
#1) On the LOCAL machine, generate a private/public pair of keys:
#
#ssh-keygen -t dsa
#
#This creates two files:
#
#id_dsa         # the private key - remains local
#id_dsa.pub     # the public key - must be put on the REMOTE machine.
#
#Both of these are created in .ssh in the user's home directory,
#e.g. /home/joeuser/.ssh.
#
#2) Put the public key on the REMOTE machine:
#
#scp id_dsa.pub joeu...@remote.machine.com:.
#
#This will put id_dsa.pub in the home directory of "joeuser" on the
#remote machine. Any existing id_dsa.pub will be overridden!
#
#3) On the REMOTE machine, append the newly transfered id_dsa.pub
#to the authorized_keys2 file:
#
#ssh joeu...@remote.machine.com
#cat id_dsa.pub >> .ssh/authorized_keys2
#
#Note the >> (rather than >)! 
#
# ....
#The user needs a .ssh directory, which ssh usually sets up the first time
#it is used. This contains a number of files.
#a) known-hosts. This contains the public key of remote computers. ssh will
#get those public keys the first time ssh is run ito connect
#with the remote computer.
#b) id_rsa and id_rsa.pub  (or dsa instead of rsa) files which contain your
#private and public keys respectively.
#c) authorized_keys -- public keys of remote users who you want to allow to
#log on as you without a password.
#
#Thus, for you as user name alpha on machine A to log onto a remote machine B as user
#beta without a password, copy the contents of the file
#~alpha/.ssh/id_rsa.pub on machine A  into the file
#~beta/.ssh/authorized_keys on machine B.  ( Or send the contents of your
#file ~alpha/.ssh/id_rsa.pub to user beta on machine B and have him put them
#into his authorized_keys file.)
#
#This will allow you as user alpha to log onto machine B as user beta by
#doing
#ssh beta@B
#Or scp beta@B:/file/nam/to/be/copied  /location/for/file/on/A
#
#The files in /etc/ssh are for the machine to machine authentication, not
#for users. 
#
##
## Skopiuj opus00.zip na odlegla maszyne, jezeli ok, usun plik opus00.zip
##
dist: 2010 pack
	scp -B ../opus00.zip tomasz@gnu.univ.gda.pl:Download/opus00.zip && \
		ssh tomasz@gnu.univ.gda.pl 'cd Download && make o'
        ### Neptune
##	scp -P $(SSHPORT) -B ../opus00.zip tomek@neptune:Download/opus00.zip || true && \
##	        ssh -p $(SSHPORT) tomek@neptune 'cd Download && make opus' || true && \
	rm -rf ../opus00.zip



clean:
	rm -rf r2[0-9]*.xml r2[0-9]*.html *~

help:
	@echo 'make clean | dist | distcopy | <year> | all | pack'

up: clean
	svn ci -m 'aktualizacja'
