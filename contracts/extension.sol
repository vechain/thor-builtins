pragma solidity ^0.4.23;

/// @title Extension extends EVM functions.
/// Extension gives an opportunity for the developer to get information of any history block from genesis to best block and current transaction.
/// The information obtained by block num include blockID, blockTotalScore, blockTime and blockSigner.
/// THe developer can also get current transaction information, including txProvedWork, txID, txBlockRef and txExpiration.

interface Extension {
    /// @notice blake2b256 computes blake2b-256 checksum for given data.
    function blake2b256(bytes _value) external view returns(bytes32);

    /// @notice These function gives block info from genesis to best block.
    function blockID(uint num) external view returns(bytes32);
    function blockTotalScore(uint num) external view returns(uint64);
    function blockTime(uint num) external view returns(uint);
    function blockSigner(uint num) external view returns(address);

    /// @return total supply of VET
    function totalSupply() external view returns(uint256);

    /// @notice These funtion gives current transaction info.
    function txProvedWork() external view returns(uint256);
    function txID() external view returns(bytes32);
    function txBlockRef() external view returns(bytes8);
    function txExpiration() external view returns(uint);
}