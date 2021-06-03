# DungeonHands
GitHub Actions: [![CI](https://github.com/ericoporto/DungeonHands/actions/workflows/main.yml/badge.svg)](https://github.com/ericoporto/DungeonHands/actions/workflows/main.yml)
AppVeyor: [![Build status](https://ci.appveyor.com/api/projects/status/t4k6scc08hsqn750?svg=true)](https://ci.appveyor.com/project/ericoporto/dungeonhands)

DungeonHands game source, Made in Adventure Game Studio.

This projects uses git submodule, so clone as below:

    git clone --recurse-submodules https://github.com/ericoporto/DungeonHands.git

Depending on git version, do after clone, inside the folder:

    git submodule update --init --recursive

This game was made for LudumDare 40, get it on http://eri0o.itch.io/dungeon-hands

## Here are the rules

You win when you have no cards in hand.

When the game starts players can choose **Monster Overlord** or **Heroes**. The player with **Monster Overlord** deck starts.

A round is composed of each player turns.

On the start of the turn, the player can play any special card if desired. Then the player must play either a Hero card (when playing with Heroes) or a Monster card (if you are the Monster Overlord). Then the game goes to next turn.

The player playing next can play any special card if desired. Then the player must play either a Hero card (when playing with Heroes) or a Monster card (if you are the Monster Overlord), but the card played MUST be either a higher Rank or the same Class, this is called a valid card. If a player does not have a valid card in his hand, that player draws cards until a valid card is drawn and played. Then the turn ends.

With Monster Overlord cards and Heroes cards on the table, the dungeon encounter is resolved, and all cards on table leave play - the Hero cards go back to the village and the Monsters cards perish. The player who had the highest Rank card get to start the next round. If all cards had the same Rank, the last player to play starts the next round.

The Rank is the number on the corner, Class is represented by the symbol and color of the card. Special cards have no Rank or Class.

The player who draws the last deck card loses.
