<p align="center">
<strong>CryptoRPG</strong>

<i>An adventure and risk game based off the [ERC721 token standard](http://erc721.org/). Assemble your hero squad, begin epic campaigns and send them on quests to defeat monsters and bosses, all while gaining rewards and loot along the way!</i>

<img src="https://i.ibb.co/xDRN7df/cryptorpg.png" />
</p>

### Player entities

A player may control various types of entities, ranging from heroes to items and pets. Other entities such as quests, and bosses cannot be owned by players. Player-controlled entities may be traded (bought and sold).

### Mobs

Mobs are the game's main enemies. They manifest in masses, and successfully defeating them grants heroes XP points. Killing mobs provide small chances of dropping loot.

### Entities

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
uint8[] weaknesses;
```

### Damange calculation

Attack damage:

```
attackDamage = damageMin + [random % ([damageMax + 1] - damageMin)]
```

General damage done:

```
damageDone = attacker.damage - defender.defense - defender.health
```

### Loot

**Drops from mobs**

Chances for a drop to occur (in percentages) from a mob detailed in the formula for `mobDropChance` below:

```
mobDropChance = [(mob.power) % 100] - (hero.luck % 50)
```

### Stats

**Name**

A name tag for a certain asset. Not unique.

**Level**

Range: `1-100`

The level stat helps balance & control mob difficulty, rewards, and others.

**Health**

Range: `1-300`

The health stat is the base survivability stat of a living entity. When the living entity takes damage and the health decreases in battle, the entity must either be healed by the player using items, or will slowly self-regenerate over time. When the health of a living entity becomes 0, this entity dies.

**Armor**

Range: `0-100`

The armor stat helps block attack damage without affecting the health of the living entity. Armor is reset upon every battle, helping block attack damage without decreasing permanently.

**Luck**

Range: `0.0-2.0%`

Luck is a stat owned by heroes. It helps determines chances of positive events occurring, such as mob drops and quest rewards' quality.

Because the maximum amount of heroes in a squad is `10`, the maximum luck aquirable on a squad is `+20%`.

**Power**

The power stat is a computed stat used to determine the total capabilities and power of a living entity.

Live entity power formula:

```
liveEntityPower = (entity.level * 20) + entity.health + entity.damage + entity.defense;
```

Hero power formula:

```
heroPower = liveEntityPower(hero) + (hero.luck * 10)
```

### Campaign

Campaigns are collections of quests. They are automatically unlocked when the player's power reaches or surpasses a certain threshold (depending on the campaign). Once unlocked, the campaigns quests may be accessed by the player. Harder campaigns offer greater rewards and loot, however they also involve greater risks.

The purpose of campaigns is to limit the quests on which the player may risk their entities, as it is proportional to the player's power. This prevents potentially sacrificing a large amount of entities to high-risk quests, and encourages steady growth compared to a high-risk approach.

The more assets the player owns, the greater they can risk on quests for greater rewards. Once a campaign is completed, that is--when all of its quests are completed--the player will receive a final reward, with its quality depending on the campaign's performance grade.

The campaign's performance score is calculated as follows:

```
campaignPerformanceScore = floor(totalQuestsAmount / totalQuestAttempts) * 100
```

Once the campaign is completed, it will be assigned a grade depending on it's performance score:

*S+* >= 95%
*S* >= 90%
*A* >= 85%
*B* >= 80%
*C* >= 75%
*D* >= 70%

Different performance scores will yield different quality rewards for that specific campaign.

### Quests

Quests are essential missions where you send your heroes in order to gain rewards. Certain quests have special requirements, while others only require a living hero.

Depending on the player's heroes, quests can be a great way to get rewards, advance the heroes' XP points, and advance in campaigns. However, sending heroes on quests also involves risk, depending on its stats, the quest itself, and it's requirements.

A squad of heroes is selected by the player before starting each quest. This squad may contain a `1-10` range of heroes, and *may* contain a single pet.

In order to provide an overview of a quest's difficulty with the player's designated hero squad, a probability ranging `0-99%` is provided to the player to assess their risk.

**Difficulty**

The difficulty of a quest helps identify a quest's difficulty without a squad context.

```
questDifficulty = mobs.power / 5
```

**Success odds**

Range: `0-99%`

A quest's success odds determines the probability of successful completion with the assembled hero squad. A 1% risk edge is always kept to encourage fun, and to avoid guaranteed rewards.

Once a quest is completed, it cannot be accessed again by the same player. The formula for calculating the quest's success odds (in percentage) is provided below:

```
questSuccessOdds = 100 - abs(floor[squad.power / mobs.power] * 100) + squad.luck
```