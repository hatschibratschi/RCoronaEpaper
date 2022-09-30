#!/usr/bin/python
# -*- coding:utf-8 -*-
import sys
import os
picdir = os.path.join(os.path.dirname(os.path.dirname(os.path.realpath(__file__))), 'pic')
libdir = os.path.join(os.path.dirname(os.path.dirname(os.path.realpath(__file__))), 'lib')
if os.path.exists(libdir):
    sys.path.append(libdir)

import logging
from waveshare_epd import epd2in9b_V3
import time
from PIL import Image,ImageDraw,ImageFont
import traceback

logging.basicConfig(level=logging.DEBUG)

try:
    logging.info("epd2in9b V3 Demo")
    
    epd = epd2in9b_V3.EPD()
    logging.info("init and Clear")
    epd.init()
    epd.Clear()
    time.sleep(1)
    
    # Drawing on the image
    #logging.info("fonts")    
    #font24 = ImageFont.truetype(os.path.join(picdir, 'Font.ttc'), 24)
    #font18 = ImageFont.truetype(os.path.join(picdir, 'Font.ttc'), 18)
    
    # Drawing on the Horizontal image
    logging.info("draw image...")
    i = Image.new('1', (epd.height, epd.width), 255)
    y = Image.new('1', (epd.height, epd.width), 255) # ryimage: red or yellow image  
    img_b = Image.open('/home/pi/git/r_covid/create_e_paper_pic/plot_corona_01.png')
    img_b = img_b.resize((epd.height,epd.width))
    i.paste(img_b)
    #img_r = Image.open('/home/pi/r/create_plot_pic/plot_red.png')
    #img_r = img_r.resize((epd.height,epd.width))
    #y.paste(img_r)
    epd.display(epd.getbuffer(i), epd.getbuffer(y))
    #time.sleep(20)
    
    #logging.info("Clear...")
    #epd.init()
    #epd.Clear()
    
    logging.info("Goto Sleep...")
    epd.sleep()
        
except IOError as e:
    logging.info(e)
    
except KeyboardInterrupt:    
    logging.info("ctrl + c:")
    epd2in9b_V2.epdconfig.module_exit()
    exit()
