pragma solidity ^0.4.23;

/// @title Params stores the governance params of VeChain thor.
/// The params can be set by executor which is a contract and authorized to modify governance params by a voting Committee.
/// Any one can get the params just by calling "get" funtion.
/// The governance params is written to genesis block at launch time.
/// You can check these params at source file: https://github.com/vechain/thor/blob/master/thor/params.go 

interface Params {
    function executor() external view returns(address);
    function set(bytes32 _key, uint256 _value) external;
    function get(bytes32 _key) external view returns(uint256);
}