pragma solidity ^0.6.9;

contract CryptoRPG {
	struct Item {
		uint16 kind;
	}
	
	struct Entity {
		string name;
		
		uint16 kind;
		
		uint dna;
		
		uint16 level;
		
		uint16 health;
		
		uint16 attack;
		
		uint16 defense;
	}
	
	Entity[] public heroes;
	
	uint16 entityKindHero = 0;
	
	uint dnaDigits = 16;
	
	uint dnaModulus = 10 ** dnaDigits;
	
	uint16 heroLevelMinimum = 1;
	
	uint16 heroLevelMaximum = 100;
	
	uint16 heroHealthMinimum = 0;
	
	uint16 heroHealthMaximum = 300;
	
	uint16 heroAttackMinimum = 1;
	
	uint16 heroAttackMaximum = 100;
	
	uint16 heroDefenseMinimum = 0;
	
	uint16 heroDefenseMaximum = 100;
	
	uint16 levelDifferenceFactorMax = 3;
	
	uint16 mintHeroLevelStart = heroLevelMinimum;
	
	uint16 mintHeroLevelRange = 5;
	
	uint16 mintHeroHealthStart = 1;
	
	uint16 mintHeroHealthRange = 20;
	
	uint16 mintHeroAttackStart = 1;
	
	uint16 mintHeroAttackMaximum = 10;
	
	uint16 mintHeroDefenseStart = 0;
	
	uint16 mintHeroDefenseRange = 10;
	
	function _createHero(string memory _name, uint _dna, uint16 _level, uint16 _health, uint16 _attack, uint16 _defense) private {
		heroes.push(Entity(_name, entityKindHero, _dna, _level, _health, _attack, _defense));
	}
	
	function _generateRandomDna(string memory _string) private view returns (uint) {
		uint random = uint(keccak256(abi.encodePacked(_string)));
		
		return random % dnaModulus;
	}
	
	function _generateRandomValue(string memory _string, uint _minimum, uint _maximum) private pure returns (uint16) {
		uint random = uint(keccak256(abi.encodePacked(_string)));
		
		return uint16(_minimum + (random % ((_maximum + 1) - _minimum)));
	}
	
	function calculateLevelDifferenceFactor(Entity memory _attacker, Entity memory _defender) private view returns (uint16) {
		uint16 levelDifferenceFactor = uint16(_attacker.level - _defender.level);
		
		if (levelDifferenceFactor > levelDifferenceFactorMax) {
			levelDifferenceFactor = levelDifferenceFactorMax;
		}
		
		return levelDifferenceFactor;
	}
	
	function calculateLevelDifferenceBonus(uint16 levelDifferenceFactor) private pure returns (uint16) {
		return levelDifferenceFactor * 100;
	}
	
	function calculateAttackDamage(string memory _string, uint16 _damageMinimum, uint16 _damageMaximum) private pure returns (uint16) {
		return uint16(_generateRandomValue(_string, _damageMinimum, _damageMaximum));
	}
	
	function calculateGeneralDamageDone(Entity memory _attacker, Entity memory _defender) private view returns (uint16) {
		return _attacker.attack - _defender.health - _defender.defense + calculateLevelDifferenceBonus(calculateLevelDifferenceFactor(_attacker, _defender));
	}
	
	function calculateQuestDifficulty(Entity[] memory mobs) private {
		// TODO
	}
	
	function mintHero(string memory _name) public {
		uint randomDna = _generateRandomDna(_name);
		
		_createHero(_name, randomDna, _generateRandomValue(_name, mintHeroLevelStart, mintHeroLevelRange), _generateRandomValue(_name, mintHeroHealthStart, mintHeroHealthRange), _generateRandomValue(_name, mintHeroAttackStart, mintHeroHealthRange), _generateRandomValue(_name, mintHeroDefenseStart, mintHeroDefenseRange));
	}
}