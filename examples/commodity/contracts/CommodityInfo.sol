pragma solidity ^0.4.23;

import "../../../contracts/builtin.sol";

/// @title CommodityInfo stores commodity information into a contract storage.
/// Just for example, the information of commodity is very simple and it includes id, originPlace, productionDate and shelfLife.
/// Only master or users of the contract have authority to add commodity information.

contract CommodityInfo {

    struct Item {
        // commodity id
        bytes id;

        // production origin place
        string originPlace;

        // production date
        uint productionDate;

        // shelf life
        uint shelfLife;
    }

    mapping(bytes32=>Item) Commodity;

    using Builtin for CommodityInfo;

    Extension extension = Builtin.getExtension();

    event AddCommodity(bytes id, string originPlace, uint productionDate, uint shelfLife);

    modifier onlyMasterOrUsers() {
        require(msg.sender == this.$master() || this.$isUser(msg.sender));
        _;
    }

    modifier onlyMaster() {
        require(msg.sender == this.$master());
        _;
    }

    /// @notice The user have the authority to add or modify commodity info.
    function addUser(address user) public onlyMaster {
        this.$addUser(user);
    }

    function removeUser(address user) public onlyMaster {
        this.$removeUser(user);
    }

    function setMaster(address master) public onlyMaster {
        this.$setMaster(master);
    }

    function setCreditPlan(uint256 credit, uint256 recoveryRate) public onlyMaster {
        this.$setCreditPlan(credit, recoveryRate);
    }

    function creditPlan() public view returns(uint256 credit, uint256 recoveryRate) {
        return this.$creditPlan();
    }

    /// @notice To check if account '_sponsor' is a sponsor.
    function isSponsor(address _sponsor) public view returns(bool) {
        return this.$isSponsor(_sponsor);
    }

    /// @notice The master or users will add an item of commodity info. 
    function addCommodityItem(bytes id, string originPlace, uint productionDate, uint shelfLife) public onlyMasterOrUsers {
        bytes32 key = extension.blake2b256(id);
        Commodity[key].id = id;
        Commodity[key].originPlace = originPlace;
        Commodity[key].productionDate = productionDate;
        Commodity[key].shelfLife = shelfLife;

        emit AddCommodity(id, originPlace, productionDate, shelfLife);
    }

    /// @notice To get commodity info from id.
    function getCommodityItem(bytes id) public view returns(string, uint, uint) {
        bytes32 key = extension.blake2b256(id);
        return(Commodity[key].originPlace, Commodity[key].productionDate, Commodity[key].shelfLife);
    }

    /// @notice To check if the commodity is expired.
    function isCommodityExpired(bytes id) public view returns(bool) {
        bytes32 key = extension.blake2b256(id);
        return Commodity[key].productionDate + Commodity[key].shelfLife >= now;
    }
}
