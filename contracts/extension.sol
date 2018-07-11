pragma solidity ^0.4.23;

/// @title Extension extends EVM functions.

interface Extension {
    function blake2b256(bytes _value) external view returns(bytes32);
    function blockID(uint num) external view returns(bytes32);
    function blockTotalScore(uint num) external view returns(uint64);
    function blockTime(uint num) external view returns(uint);
    function blockSigner(uint num) external view returns(address);
    function totalSupply() external view returns(uint256);
    function txProvedWork() external view returns(uint256);
    function txID() external view returns(bytes32);
    function txBlockRef() external view returns(bytes8);
    function txExpiration() external view returns(uint);
}