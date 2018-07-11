pragma solidity ^0.4.23;

interface Params {
    function executor() external view returns(address);
    function set(bytes32 _key, uint256 _value) external;
    function get(bytes32 _key) external view returns(uint256);
}