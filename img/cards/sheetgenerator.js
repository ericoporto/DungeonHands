arrc = ["Warrior Level 1.png","Mage Level 1.png","Rogue Level 1.png","Cleric Level 1.png","Cat.png","Dark Cat.png","Flying Cat.png","Cat Zombie.png","Knowledge is Power.png","Warrior Level 2.png","Mage Level 2.png","Rogue Level 2.png","Cleric Level 2.png","Kobold.png","Frozen Kobold.png","Kobold Trap.png","Kobold Ghost.png","Silence I want to read.png","Warrior Level 3.png","Mage Level 3.png","Rogue Level 3.png","Cleric Level 3.png","Goblin.png","Icy Goblin.png","Flying Goblin.png","Kobold Zombie.png","Everything is better on Fire.png","Warrior Level 4.png","Mage Level 4.png","Rogue Level 4.png","Cleric Level 4.png","Goblin Knight.png","Mimic.png","Trap Treasure.png","Goblin Skeleton.png","Rainbow Union.png","Warrior Level 5.png","Mage Level 5.png","Rogue Level 5.png","Cleric Level 5.png","Orc.png","Magic Orc.png","Balloon Orc.png","Undead Orc.png","BackHero.png","Warrior Level 6.png","Mage Level 6.png","Rogue Level 6.png","Cleric Level 6.png","Giant Bear.png","Giant Bear with Glasses.png","Big Bat.png","Vampire Cat Zombie.png","BackMonster.png" ]

var cw=83;
var ch=115;
console.log('<TextureAtlas imagePath="sheet.png">');
for(var i=0;i<arrc.length; i++){
console.log('<SubTexture name="'+arrc[i]+'" x="'+(i%9)*cw+'" y="'+parseInt(Math.floor(i/9)*ch)+'" width="'+cw+'" height="'+ch+'"/>');

}
console.log('</TextureAtlas>');
