pragma solidity ^0.4.23;

/// @title Energy presents the sub-token in vechain thor which conform VIP180(ERC20) standard.
/// The name of token is "VeThor" and 1 THOR equals to 1e18 wei. The main function of VeThor is to pay for the transaction fee. 
/// VeThor is generated from VET, so the initial supply of VeThor is zero in the genesis block.
/// The growth rate of VeThor is 5000000000 wei per token(VET) per second which means that 1 VET will produce about 0.000432 THOR per day.
/// The miner will charge 30 percent of transation fee and 70 percent will be burned. So the total supply of VeThor is dynamic.

interface Energy {
    //// @return TOKEN name: "VeThor".
    function name() external pure returns (string);

    /// @notice 1e18 wei equal to 1 THOR
    /// @return 18
    function decimals() external pure returns (uint8);

    /// @return "VTHO"
    function symbol() external pure returns (string);

    /// @return total supply of VeThor
    function totalSupply() external view returns (uint256);

    /// @return total amount of burned VeThor
    function totalBurned() external view returns(uint256);

    /// @return amount of VeThor in account _owner.
    function balanceOf(address _owner) external view returns (uint256 balance);

    /// @notice transfer _amount of VeThor from msg sender to account _to
    function transfer(address _to, uint256 _amount) external returns (bool success);

    /// @notice It's not VIP180(ERC20)'s standard method.
    /// transfer _amount of VeThor from account _from to account _to
    /// If account _from is external account, _from must be the msg sender, or
    /// if account _from is contract account, msg sender must be the master of contract _from.
    function move(address _from, address _to, uint256 _amount) external returns (bool success);

    /// @notice It's VIP180(ERC20)'s standard method
    function transferFrom(address _from, address _to, uint256 _amount) external returns(bool success);

    /// @notice It's VIP180(ERC20)'s standard method
    /// @return the remaining VeThor that _spender can transfer from _owner
    function allowance(address _owner, address _spender)  external view returns (uint256 remaining);

    /// @notice It's VIP180(ERC20)'s standard method which means approving a _value transfer to _spender from msg sender.
    function approve(address _spender, uint256 _value) external returns (bool success);
}
