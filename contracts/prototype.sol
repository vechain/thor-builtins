pragma solidity ^0.4.23;

interface Prototype {
    function master(address self) external view returns(address);
    function setMaster(address self, address newMaster) external;
    function balance(address self, uint blockNumber) external view returns(uint256);
    function energy(address self, uint blockNumber) external view returns(uint256);
    function hasCode(address self) external view returns(bool);
    function storageFor(address self, bytes32 key) external view returns(bytes32);
    function userPlan(address self) external view returns(uint256 credit, uint256 recoveryRate);
    function setUserPlan(address self, uint256 credit, uint256 recoveryRate) external;
    function isUser(address self, address user) external view returns(bool);
    function userCredit(address self, address user) external view returns(uint256);
    function addUser(address self, address user) external;
    function removeUser(address self, address user) external;
    function sponsor(address self, bool yesOrNo) external;
    function isSponsor(address self, address sponsorAddress) external view returns(bool);
    function selectSponsor(address self, address sponsorAddress) external;  
    function currentSponsor(address self) external view returns(address);
}