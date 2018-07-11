pragma solidity ^0.4.23;

/// @title Energy an token that represents fuel for VET.
interface Energy {
    function name() external pure returns (string);
    function decimals() external pure returns (uint8);
    function symbol() external pure returns (string);
    function totalSupply() external view returns (uint256);
    function totalBurned() external view returns(uint256);
    function balanceOf(address _owner) external view returns (uint256 balance);
    function transfer(address _to, uint256 _amount) external returns (bool success);
    function move(address _from, address _to, uint256 _amount) external returns (bool success);
    function transferFrom(address _from, address _to, uint256 _amount) external returns(bool success);
    function allowance(address _owner, address _spender)  external view returns (uint256 remaining);
    function approve(address _spender, uint256 _value) external returns (bool success);
}
