# CryptoRPG

An adventure and risk game based off the ERC721 standard protocol. Assemble your heroes, begin epic campaigns and send them on quests to defeat monsters and bosses, all while gaining rewards and loot along the way.

# Player entities

A player may control various types of entities, ranging from heroes to items and pets. Other entities such as quests, and bosses cannot be owned by players. Player-controlled entities may be traded (bought and sold).

# Mobs

Mobs are the game's main enemies. They manifest in masses, and successfully defeating them grants heroes XP points. Killing mobs provide small chances of dropping loot.

# Entities

**Basic entity**

Composition:

```
string name;
```

**Live entity** : Basic entity

Composition:

```
uint8 type;
uint dna;
uint8 level;
uint8 health;
uint8 damageMin;
uint8 damageMax;
uint8 defense;
computed uint8 power;
```

**Hero** : Live entity

Composition:

```
...
uint8 xp;
uint8 luck;
computed uint8 power;
```

Description:

Heroes are the essential asset of the game, and the only units required to play the game.

**Mob** : Live entity

Composition:

```
...
bool isBoss;
```

# Power

Attack damage:

```
attackDamage = damageMin + [random % ([damageMax + 1] - damageMin)]
```

General damage done:

```
damageDone = attacker.damage - defender.defense - defender.health
```

Live entity power:

```
liveEntityPower = (entity.level * 20) + entity.health + entity.damage + entity.defense;
```

Hero power:

```
heroPower = liveEntityPower(hero) + (hero.luck * 3)
```

# Loot and rewards

**Drops from mobs**

Chances for a drop to occur from a mob detailed in the formula below:

```
chance = [(mob.power) % 100] - (hero.luck % 50)
```

# Stats

**Name**

A name tag for a certain asset. Not unique.

**Level**

Range: `1-100`

The level stat helps balance & control mob difficulty, rewards, and others.

**Health**

Range: `1-300`

The health stat is the base survivability stat of a living entity. When the living entity takes damage and the health decreases in battle, the entity must either be healed by the player using items, or will slowly self-regenerate over time.

**Armor**

Range: `0-100`

The armor stat helps block attack damage without affecting the health of the living entity. Armor is reset upon every battle, helping block attack damage without decreasing permanently.

**Luck**

Range: `0-30%`

Luck is a stat owned by heroes. It helps determines chances of positive events occurring, such as mob drops and quest rewards' quality.

**Power**

The power stat is a computed stat used to determine the total capabilities and power of a living entity.