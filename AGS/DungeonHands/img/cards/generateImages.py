#!/bin/python3
# -*- coding: utf-8 -*-
from PIL import Image
import os.path

item_name = ["Warrior Level 1","Mage Level 1","Rogue Level 1","Cleric Level 1","Cat","Dark Cat","Flying Cat","Cat Zombie","Knowledge is Power","Warrior Level 2","Mage Level 2","Rogue Level 2","Cleric Level 2","Kobold","Frozen Kobold","Kobold Trap","Kobold Ghost","Silence I want to read","Warrior Level 3","Mage Level 3","Rogue Level 3","Cleric Level 3","Goblin","Icy Goblin","Flying Goblin","Kobold Zombie","Everything is better on Fire","Warrior Level 4","Mage Level 4","Rogue Level 4","Cleric Level 4","Goblin Knight","Mimic","Trap Treasure","Goblin Skeleton","Rainbow Union","Warrior Level 5","Mage Level 5","Rogue Level 5","Cleric Level 5","Orc","Magic Orc","Balloon Orc","Undead Orc","BackHero","Warrior Level 6","Mage Level 6","Rogue Level 6","Cleric Level 6","Giant Bear","Giant Bear with Glasses","Big Bat","Vampire Cat Zombie","BackMonster"]

def crop(Path, img_type, input, height, width):
    im = Image.open(input)
    imgwidth, imgheight = im.size
    k=0
    for i in range(0,imgheight,height):
        for j in range(0,imgwidth,width):
            box = (j, i, j+width, i+height)
            a = im.crop(box)
            #try:
                #o = a.crop(area)
            a.save(os.path.join(Path, "{0}_{1:03d}_{2}.png".format(img_type,k,item_name[k])))
            #except:
            #    print("error")
            #    pass
            print("allcards[{0}]=\"{1}\";".format(k,item_name[k]))         
            k +=1
           
            if(k==len(item_name)):
                return
           
            
crop("cards_img","o","sheet.png",115,83)
