pragma solidity ^0.6.9;

contract CryptoRpgCore {
    enum EntityKind {HERO, MOB, BOSS}

    struct Hero {
        string name;
        EntityKind kind;
        uint256 dna;
        uint16 level;
        uint8 xp;
        uint16 health;
        uint16 attack;
        uint16 defense;
    }

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

    address public devAddress = 0x9CfD5D69e1F59437B3e2c9A64B6E14190b973DD0;

    bool public paused = false;

    uint8 public comissionFee = 3;

    Hero[] heroes;

    mapping(address => Hero[]) ownerToHeroIndex;

    modifier devOnly() {
        require(
            msg.sender == ownerAddress,
            "Cannot access developer-only functionality."
        );

        _;
    }

    modifier whenNotPaused() {
        require(!paused, "Contract is paused.");
        _;
    }

    function setDevAddress(address _devAddress) external devOnly {
        devAddress = _devAddress;
    }

    function setPaused(bool _paused) public devOnly {
        paused = _paused;
    }

    function setComissionFee(uint8 _comissionFee) public devOnly {
        uint8 _newComissionFee = _comissionFee;

        // Maximum comission fee of 50%. However, it would usually sit around <=3%.
        if (_newComissionFee > 50) {
            _newComissionFee = 50;
        }

        comissionFee = _newComissionFee;
    }

    function _createHero(
        string memory _name,
        uint256 _dna,
        uint16 _level,
        uint8 _xp,
        uint16 _health,
        uint16 _attack,
        uint16 _defense,
        address _owner
    ) internal returns (uint256) {
        uint256 newHeroId = ownedHeroes[owner].push(
            Hero(_name, _dna, _level, _xp, _health, _attack, _defense)
        );

        return newHeroId - 1;
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

    function mintHero(string memory _name) public ownerOnly returns (uint256) {
        uint256 randomDna = _generateRandomDna(_name);

        uint16 level = _generateRandomValue(
            _name,
            mintHeroLevelStart,
            mintHeroLevelRange
        );

        uint8 xp = 0;

        uint16 health = _generateRandomValue(
            _name,
            mintHeroHealthStart,
            mintHeroHealthRange
        );

        uint16 attack = _generateRandomValue(
            _name,
            mintHeroAttackStart,
            mintHeroHealthRange
        );

        uint16 defense = _generateRandomValue(
            _name,
            mintHeroDefenseStart,
            mintHeroDefenseRange
        );

        return
            _createHero(_name, randomDna, level, xp, health, attack, defense);
    }
}
