<<<<<<< HEAD
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
=======
pragma solidity ^0.4.23;
>>>>>>> 2a3dd28256aface1c985f3944516b99604ded008

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
<<<<<<< HEAD
    /// @return the instance of the contract "Authority".
    function getAuthority() internal pure returns (address) {
        return address(bytes20(sha256(abi.encodePacked("Authority"))));
    }

    /// @return the instance of the contract "Energy".
    function getEnergy() internal pure returns (address) {
        return address(bytes20(sha256(abi.encodePacked("Energy"))));
    }

    /// @return the instance of the contract "Extension".
    function getExtension() internal pure returns (address) {
        return address(bytes20(sha256(abi.encodePacked(("Extension")))));
    }

    /// @return the instance of the contract "Params".
    function getParams() internal pure returns (address) {
        return address(bytes20(sha256(abi.encodePacked(("Params")))));
    }

    /// @return the instance of the contract "Executor".
    function getExecutor() internal pure returns (address) {
        return address(bytes20(sha256(abi.encodePacked(("address")))));
    }

    Energy constant energy =
        Energy(address(bytes20(sha256(abi.encodePacked((("Energy")))))));

    /// @return amount of VeThor in account 'self'.
    function $energy(address self) internal view returns (uint256 amount) {
=======

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
>>>>>>> 2a3dd28256aface1c985f3944516b99604ded008
        return energy.balanceOf(self);
    }

    /// @notice transfer 'amount' of VeThor from msg sender to account 'self'.
<<<<<<< HEAD
    function $transferEnergy(address self, uint256 amount) internal {
=======
    function $transferEnergy(address self, uint256 amount) internal{
>>>>>>> 2a3dd28256aface1c985f3944516b99604ded008
        energy.transfer(self, amount);
    }

    /// @notice transfer 'amount' of VeThor from account 'self' to account 'to'.
<<<<<<< HEAD
    function $moveEnergyTo(
        address self,
        address to,
        uint256 amount
    ) internal {
        energy.move(self, to, amount);
    }

    Prototype constant prototype =
        Prototype(address(bytes20(sha256(abi.encodePacked(("Prototype"))))));

    /// @return master address of self
    function $master(address self) internal view returns (address) {
=======
    function $moveEnergyTo(address self, address to, uint256 amount) internal{
        energy.move(self, to, amount);
    }

    Prototype constant prototype = Prototype(uint160(bytes9("Prototype")));

    /// @return master address of self
    function $master(address self) internal view returns(address){
>>>>>>> 2a3dd28256aface1c985f3944516b99604ded008
        return prototype.master(self);
    }

    /// @notice 'newMaster' will be set to contract 'self' and this function only works when msg sender is the old master.
    function $setMaster(address self, address newMaster) internal {
        prototype.setMaster(self, newMaster);
    }

    /// @return the amount of VET at blockNumber
<<<<<<< HEAD
    function $balance(address self, uint256 blockNumber)
        internal
        view
        returns (uint256)
    {
=======
    function $balance(address self, uint blockNumber) internal view returns(uint256){
>>>>>>> 2a3dd28256aface1c985f3944516b99604ded008
        return prototype.balance(self, blockNumber);
    }

    /// @return the amount of energy at blockNumber
<<<<<<< HEAD
    function $energy(address self, uint256 blockNumber)
        internal
        view
        returns (uint256)
    {
=======
    function $energy(address self, uint blockNumber) internal view returns(uint256){
>>>>>>> 2a3dd28256aface1c985f3944516b99604ded008
        return prototype.energy(self, blockNumber);
    }

    /// @notice 'self' check if address self is a contract account
<<<<<<< HEAD
    function $hasCode(address self) internal view returns (bool) {
=======
    function $hasCode(address self) internal view returns(bool){
>>>>>>> 2a3dd28256aface1c985f3944516b99604ded008
        return prototype.hasCode(self);
    }

    /// @return value indexed by key at self storage
<<<<<<< HEAD
    function $storageFor(address self, bytes32 key)
        internal
        view
        returns (bytes32)
    {
        return prototype.storageFor(self, key);
    }

    function $creditPlan(address self)
        internal
        view
        returns (uint256 credit, uint256 recoveryRate)
    {
=======
    function $storageFor(address self, bytes32 key) internal view returns(bytes32){
        return prototype.storageFor(self, key);
    }

    /// @return the creditPlan of contract 'self'
    function $creditPlan(address self) internal view returns(uint256 credit, uint256 recoveryRate){
>>>>>>> 2a3dd28256aface1c985f3944516b99604ded008
        return prototype.creditPlan(self);
    }

    /// @notice set creditPlan to contract 'self'
<<<<<<< HEAD
    function $setCreditPlan(
        address self,
        uint256 credit,
        uint256 recoveryRate
    ) internal {
=======
    function $setCreditPlan(address self, uint256 credit, uint256 recoveryRate) internal{
>>>>>>> 2a3dd28256aface1c985f3944516b99604ded008
        prototype.setCreditPlan(self, credit, recoveryRate);
    }

    /// @notice check if address 'user' is the user of contract 'self'.
<<<<<<< HEAD
    function $isUser(address self, address user) internal view returns (bool) {
=======
    function $isUser(address self, address user) internal view returns(bool){
>>>>>>> 2a3dd28256aface1c985f3944516b99604ded008
        return prototype.isUser(self, user);
    }

    /// @notice return the current credit of 'user' of the contract 'self'.
<<<<<<< HEAD
    function $userCredit(address self, address user)
        internal
        view
        returns (uint256)
    {
=======
    function $userCredit(address self, address user) internal view returns(uint256){
>>>>>>> 2a3dd28256aface1c985f3944516b99604ded008
        return prototype.userCredit(self, user);
    }

    /// @notice add address 'user' to the user list of a contract 'self'.
<<<<<<< HEAD
    function $addUser(address self, address user) internal {
=======
    function $addUser(address self, address user) internal{
>>>>>>> 2a3dd28256aface1c985f3944516b99604ded008
        prototype.addUser(self, user);
    }

    /// @notice remove 'user' from the user list of a contract 'self'.
<<<<<<< HEAD
    function $removeUser(address self, address user) internal {
=======
    function $removeUser(address self, address user) internal{
>>>>>>> 2a3dd28256aface1c985f3944516b99604ded008
        prototype.removeUser(self, user);
    }

    /// @notice check if 'sponsorAddress' is the sponser of contract 'self'.
<<<<<<< HEAD
    function $isSponsor(address self, address sponsor)
        internal
        view
        returns (bool)
    {
=======
    function $isSponsor(address self, address sponsor) internal view returns(bool){
>>>>>>> 2a3dd28256aface1c985f3944516b99604ded008
        return prototype.isSponsor(self, sponsor);
    }

    /// @notice select 'sponsorAddress' to be current selected sponsor of contract 'self'
<<<<<<< HEAD
    function $selectSponsor(address self, address sponsor) internal {
=======
    function $selectSponsor(address self, address sponsor) internal{
>>>>>>> 2a3dd28256aface1c985f3944516b99604ded008
        prototype.selectSponsor(self, sponsor);
    }

    /// @notice return current selected sponsor of contract 'self'
<<<<<<< HEAD
    function $currentSponsor(address self) internal view returns (address) {
=======
    function $currentSponsor(address self) internal view returns(address){
>>>>>>> 2a3dd28256aface1c985f3944516b99604ded008
        return prototype.currentSponsor(self);
    }
}
