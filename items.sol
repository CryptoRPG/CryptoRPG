pragma solidity ^0.6.9;

import "core.sol";

contract CryptoRpgItems is CryptoRpgCore {
    enum ItemKind {
        MINOR_HEAL_POTION,
        MAJOR_HEAL_POTION,
        REVIVAL_TOTEM,
        CHEST_COMMON,
        CHEST_UNCOMMON,
        CHEST_RARE,
        CHEST_EPIC,
        CHEST_LEGENDARY,
        ARENA_PASS,
        CAMPAIGN_PASS
    }

    struct Item {
        ItemKind kind;
        uint16 value;
    }
}
