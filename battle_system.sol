pragma solidity ^0.6.9;

import "core.sol";

contract CryptoRpgBattleSystem is CryptoRpgCore {
    function calculateLevelDifferenceFactor(
        Entity memory _attacker,
        Entity memory _defender
    ) private view returns (uint16) {
        uint16 levelDifferenceFactor = uint16(
            _attacker.level - _defender.level
        );

        if (levelDifferenceFactor > levelDifferenceFactorMax) {
            levelDifferenceFactor = levelDifferenceFactorMax;
        }

        return levelDifferenceFactor;
    }

    function calculateLevelDifferenceBonus(uint16 levelDifferenceFactor)
        private
        pure
        returns (uint16)
    {
        return levelDifferenceFactor * 100;
    }

    function calculateAttackDamage(
        string memory _string,
        uint16 _damageMinimum,
        uint16 _damageMaximum
    ) private pure returns (uint16) {
        return
            uint16(
                _generateRandomValue(_string, _damageMinimum, _damageMaximum)
            );
    }

    function calculateGeneralDamageDone(
        Entity memory _attacker,
        Entity memory _defender
    ) private view returns (uint16) {
        return
            _attacker.attack -
            _defender.health -
            _defender.defense +
            calculateLevelDifferenceBonus(
                calculateLevelDifferenceFactor(_attacker, _defender)
            );
    }
}
