pragma solidity ^0.4.23;

import "./prototype.sol";
import "./energy.sol";
import "./authority.sol";
import "./extension.sol";
import "./params.sol";
import "./executor.sol";

/**
 * @title Builtin
 * @dev The VeChainThor builtin contracts are encapsulated in library Builtin.
 * It's very easy to use it for the developer, just need import it.
 */
library Builtin {

    /// @return the instance of the contract "Authority".
    function getAuthority() internal pure returns(Authority) {
        return Authority(uint160(bytes9("Authority")));
    }

    /// @return the instance of the contract "Energy".
    function getEnergy() internal pure returns(Energy) {
        return Energy(uint160(bytes6("Energy")));
    }

    /// @return the instance of the contract "Extension".
    function getExtension() internal pure returns(Extension) {
        return Extension(uint160(bytes9("Extension")));
    }

    /// @return the instance of the contract "Params".
    function getParams() internal pure returns(Params) {
        return Params(uint160(bytes6("Params")));
    }

    /// @return the instance of the contract "Executor".
    function getExecutor() internal pure returns(Executor) {
        return Executor(uint160(bytes8("Executor")));
    }


    Energy constant energy = Energy(uint160(bytes6("Energy")));

    /// @return amount of VeThor in account 'self'.
    function $energy(address self) internal view returns(uint256 amount){
        return energy.balanceOf(self);
    }

    /// @notice transfer 'amount' of VeThor from msg sender to account 'self'.
    function $transferEnergy(address self, uint256 amount) internal{
        energy.transfer(self, amount);
    }

    /// @notice transfer 'amount' of VeThor from account 'self' to account 'to'.
    function $moveEnergyTo(address self, address to, uint256 amount) internal{
        energy.move(self, to, amount);
    }

    Prototype constant prototype = Prototype(uint160(bytes9("Prototype")));

    /// @return master address of self
    function $master(address self) internal view returns(address){
        return prototype.master(self);
    }

    /// @notice 'newMaster' will be set to contract 'self' and this function only works when msg sender is the old master.
    function $setMaster(address self, address newMaster) internal {
        prototype.setMaster(self, newMaster);
    }

    /// @return the amount of VET at blockNumber
    function $balance(address self, uint blockNumber) internal view returns(uint256){
        return prototype.balance(self, blockNumber);
    }

    /// @return the amount of energy at blockNumber
    function $energy(address self, uint blockNumber) internal view returns(uint256){
        return prototype.energy(self, blockNumber);
    }

    /// @notice 'self' check if address self is a contract account
    function $hasCode(address self) internal view returns(bool){
        return prototype.hasCode(self);
    }

    /// @return value indexed by key at self storage
    function $storageFor(address self, bytes32 key) internal view returns(bytes32){
        return prototype.storageFor(self, key);
    }

    /// @return the creditPlan of contract 'self'
    function $creditPlan(address self) internal view returns(uint256 credit, uint256 recoveryRate){
        return prototype.creditPlan(self);
    }

    /// @notice set creditPlan to contract 'self'
    function $setCreditPlan(address self, uint256 credit, uint256 recoveryRate) internal{
        prototype.setCreditPlan(self, credit, recoveryRate);
    }

    /// @notice check if address 'user' is the user of contract 'self'.
    function $isUser(address self, address user) internal view returns(bool){
        return prototype.isUser(self, user);
    }

    /// @notice return the current credit of 'user' of the contract 'self'.
    function $userCredit(address self, address user) internal view returns(uint256){
        return prototype.userCredit(self, user);
    }

    /// @notice add address 'user' to the user list of a contract 'self'.
    function $addUser(address self, address user) internal{
        prototype.addUser(self, user);
    }

    /// @notice remove 'user' from the user list of a contract 'self'.
    function $removeUser(address self, address user) internal{
        prototype.removeUser(self, user);
    }

    /// @notice check if 'sponsorAddress' is the sponser of contract 'self'.
    function $isSponsor(address self, address sponsor) internal view returns(bool){
        return prototype.isSponsor(self, sponsor);
    }

    /// @notice select 'sponsorAddress' to be current selected sponsor of contract 'self'
    function $selectSponsor(address self, address sponsor) internal{
        prototype.selectSponsor(self, sponsor);
    }

    /// @notice return current selected sponsor of contract 'self'
    function $currentSponsor(address self) internal view returns(address){
        return prototype.currentSponsor(self);
    }
}
