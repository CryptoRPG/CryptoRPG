pragma solidity ^0.6.9;

contract CryptoRpgCore {
    struct Item {
        uint16 kind;
    }

    struct Entity {
        string name;
        uint16 kind;
        uint256 dna;
        uint16 level;
        uint16 health;
        uint16 attack;
        uint16 defense;
    }

    address constant ownerAddress = 0x9CfD5D69e1F59437B3e2c9A64B6E14190b973DD0;

    uint16 constant entityKindHero = 0;

    uint256 constant dnaDigits = 16;

    uint256 constant dnaModulus = 10**dnaDigits;

    uint16 constant heroLevelMinimum = 1;

    uint16 constant heroLevelMaximum = 100;

    uint16 constant heroHealthMinimum = 0;

    uint16 constant heroHealthMaximum = 300;

    uint16 constant heroAttackMinimum = 1;

    uint16 constant heroAttackMaximum = 100;

    uint16 constant heroDefenseMinimum = 0;

    uint16 constant heroDefenseMaximum = 100;

    uint16 constant levelDifferenceFactorMax = 3;

    uint16 constant mintHeroLevelStart = heroLevelMinimum;

    uint16 constant mintHeroLevelRange = 5;

    uint16 constant mintHeroHealthStart = 1;

    uint16 constant mintHeroHealthRange = 20;

    uint16 constant mintHeroAttackStart = 1;

    uint16 constant mintHeroAttackMaximum = 10;

    uint16 constant mintHeroDefenseStart = 0;

    uint16 constant mintHeroDefenseRange = 10;

    Entity[] public heroes;

    function _createHero(
        string memory _name,
        uint256 _dna,
        uint16 _level,
        uint16 _health,
        uint16 _attack,
        uint16 _defense
    ) private {
        heroes.push(
            Entity(
                _name,
                entityKindHero,
                _dna,
                _level,
                _health,
                _attack,
                _defense
            )
        );
    }

    function _generateRandomDna(string memory _string)
        private
        view
        returns (uint256)
    {
        uint256 random = uint256(keccak256(abi.encodePacked(_string)));

        return random % dnaModulus;
    }

    function _generateRandomValue(
        string memory _string,
        uint256 _minimum,
        uint256 _maximum
    ) private pure returns (uint16) {
        uint256 random = uint256(keccak256(abi.encodePacked(_string)));

        return uint16(_minimum + (random % ((_maximum + 1) - _minimum)));
    }

    function calculateQuestDifficulty(Entity[] memory mobs) private {
        // TODO
    }

    function mintHero(string memory _name) public {
        uint256 randomDna = _generateRandomDna(_name);

        _createHero(
            _name,
            randomDna,
            _generateRandomValue(_name, mintHeroLevelStart, mintHeroLevelRange),
            _generateRandomValue(
                _name,
                mintHeroHealthStart,
                mintHeroHealthRange
            ),
            _generateRandomValue(
                _name,
                mintHeroAttackStart,
                mintHeroHealthRange
            ),
            _generateRandomValue(
                _name,
                mintHeroDefenseStart,
                mintHeroDefenseRange
            )
        );
    }
}
