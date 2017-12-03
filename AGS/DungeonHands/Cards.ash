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
import int Card_HC_getCardColor(int i);
import int Card_MC_getCardColor(int i);
import bool Card_HC_isCardSpecial(int i);
import bool Card_MC_isCardSpecial(int i);