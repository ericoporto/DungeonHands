// new module header
import function Play_begin();
import void Play_next_turn();
import function Play_deckDraw_MC();
import function Play_deckDraw_HC();
import void Play_End_Turn();
import void Play_Hero_Played_Card(InventoryItem * invItm);
import void Play_Monster_Played_Card(InventoryItem * invItm);
import Character * Play_Get_Char_Monster();
import Character * Play_Get_Char_Hero();
import void Play_zeroItems();
import void Play_disableRules();
import void Play_enableRules();
import bool Play_isTurnHero();
import bool Play_isTurnMonster();