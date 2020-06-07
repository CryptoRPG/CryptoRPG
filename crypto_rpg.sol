pragma solidity ^0.6.9;

contract CryptoRPG {
  struct Entity {
    uint8 health;

    uint8 attack;

    uint8 defense;
	
	uint8[] buffs;
  }

  struct Hero {
    string name;

    uint dna;

    uint8 level;

    EntityStats stats;
  }

  Hero[] public heroes;

  uint dnaDigits = 16;

  uint dnaModulus = 10 ** dnaDigits;

  uint8 heroHealthFactor = 20;

  uint8 heroAttackFactor = 5;

  uint8 heroDefenseFactor = 5;

  function _createHero(string memory _name, uint _dna, uint8 _level, uint8 _health, uint8 _attack, uint8 _defense) private {
    heroes.push(Hero(_name, _dna, _level, _health, _attack, _defense));
  }

  function _generateRandomDna(string memory _string) private view returns (uint) {
    uint random = uint(keccak256(abi.encodePacked(_string)));

    return random % dnaModulus;
  }

  function calculateAttackDamage()

  function createRandomHero(string memory _name, uint8 _level) {
    // TODO: Level cannot be <1.

    uint randomDna = _generateRandomDna(_name);

    _createHero(_name, randomDna, _level,)
  }
}