// new module header
import int Cards_drawCard_MC();
import int Cards_drawCard_HC();
import void Cards_makeDecks();
import InventoryItem * Cards_HC_CardToItem(int card);
import InventoryItem * Cards_MC_CardToItem(int card);
import int Cards_HC_ItemToCard(InventoryItem * invItm);
import int Cards_MC_ItemToCard(InventoryItem * invItm);
import int Card_HC_getCardRank(int i);
import int Card_MC_getCardRank(int i);
import int Card_HC_getCardGraphic(int i);
import int Card_MC_getCardGraphic(int i);
import int Card_HC_getCardColor(int i);
import int Card_MC_getCardColor(int i);
import bool Card_HC_isCardSpecial(int i);
import bool Card_MC_isCardSpecial(int i);
import void Cards_HC_EnableAllDrag();
import void Cards_MC_EnableAllDrag();
import void Cards_SetCardItemDisable(InventoryItem * icard);
import void Cards_SetCardItemEnable(InventoryItem * icard);
import bool Cards_isItemMonster(InventoryItem * invItm);

#define CARD_BACK_HERO_GRAPHIC 62
#define CARD_BACK_MONSTER_GRAPHIC 71


#define CCOLOR_GREEN 0
#define CCOLOR_BLUE 1
#define CCOLOR_YELLOW 2
#define CCOLOR_RED 3
#define CCOLOR_GRAY 4
#define RANK_SP 8