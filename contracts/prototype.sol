pragma solidity ^0.4.23;

// Prototype means an account model in vechain thor.
// In the account model every contract has a master account which is the creator of a contract by default.
// The master account plays the role of management to a contract, which have some authority including 
// "setMaster", "setCreditPlan", "addUser", "removeUser" and "selectSponsor".
// Every contract keeps a list of users who can call the contract for free but limited by credit.
// The user is added also can be removed by the master.
// Although from the user's perspective the fee is free, it is paid by a sponsor of the contract.
// Any one can be a sponser of a contract, just by calling sponsor function, and also cancel it by calling unsponsor funtion.
// A contract may have more than one sponsors, but only the current sponsor need pay the fee for the contract.
// If the current sponsor is out of energy, master can select sponser from other sponsers by calling selectSponsor function.
// The creditPlane can be set by master which include credit and recoveryRate. Every user have the same original credit.
// Every Transaction will consume some amount of credit which equal to the fee of the Transaction, and the user may be pay the fee by itself
// if it out of the credit. But the credit can be recovery by the speed of recoveryRate per block.

interface Prototype {
    /// @param self contract address
    /// @return master address of self
    function master(address self) external view returns(address);

    /// @notice newMaster will be set to contract self and this calling only be from msg sender which must be the old master.
    /// @param self contract address
    /// @param newMaster new master account which will be set.
    function setMaster(address self, address newMaster) external;

    /// @param self account address which may be contract account or external account address.
    /// @param blockNumber balance will be calculated at blockNumber
    /// @return the amount of VET at blockNumber
    function balance(address self, uint blockNumber) external view returns(uint256);

    /// @param self account address which may be contract account or external account address.
    /// @param blockNumber energy will be calculated at blockNumber
    /// @return the amount of energy at blockNumber
    function energy(address self, uint blockNumber) external view returns(uint256);

    /// @param self check if address self is a contract account
    function hasCode(address self) external view returns(bool);

    /// @param self contract address
    /// @return value indexed by key at self storage
    function storageFor(address self, bytes32 key) external view returns(bytes32);

    /// @param self contract address
    /// @return the creditPlan of contract self
    function creditPlan(address self) external view returns(uint256 credit, uint256 recoveryRate);

    /// @param self contract address 
    /// @param credit original credit
    /// @param recoveryRate recovery rate of credit
    function setCreditPlan(address self, uint256 credit, uint256 recoveryRate) external;

    /// @notice check if address user is the user of contract self.
    function isUser(address self, address user) external view returns(bool);

    /// @notice return the current credit of user who is the user of contract self.
    function userCredit(address self, address user) external view returns(uint256);

    /// @notice add address user to the user list of a contract.
    function addUser(address self, address user) external;

    /// @notice remove user from the user list of a contract.
    function removeUser(address self, address user) external;

    /// @notice msg sender voluntary be a sponsor of the contract self.
    function sponsor(address self) external;

    /// @notice msg sender remove itself from the sponsors at contract self.
    function unsponsor(address self) external;

    /// @notice check if sponsorAddress is the sponser of contract self.
    function isSponsor(address self, address sponsorAddress) external view returns(bool);

    /// @notice select sponsorAddress to be current sponsor of contract self
    function selectSponsor(address self, address sponsorAddress) external;  

    /// @notice return current sponsor of contract self
    function currentSponsor(address self) external view returns(address);
}