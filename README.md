# DungeonHands
GitHub Actions: [![CI](https://github.com/ericoporto/DungeonHands/actions/workflows/main.yml/badge.svg)](https://github.com/ericoporto/DungeonHands/actions/workflows/main.yml)

AppVeyor: [![Build status](https://ci.appveyor.com/api/projects/status/t4k6scc08hsqn750?svg=true)](https://ci.appveyor.com/project/ericoporto/dungeonhands)

[![image](https://user-images.githubusercontent.com/2244442/120691969-8b2efa80-c47d-11eb-880b-640e4a9475c5.png)](https://itch.io/embed-upload/3937817?color=1F1E3B)

DungeonHands game source, Made in Adventure Game Studio. This game was originally made for LudumDare 40, get it on [eri0o.itch.io/dungeon-hands](https://eri0o.itch.io/dungeon-hands). You can find the original sources by looking the [files around commit `116ed5e74`](https://github.com/ericoporto/DungeonHands/tree/116ed5e74089d916632f26525f88cdb273e82dcc).

Learn more on it's [AGS Forums Page](https://www.adventuregamestudio.co.uk/forums/index.php?topic=55546.0).

## Continuous Integration

I am maintaining this game now as an example of using Continuous Integration with Adventure Game Studio.

This repository includes
- AppVeyor build and packaging example
- GitHub Actions build and packaging example
- Automation for Web Builds
- itch.io buttler integration through Github Actions

## Here are the rules

You win when you have no cards in hand.

When the game starts players can choose **Monster Overlord** or **Heroes**. The player with **Monster Overlord** deck starts.

A round is composed of each player turns.

On the start of the turn, the player can play any special card if desired. Then the player must play either a Hero card (when playing with Heroes) or a Monster card (if you are the Monster Overlord). Then the game goes to next turn.

The player playing next can play any special card if desired. Then the player must play either a Hero card (when playing with Heroes) or a Monster card (if you are the Monster Overlord), but the card played MUST be either a higher Rank or the same Class, this is called a valid card. If a player does not have a valid card in his hand, that player draws cards until a valid card is drawn and played. Then the turn ends.

With Monster Overlord cards and Heroes cards on the table, the dungeon encounter is resolved, and all cards on table leave play - the Hero cards go back to the village and the Monsters cards perish. The player who had the highest Rank card get to start the next round. If all cards had the same Rank, the last player to play starts the next round.

The Rank is the number on the corner, Class is represented by the symbol and color of the card. Special cards have no Rank or Class.

The player who draws the last deck card loses.
