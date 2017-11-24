#!/usr/bin/python

import os ; import sys ; import smtplib ; import mimetypes ;
from smtplib import SMTP
from smtplib import SMTPException
from email.mime.multipart import MIMEMultipart ;
from email import encoders
from email.message import Message ;
from email.mime.image import MIMEImage
from email.mime.text import MIMEText


#_from     =   "fog.masdar.ac.ae" ;
_to       =   ["fkaragulian@masdar.ac.ae","vkvalappil@masdar.ac.ae","mtemimi@masdar.ac.ae","mjweston@masdar.ac.ae"] ; 
_sub      =   "WRF Chem Run"
_content  =   str(sys.argv[1])                                
_text_subtype = "plain"
_to=','.join(_to)

mail=MIMEMultipart('alternative')
mail["Subject"]  =  _sub
#mail["From"]     =  _from
mail["To"]       =  _to
mail.attach(MIMEText(_content, _text_subtype ))

try:
           _from     =   "fog@masdar.ac.ae" ;
	   smtpObj = smtplib.SMTP('mail.masdar.ac.ae',587)
	   smtpObj.ehlo()
	   smtpObj.starttls()
	   smtpObj.login('fog', 'P@ssword321')
	   smtpObj.sendmail(_from, _to, mail.as_string())
	   smtpObj.close()
	   print 'Success'
except:
        try:
            _from     =   "fog.masdar@gmail.com" ;
            smtpObj = SMTP('smtp.gmail.com',587)
            #Identify yourself to GMAIL ESMTP server.
            smtpObj.ehlo()
            #Put SMTP connection in TLS mode and call ehlo again.
            smtpObj.starttls()
            smtpObj.ehlo()
            #Login to service
            smtpObj.login(user='fog.masdar@gmail.com', password='fog@masdar123')
            #Send email
            smtpObj.sendmail(_from, _to, mail.as_string())
            #close connection and session.
            smtpObj.quit()
        except SMTPException as error:
            print "Error: unable to send email :  {err}".format(err=error)
quit()
