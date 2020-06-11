pragma solidity ^0.6.9;

contract Ownable {
    address public owner;

    function Ownable() {
        owner = msg.sender;
    }

    modifier ownerOnly() {
        require(msg.sender == owner, "Only the owner can do this.");
        _;
    }
}
