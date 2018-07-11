pragma solidity ^0.4.23;

import "./prototype.sol";
import "./energy.sol";
import "./authority.sol";
import "./extension.sol";
import "./params.sol";
import "./voting.sol";
library Builtin {
    function getAuthority() internal pure returns(Authority) {
        return Authority(uint160(bytes9("Authority")));
    }

    function getEnergy() internal pure returns(Energy) {
        return Energy(uint160(bytes6("Energy")));
    }

    function getExtension() internal pure returns(Extension) {
        return Extension(uint160(bytes9("Extension")));
    }

    function getParams() internal pure returns(Params) {
        return Params(uint160(bytes6("Params")));
    }

    function getVoting() internal pure returns(Voting) {
        return Voting(uint160(bytes6("Voting")));
    }


    // 
    // energy
    //
    Energy constant energy = Energy(uint160(bytes6("Energy")));
    function $energy(address self) internal view returns(uint256 amount){
        return energy.balanceOf(self);
    }

    function $transferEnergy(address self, uint256 amount) internal{
        energy.transfer(self, amount);
    }

    function $moveEnergyTo(address self, address to, uint256 amount) internal{
        energy.move(self, to, amount);
    }

    //
    // prototype
    //
    Prototype constant prototype = Prototype(uint160(bytes9("Prototype")));
    function $master(address self) internal view returns(address){
        return prototype.master(self);
    }
    function $setMaster(address self, address newMaster) internal {
        prototype.setMaster(self, newMaster);
    }
    function $balance(address self, uint blockNumber) internal view returns(uint256){
        return prototype.balance(self, blockNumber);
    }
    function $energy(address self, uint blockNumber) internal view returns(uint256){
        return prototype.energy(self, blockNumber);
    }
    function $hasCode(address self) internal view returns(bool){
        return prototype.hasCode(self);
    }
    function $storageFor(address self, bytes32 key) internal view returns(bytes32){
        return prototype.storageFor(self, key);
    }
    function $userPlan(address self) internal view returns(uint256 credit, uint256 recoveryRate){
        return prototype.userPlan(self);
    }
    function $setUserPlan(address self, uint256 credit, uint256 recoveryRate) internal{
        prototype.setUserPlan(self, credit, recoveryRate);
    }
    function $isUser(address self, address user) internal view returns(bool){
        return prototype.isUser(self, user);
    }
    function $userCredit(address self, address user) internal view returns(uint256){
        return prototype.userCredit(self, user);
    }
    function $addUser(address self, address user) internal{
        prototype.addUser(self, user);
    }
    function $removeUser(address self, address user) internal{
        prototype.removeUser(self, user);
    }
    function $sponsor(address self, bool yesOrNo) internal{
        prototype.sponsor(self, yesOrNo);
    }
    function $isSponsor(address self, address sponsor) internal view returns(bool){
        return prototype.isSponsor(self, sponsor);
    }
    function $selectSponsor(address self, address sponsor) internal{
        prototype.selectSponsor(self, sponsor);
    }
    function $currentSponsor(address self) internal view returns(address){
        return prototype.currentSponsor(self);
    }
}
